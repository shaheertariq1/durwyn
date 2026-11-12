from typing import Optional, List
from datetime import datetime
from pydantic import BaseModel, EmailStr, Field


class UserBase(BaseModel):
    email: EmailStr
    full_name: str
    phone_number: Optional[str] = None


class UserCreate(UserBase):
    password: str = Field(..., min_length=6, description="Password min length 6")
    subscription_plan: str = Field(default="free", description="'free' | 'standard' | 'premium'")


class UserSignIn(BaseModel):
    email: EmailStr
    password: str


class UserUpdate(BaseModel):
    full_name: Optional[str] = None
    phone_number: Optional[str] = None
    avatar_url: Optional[str] = None
    emergency_message: Optional[str] = None
    emergency_phrase: Optional[str] = None
    subscription_plan: Optional[str] = None


class PlanUpdate(BaseModel):
    subscription_plan: str = Field(..., description="'free' | 'standard' | 'premium'")


class EmergencySettingsUpdate(BaseModel):
    emergency_message: Optional[str] = None
    emergency_phrase: Optional[str] = None


class UserProfileResponse(BaseModel):
    uid: str
    email: str
    full_name: str
    phone_number: Optional[str] = None
    subscription_plan: str = "free"
    avatar_url: Optional[str] = None
    emergency_message: Optional[str] = None
    emergency_phrase: Optional[str] = None
    is_email_verified: bool = False
    is_phone_verified: bool = False
    created_at: Optional[str] = None
    updated_at: Optional[str] = None


class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    user: UserProfileResponse


class HealthResponse(BaseModel):
    status: str
    project: str
    emulators_enabled: bool
    timestamp: str


class PhoneSendCodeRequest(BaseModel):
    phone_number: str = Field(..., description="E.164 format phone number, e.g. +14155552671")


class PhoneVerifyCodeRequest(BaseModel):
    phone_number: str = Field(..., description="E.164 format phone number")
    code: str = Field(..., min_length=4, max_length=10, description="Verification code")
    session_id: Optional[str] = None


class PhoneCodeResponse(BaseModel):
    status: str
    phone_number: str
    session_id: Optional[str] = None
    message: str
    is_verified: bool = False

