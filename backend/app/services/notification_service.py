import uuid
from datetime import datetime, timezone
from typing import Optional, List, Dict, Any
from app.core.firebase import get_firestore


class NotificationService:
    def __init__(self):
        self.db = get_firestore()

    def _now_iso(self) -> str:
        return datetime.now(timezone.utc).isoformat()

    def _format_date_label(self, dt_iso: Optional[str] = None) -> str:
        try:
            if not dt_iso:
                dt = datetime.now(timezone.utc)
            else:
                dt = datetime.fromisoformat(dt_iso.replace("Z", "+00:00"))
            return dt.strftime("%b %d, %I:%M %p")
        except Exception:
            return "Just now"

    async def create_notification(
        self,
        uid: str,
        title: str,
        description: str,
        notification_type: str = "system",
        icon: Optional[str] = None,
        icon_color: Optional[str] = None,
    ) -> Dict[str, Any]:
        """Creates a persistent notification under /users/{uid}/notifications/{id}."""
        notif_id = uuid.uuid4().hex
        now = self._now_iso()
        date_label = self._format_date_label(now)

        doc_data = {
            "id": notif_id,
            "uid": uid,
            "title": title,
            "description": description,
            "type": notification_type,
            "icon": icon or "",
            "iconColor": icon_color or "",
            "dateLabel": date_label,
            "isUnread": True,
            "createdAt": now,
            "updatedAt": now,
        }

        self.db.collection("users").document(uid).collection("notifications").document(notif_id).set(doc_data)
        return self._format_notification(doc_data)

    async def get_user_notifications(self, uid: str, limit: int = 50) -> Dict[str, Any]:
        """Fetches notifications for a user, sorted with newest first."""
        notifs_ref = self.db.collection("users").document(uid).collection("notifications")
        docs = notifs_ref.order_by("createdAt", direction="DESCENDING").limit(limit).stream()

        results = [self._format_notification(d.to_dict()) for d in docs]

        # If user has no notifications yet, seed default onboard notifications
        if not results:
            welcome_notif = await self.create_notification(
                uid=uid,
                title="Welcome to Trouble-Cheat Security",
                description="Your personal protection profile is ready. Configure your safety timers and emergency contacts.",
                notification_type="system",
                icon_color="#10B981",
            )
            results = [welcome_notif]

        unread_count = sum(1 for n in results if n.get("is_unread"))

        return {
            "total": len(results),
            "unread_count": unread_count,
            "notifications": results,
        }

    async def mark_as_read(self, uid: str, notification_id: str) -> bool:
        """Marks a single notification as read."""
        doc_ref = self.db.collection("users").document(uid).collection("notifications").document(notification_id)
        if doc_ref.get().exists:
            doc_ref.update({"isUnread": False, "updatedAt": self._now_iso()})
            return True
        return False

    async def mark_all_read(self, uid: str) -> int:
        """Marks all notifications for a user as read."""
        notifs_ref = self.db.collection("users").document(uid).collection("notifications")
        docs = notifs_ref.where("isUnread", "==", True).stream()

        count = 0
        batch = self.db.batch()
        for doc in docs:
            batch.update(doc.reference, {"isUnread": False, "updatedAt": self._now_iso()})
            count += 1

        if count > 0:
            batch.commit()

        return count

    def _format_notification(self, data: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "id": data.get("id", ""),
            "uid": data.get("uid", ""),
            "title": data.get("title", ""),
            "description": data.get("description", ""),
            "type": data.get("type", "system"),
            "icon": data.get("icon", ""),
            "icon_color": data.get("iconColor", data.get("icon_color", "")),
            "date_label": data.get("dateLabel", data.get("date_label", "Recent")),
            "is_unread": data.get("isUnread", data.get("is_unread", False)),
            "created_at": data.get("createdAt", data.get("created_at", "")),
        }


notification_service = NotificationService()
