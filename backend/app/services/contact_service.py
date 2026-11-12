import uuid
from datetime import datetime, timezone
from typing import List, Dict, Any, Optional
from fastapi import HTTPException, status
from app.core.firebase import get_firestore
from app.core.entitlements import get_plan_entitlements
from app.services.user_service import user_service
from app.services.notification_service import notification_service
from app.schemas.contact import ContactCreate, ContactUpdate, ContactResponse


class ContactService:
    def __init__(self):
        self.db = get_firestore()

    def _now_iso(self) -> str:
        return datetime.now(timezone.utc).isoformat()

    async def list_contacts(self, uid: str) -> List[Dict[str, Any]]:
        """List all emergency contacts for a given user."""
        contacts_ref = self.db.collection("users").document(uid).collection("contacts")
        docs = contacts_ref.order_by("created_at").stream()
        return [doc.to_dict() for doc in docs]

    async def create_contact(self, uid: str, data: ContactCreate) -> Dict[str, Any]:
        """Creates an emergency contact for the user, strictly enforcing subscription limits."""
        # 1. Fetch user to check subscription plan
        user_profile = await user_service.get_user_by_uid(uid)
        plan_name = user_profile.get("subscription_plan", "free")
        entitlements = get_plan_entitlements(plan_name)

        # 2. Count existing contacts
        existing = await self.list_contacts(uid)
        if len(existing) >= entitlements.max_contacts:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=(
                    f"Your {entitlements.plan_name.title()} Plan allows a maximum of "
                    f"{entitlements.max_contacts} emergency contact{'s' if entitlements.max_contacts > 1 else ''}. "
                    "Upgrade to Standard for up to 4 contacts, or Premium for 7 contacts."
                ),
            )

        # 3. Clean phone number
        phone = data.phone_number.strip()
        if not phone.startswith("+") and not phone.startswith("0"):
            phone = f"+{phone}"

        contact_id = str(uuid.uuid4())
        now = self._now_iso()

        contact_doc = {
            "id": contact_id,
            "uid": uid,
            "full_name": data.full_name.strip(),
            "phone_number": phone,
            "relationship": data.relationship,
            "email": str(data.email) if data.email else None,
            "allow_gps": data.allow_gps,
            "allow_audio": data.allow_audio,
            "allow_video": data.allow_video,
            "created_at": now,
            "updated_at": now,
        }

        self.db.collection("users").document(uid).collection("contacts").document(contact_id).set(contact_doc)

        try:
            await notification_service.create_notification(
                uid=uid,
                title="New Contact Added",
                description=f"{data.full_name.strip()} was added to your emergency circle.",
                notification_type="contact",
                icon_color="#3B82F6",
            )
        except Exception as e:
            print(f"[ContactService] Notification notice: {e}")

        return contact_doc

    async def get_contact(self, uid: str, contact_id: str) -> Dict[str, Any]:
        doc = self.db.collection("users").document(uid).collection("contacts").document(contact_id).get()
        if not doc.exists:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Emergency contact not found.",
            )
        return doc.to_dict()

    async def update_contact(self, uid: str, contact_id: str, data: ContactUpdate) -> Dict[str, Any]:
        doc_ref = self.db.collection("users").document(uid).collection("contacts").document(contact_id)
        if not doc_ref.get().exists:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Emergency contact not found.",
            )

        updates = {"updated_at": self._now_iso()}
        if data.full_name is not None:
            updates["full_name"] = data.full_name.strip()
        if data.phone_number is not None:
            phone = data.phone_number.strip()
            if not phone.startswith("+") and not phone.startswith("0"):
                phone = f"+{phone}"
            updates["phone_number"] = phone
        if data.relationship is not None:
            updates["relationship"] = data.relationship
        if data.email is not None:
            updates["email"] = str(data.email)
        if data.allow_gps is not None:
            updates["allow_gps"] = data.allow_gps
        if data.allow_audio is not None:
            updates["allow_audio"] = data.allow_audio
        if data.allow_video is not None:
            updates["allow_video"] = data.allow_video

        doc_ref.update(updates)
        return doc_ref.get().to_dict()

    async def delete_contact(self, uid: str, contact_id: str) -> Dict[str, Any]:
        doc_ref = self.db.collection("users").document(uid).collection("contacts").document(contact_id)
        if not doc_ref.get().exists:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Emergency contact not found.",
            )
        doc_ref.delete()
        return {"status": "success", "message": "Contact deleted successfully."}


contact_service = ContactService()
