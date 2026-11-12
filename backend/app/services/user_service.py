import httpx
from datetime import datetime, timezone
from typing import Optional, List, Dict, Any
from fastapi import HTTPException, status
from app.core.config import settings
from app.core.firebase import get_auth, get_firestore
from app.schemas.user import UserCreate, UserSignIn, UserUpdate, UserProfileResponse


class UserService:
    def __init__(self):
        self.auth = get_auth()
        self.db = get_firestore()

    def _now_iso(self) -> str:
        return datetime.now(timezone.utc).isoformat()

    async def create_user(self, data: UserCreate) -> Dict[str, Any]:
        """Creates a user in Firebase Auth and writes their initial document to Firestore."""
        # 1. Clean and normalize phone number
        phone_number = data.phone_number.strip() if data.phone_number else None
        if phone_number == "":
            phone_number = None
        elif phone_number and not phone_number.startswith("+"):
            # Prepend + if country code digits were entered without +
            if not phone_number.startswith("0"):
                phone_number = f"+{phone_number}"

        # 2. Create in Firebase Auth
        try:
            user_record = self.auth.create_user(
                email=data.email,
                password=data.password,
                display_name=data.full_name,
                phone_number=phone_number,
            )
        except Exception as e:
            error_str = str(e)
            if "EMAIL_EXISTS" in error_str or "email already exists" in error_str.lower():
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="An account with this email already exists.",
                )
            if "phone number" in error_str.lower() or "e.164" in error_str.lower():
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Invalid phone number. Please include your country code starting with '+' (e.g. +14155552671).",
                )
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Firebase Auth error: {error_str}",
            )

        uid = user_record.uid
        now = self._now_iso()

        # 2. Write /users/{uid} document in Firestore
        user_doc = {
            "uid": uid,
            "email": data.email,
            "fullName": data.full_name,
            "phoneNumber": data.phone_number or "",
            "subscriptionPlan": data.subscription_plan,
            "avatarUrl": "",
            "emergencyMessage": "Help! I am in danger. Please find my location.",
            "emergencyPhrase": "",
            "isEmailVerified": False,
            "isPhoneVerified": False,
            "createdAt": now,
            "updatedAt": now,
        }

        try:
            self.db.collection("users").document(uid).set(user_doc)
        except Exception as e:
            # Cleanup auth record if Firestore write fails
            self.auth.delete_user(uid)
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Failed to create user profile in Firestore: {str(e)}",
            )

        # 3. Obtain an ID token for the newly created user
        access_token = None
        try:
            if settings.USE_FIREBASE_EMULATOR:
                auth_url = f"http://{settings.FIREBASE_AUTH_EMULATOR_HOST}/identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=fake-emulator-key"
            else:
                auth_url = f"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={settings.FIREBASE_WEB_API_KEY}"
            async with httpx.AsyncClient() as client:
                resp = await client.post(
                    auth_url,
                    json={
                        "email": data.email,
                        "password": data.password,
                        "returnSecureToken": True,
                    },
                )
                if resp.status_code == 200:
                    access_token = resp.json().get("idToken")
        except Exception:
            pass

        if not access_token:
            access_token = self.auth.create_custom_token(uid).decode("utf-8")

        return {
            "access_token": access_token,
            "token_type": "bearer",
            "user": self._format_profile(user_doc),
        }

    async def sign_in_user(self, data: UserSignIn) -> Dict[str, Any]:
        """
        Signs in user via Firebase Auth REST API (supports emulator host transparently).
        Returns the ID token and user profile.
        """
        if settings.USE_FIREBASE_EMULATOR:
            url = f"http://{settings.FIREBASE_AUTH_EMULATOR_HOST}/identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=fake-emulator-key"
        else:
            url = f"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={settings.FIREBASE_WEB_API_KEY}"

        payload = {
            "email": data.email,
            "password": data.password,
            "returnSecureToken": True,
        }

        async with httpx.AsyncClient() as client:
            resp = await client.post(url, json=payload)

        if resp.status_code != 200:
            error_msg = resp.json().get("error", {}).get("message", "INVALID_LOGIN_CREDENTIALS")
            if "EMAIL_NOT_FOUND" in error_msg or "INVALID_PASSWORD" in error_msg or "INVALID_LOGIN_CREDENTIALS" in error_msg:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Invalid email or password.",
                )
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Sign-in failed: {error_msg}",
            )

        resp_data = resp.json()
        id_token = resp_data["idToken"]
        uid = resp_data["localId"]

        # Fetch or auto-create Firestore user profile
        user_doc_ref = self.db.collection("users").document(uid)
        doc = user_doc_ref.get()

        if not doc.exists:
            # Create default profile if missing
            now = self._now_iso()
            user_data = {
                "uid": uid,
                "email": data.email,
                "fullName": resp_data.get("displayName", data.email.split("@")[0]),
                "phoneNumber": "",
                "subscriptionPlan": "free",
                "avatarUrl": "",
                "emergencyMessage": "Help! I am in danger. Please find my location.",
                "emergencyPhrase": "",
                "isEmailVerified": False,
                "createdAt": now,
                "updatedAt": now,
            }
            user_doc_ref.set(user_data)
        else:
            user_data = doc.to_dict()

        return {
            "access_token": id_token,
            "token_type": "bearer",
            "user": self._format_profile(user_data),
        }

    async def get_user_by_uid(self, uid: str) -> Dict[str, Any]:
        doc = self.db.collection("users").document(uid).get()
        if not doc.exists:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"User with uid '{uid}' not found.",
            )
        return self._format_profile(doc.to_dict())

    async def update_user(self, uid: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        user_doc_ref = self.db.collection("users").document(uid)
        doc = user_doc_ref.get()
        if not doc.exists:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail=f"User with uid '{uid}' not found.",
            )

        clean_updates = {k: v for k, v in updates.items() if v is not None}
        clean_updates["updatedAt"] = self._now_iso()

        user_doc_ref.update(clean_updates)
        updated_doc = user_doc_ref.get().to_dict()
        return self._format_profile(updated_doc)

    async def list_users(self, limit: int = 50) -> List[Dict[str, Any]]:
        """List users for admin portal."""
        docs = self.db.collection("users").limit(limit).stream()
        return [self._format_profile(d.to_dict()) for d in docs]

    def _format_profile(self, data: Dict[str, Any]) -> Dict[str, Any]:
        return {
            "uid": data.get("uid", ""),
            "email": data.get("email", ""),
            "full_name": data.get("fullName", data.get("full_name", "")),
            "phone_number": data.get("phoneNumber", data.get("phone_number", "")),
            "subscription_plan": data.get("subscriptionPlan", data.get("subscription_plan", "free")),
            "avatar_url": data.get("avatarUrl", data.get("avatar_url", "")),
            "emergency_message": data.get("emergencyMessage", data.get("emergency_message", "")),
            "emergency_phrase": data.get("emergencyPhrase", data.get("emergency_phrase", "")),
            "is_email_verified": data.get("isEmailVerified", data.get("is_email_verified", False)),
            "is_phone_verified": data.get("isPhoneVerified", data.get("is_phone_verified", False)),
            "created_at": data.get("createdAt", data.get("created_at")),
            "updated_at": data.get("updatedAt", data.get("updated_at")),
        }


user_service = UserService()
