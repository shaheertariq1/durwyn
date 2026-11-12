from typing import Optional
from pydantic import BaseModel, EmailStr, Field


class ContactBase(BaseModel):
    full_name: str = Field(..., min_length=1, max_length=100)
    phone_number: str = Field(..., min_length=5, max_length=25)
    relationship: str = Field(default="Friend")
    email: Optional[EmailStr] = None
    allow_gps: bool = True
    allow_audio: bool = True
    allow_video: bool = True


class ContactCreate(ContactBase):
    pass


class ContactUpdate(BaseModel):
    full_name: Optional[str] = None
    phone_number: Optional[str] = None
    relationship: Optional[str] = None
    email: Optional[EmailStr] = None
    allow_gps: Optional[bool] = None
    allow_audio: Optional[bool] = None
    allow_video: Optional[bool] = None


class ContactResponse(ContactBase):
    id: str
    uid: str
    created_at: str
    updated_at: str
