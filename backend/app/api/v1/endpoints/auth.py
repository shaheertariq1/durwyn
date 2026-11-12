from typing import Dict, Any, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from app.schemas.user import (
    UserCreate,
    UserSignIn,
    TokenResponse,
    UserProfileResponse,
    PhoneSendCodeRequest,
    PhoneVerifyCodeRequest,
    PhoneCodeResponse,
)
from app.services.user_service import user_service
from app.services.phone_auth_service import phone_auth_service
from app.api.deps import get_current_user, get_optional_current_user

router = APIRouter()


@router.post("/signup", response_model=TokenResponse, status_code=status.HTTP_201_CREATED)
async def signup(data: UserCreate):
    """
    Creates a new user in Firebase Auth and sets up their initial Firestore profile.
    Returns the user data and access token.
    """
    res = await user_service.create_user(data)
    # Also initiate phone verification code send
    if data.phone_number and data.phone_number.strip():
        try:
            uid = res.get("user", {}).get("uid")
            await phone_auth_service.send_code(phone_number=data.phone_number, user_uid=uid)
        except Exception as e:
            print(f"[AuthSignup] Phone send_code notice: {e}")
    return res


@router.post("/signin", response_model=TokenResponse)
async def signin(data: UserSignIn):
    """
    Authenticates a user via Firebase Auth (emulator or cloud),
    and returns their Firebase ID token and Firestore profile.
    """
    return await user_service.sign_in_user(data)


@router.get("/me", response_model=UserProfileResponse)
async def get_me(current_user: Dict[str, Any] = Depends(get_current_user)):
    """
    Returns the current authenticated user's profile.
    Requires Bearer token in Authorization header.
    """
    return current_user


@router.post("/phone/send-code", response_model=PhoneCodeResponse)
async def phone_send_code(
    data: PhoneSendCodeRequest,
    current_user: Optional[Dict[str, Any]] = Depends(get_optional_current_user),
):
    """
    Sends an SMS verification code to the specified phone number.
    Uses Firebase Auth sendVerificationCode when enabled, with Firestore OTP session.
    """
    uid = current_user.get("uid") if current_user else None
    return await phone_auth_service.send_code(phone_number=data.phone_number, user_uid=uid)


@router.post("/phone/verify-code", response_model=PhoneCodeResponse)
async def phone_verify_code(
    data: PhoneVerifyCodeRequest,
    current_user: Optional[Dict[str, Any]] = Depends(get_optional_current_user),
):
    """
    Verifies the 6-digit phone code against Firebase or stored OTP.
    Marks user profile as isPhoneVerified=True in Firestore.
    """
    uid = current_user.get("uid") if current_user else None
    return await phone_auth_service.verify_code(
        phone_number=data.phone_number,
        code=data.code,
        session_id=data.session_id,
        user_uid=uid,
    )


@router.post("/phone/resend-code", response_model=PhoneCodeResponse)
async def phone_resend_code(
    data: PhoneSendCodeRequest,
    current_user: Optional[Dict[str, Any]] = Depends(get_optional_current_user),
):
    """
    Resends an SMS verification code to the phone number.
    """
    uid = current_user.get("uid") if current_user else None
    return await phone_auth_service.send_code(phone_number=data.phone_number, user_uid=uid)

