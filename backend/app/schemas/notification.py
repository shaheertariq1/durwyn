from typing import Optional, List
from pydantic import BaseModel, Field


class NotificationCreate(BaseModel):
    title: str = Field(..., description="Notification title")
    description: str = Field(..., description="Notification description / message")
    type: str = Field(default="system", description="emergency | timer | contact | account | system")
    icon: Optional[str] = None
    icon_color: Optional[str] = None


class NotificationResponse(BaseModel):
    id: str
    uid: str
    title: str
    description: str
    type: str = "system"
    icon: Optional[str] = None
    icon_color: Optional[str] = None
    date_label: str
    is_unread: bool = True
    created_at: str


class NotificationListResponse(BaseModel):
    total: int
    unread_count: int
    notifications: List[NotificationResponse]


class MarkReadResponse(BaseModel):
    status: str = "ok"
    updated_count: int
