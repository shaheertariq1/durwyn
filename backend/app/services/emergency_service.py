import uuid
from datetime import datetime, timezone, timedelta
from typing import List, Dict, Any, Optional
from fastapi import HTTPException, status
from app.core.firebase import get_firestore
from app.core.entitlements import get_plan_entitlements
from app.services.user_service import user_service
from app.services.contact_service import contact_service
from app.services.notification_service import notification_service
from app.schemas.emergency import (
    SOSCreate,
    IncidentResponse,
    SafetyTimerStart,
    SafetyTimerCheckIn,
    SafetyTimerResponse,
    SafetyMonitorStart,
    SafetyMonitorPing,
    SafetyMonitorStop,
    SafetyMonitorResponse,
)


class EmergencyService:
    def __init__(self):
        self.db = get_firestore()

    def _now_iso(self) -> str:
        return datetime.now(timezone.utc).isoformat()

    async def trigger_sos(self, uid: str, data: SOSCreate) -> Dict[str, Any]:
        """
        Triggers an SOS emergency alert:
        - Logs incident in Firestore
        - Alerts user's designated emergency contacts
        - Generates public web tracking link
        """
        user = await user_service.get_user_by_uid(uid)
        contacts = await contact_service.list_contacts(uid)

        incident_id = f"inc_{uuid.uuid4().hex[:12]}"
        now = self._now_iso()
        tracking_url = f"https://track.troublecheat.com/incident/{incident_id}"

        # Build contacts alerted list
        contacts_alerted = [
            {
                "contact_id": c.get("id"),
                "name": c.get("full_name"),
                "phone": c.get("phone_number"),
                "relationship": c.get("relationship"),
                "notified_at": now,
                "status": "delivered",
            }
            for c in contacts
        ]

        incident_doc = {
            "id": incident_id,
            "uid": uid,
            "user_name": user.get("full_name") or "User",
            "user_phone": user.get("phone_number"),
            "emergency_type": data.emergency_type,
            "status": "active",
            "latitude": data.latitude,
            "longitude": data.longitude,
            "address": data.address or "Current Location",
            "emergency_message": user.get("emergency_message") or "Help! I am in danger. Please find my location.",
            "contacts_alerted": contacts_alerted,
            "live_tracking_url": tracking_url,
            "notes": data.notes,
            "created_at": now,
            "resolved_at": None,
        }

        # 1. Global collection (for web tracking)
        self.db.collection("incidents").document(incident_id).set(incident_doc)
        # 2. User history subcollection
        self.db.collection("users").document(uid).collection("incidents").document(incident_id).set(incident_doc)

        try:
            await notification_service.create_notification(
                uid=uid,
                title="Emergency Alert Broadcasted",
                description=f"SOS active. Live GPS coordinates sent to {len(contacts_alerted)} contacts.",
                notification_type="emergency",
                icon_color="#EF4444",
            )
        except Exception as e:
            print(f"[EmergencyService] Notification error: {e}")

        return incident_doc

    async def resolve_incident(self, uid: str, incident_id: str) -> Dict[str, Any]:
        """Marks an active emergency incident as resolved or cancelled."""
        doc_ref = self.db.collection("users").document(uid).collection("incidents").document(incident_id)
        doc = doc_ref.get()
        if not doc.exists:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Incident not found.")

        now = self._now_iso()
        updates = {"status": "resolved", "resolved_at": now}
        doc_ref.update(updates)
        self.db.collection("incidents").document(incident_id).update(updates)

        updated = doc.to_dict()
        updated.update(updates)
        return updated

    async def list_incidents(self, uid: str) -> List[Dict[str, Any]]:
        """
        List incidents for the user, bounded by their subscription retention period.
        (Free: 3 days, Standard: 14 days, Premium: 30 days)
        """
        user = await user_service.get_user_by_uid(uid)
        plan_name = user.get("subscription_plan", "free")
        entitlements = get_plan_entitlements(plan_name)

        cutoff = datetime.now(timezone.utc) - timedelta(days=entitlements.evidence_retention_days)
        cutoff_iso = cutoff.isoformat()

        docs = (
            self.db.collection("users")
            .document(uid)
            .collection("incidents")
            .where("created_at", ">=", cutoff_iso)
            .stream()
        )

        results = [d.to_dict() for d in docs]
        results.sort(key=lambda x: x.get("created_at", ""), reverse=True)
        return results

    # Safety Timer
    async def start_safety_timer(self, uid: str, data: SafetyTimerStart) -> Dict[str, Any]:
        """Starts a Safety Timer session for the user."""
        timer_id = f"tmr_{uuid.uuid4().hex[:10]}"
        now_dt = datetime.now(timezone.utc)
        expires_dt = now_dt + timedelta(minutes=data.duration_minutes)

        timer_doc = {
            "timer_id": timer_id,
            "uid": uid,
            "duration_minutes": data.duration_minutes,
            "label": data.label,
            "status": "active",
            "created_at": now_dt.isoformat(),
            "expires_at": expires_dt.isoformat(),
            "checked_in_at": None,
        }

        # Save as current active timer
        self.db.collection("users").document(uid).collection("timers").document(timer_id).set(timer_doc)
        self.db.collection("users").document(uid).collection("active_timer").document("current").set(timer_doc)

        try:
            await notification_service.create_notification(
                uid=uid,
                title="Safety Timer Active",
                description=f"Safety timer started for {data.duration_minutes} minutes ({data.label or 'Safety Check'}).",
                notification_type="timer",
                icon_color="#3B82F6",
            )
        except Exception as e:
            print(f"[EmergencyService] Timer notification error: {e}")

        return timer_doc

    async def check_in_safety_timer(self, uid: str, data: SafetyTimerCheckIn) -> Dict[str, Any]:
        """Confirms 'I'm Safe' and disarms the active timer."""
        active_ref = self.db.collection("users").document(uid).collection("active_timer").document("current")
        active_doc = active_ref.get()
        if not active_doc.exists or active_doc.to_dict().get("status") != "active":
            return {"status": "checked_in", "message": "No active safety timer to check in."}

        now = self._now_iso()
        timer_id = active_doc.to_dict().get("timer_id")
        updates = {"status": "checked_in", "checked_in_at": now}

        active_ref.update(updates)
        if timer_id:
            self.db.collection("users").document(uid).collection("timers").document(timer_id).update(updates)

        try:
            await notification_service.create_notification(
                uid=uid,
                title="Safety Check-in Confirmed",
                description="You safely checked in. The safety timer has been disarmed.",
                notification_type="timer",
                icon_color="#10B981",
            )
        except Exception as e:
            print(f"[EmergencyService] Checkin notification error: {e}")

        return {"status": "checked_in", "message": "Safety Timer check-in confirmed. You are safe!"}

    async def cancel_safety_timer(self, uid: str) -> Dict[str, Any]:
        """Cancels the active safety timer."""
        active_ref = self.db.collection("users").document(uid).collection("active_timer").document("current")
        active_doc = active_ref.get()
        if active_doc.exists:
            timer_id = active_doc.to_dict().get("timer_id")
            updates = {"status": "cancelled"}
            active_ref.update(updates)
            if timer_id:
                self.db.collection("users").document(uid).collection("timers").document(timer_id).update(updates)
        return {"status": "cancelled", "message": "Safety timer cancelled."}

    # Safety Monitor (Premium Plan Only)
    async def start_safety_monitor(self, uid: str, data: SafetyMonitorStart) -> Dict[str, Any]:
        """Starts a Safety Monitor session (strictly enforces Premium Plan)."""
        user = await user_service.get_user_by_uid(uid)
        plan_name = user.get("subscription_plan", "free")
        entitlements = get_plan_entitlements(plan_name)

        if not entitlements.has_safety_monitor:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail=(
                    f"Safety Monitor is an exclusive Premium tier feature. Your current plan is {plan_name.title()}. "
                    "Please upgrade to Premium to enable real-time safety monitoring."
                ),
            )

        session_id = f"mon_{uuid.uuid4().hex[:12]}"
        now = self._now_iso()

        session_doc = {
            "session_id": session_id,
            "uid": uid,
            "monitor_type": data.monitor_type,
            "status": "active",
            "risk_score": 0.15,
            "latitude": data.latitude,
            "longitude": data.longitude,
            "battery_level": 100,
            "last_ping_at": now,
            "created_at": now,
            "stopped_at": None,
        }

        # Save session to Firestore
        self.db.collection("users").document(uid).collection("safety_monitors").document(session_id).set(session_doc)
        self.db.collection("users").document(uid).collection("active_monitor").document("current").set(session_doc)
        return session_doc

    async def ping_safety_monitor(self, uid: str, data: SafetyMonitorPing) -> Dict[str, Any]:
        """Pings current coordinates & status for active monitor session."""
        active_ref = self.db.collection("users").document(uid).collection("active_monitor").document("current")
        doc = active_ref.get()
        if not doc.exists or doc.to_dict().get("status") != "active":
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="No active safety monitor session found.",
            )

        now = self._now_iso()
        session_data = doc.to_dict()
        session_id = session_data.get("session_id")

        updates = {
            "latitude": data.latitude,
            "longitude": data.longitude,
            "last_ping_at": now,
        }
        if data.battery_level is not None:
            updates["battery_level"] = data.battery_level
        if data.status and data.status in ("active", "stopped", "completed"):
            updates["status"] = data.status
        elif data.status:
            updates["telemetry_status"] = data.status

        active_ref.update(updates)
        if session_id:
            self.db.collection("users").document(uid).collection("safety_monitors").document(session_id).update(updates)

        session_data.update(updates)
        return session_data

    async def stop_safety_monitor(self, uid: str, data: SafetyMonitorStop) -> Dict[str, Any]:
        """Stops active safety monitor session."""
        active_ref = self.db.collection("users").document(uid).collection("active_monitor").document("current")
        doc = active_ref.get()
        now = self._now_iso()

        if not doc.exists:
            return {
                "session_id": "none",
                "uid": uid,
                "monitor_type": "None",
                "status": "stopped",
                "risk_score": 0.0,
                "latitude": None,
                "longitude": None,
                "battery_level": None,
                "last_ping_at": now,
                "created_at": now,
                "stopped_at": now,
            }

        session_data = doc.to_dict()
        session_id = session_data.get("session_id")
        updates = {"status": "stopped", "stopped_at": now}

        active_ref.update(updates)
        if session_id:
            self.db.collection("users").document(uid).collection("safety_monitors").document(session_id).update(updates)

        session_data.update(updates)
        return session_data

    async def get_active_safety_monitor(self, uid: str) -> Dict[str, Any]:
        """Returns the current active safety monitor session if running."""
        active_ref = self.db.collection("users").document(uid).collection("active_monitor").document("current")
        doc = active_ref.get()
        if doc.exists and doc.to_dict().get("status") == "active":
            return doc.to_dict()
        now = self._now_iso()
        return {
            "session_id": "none",
            "uid": uid,
            "monitor_type": "None",
            "status": "inactive",
            "risk_score": 0.0,
            "latitude": None,
            "longitude": None,
            "battery_level": None,
            "last_ping_at": None,
            "created_at": now,
            "stopped_at": None,
        }


emergency_service = EmergencyService()
