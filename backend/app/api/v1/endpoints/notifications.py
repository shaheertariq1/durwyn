from typing import Dict, Any
from fastapi import APIRouter, Depends, HTTPException, status
from app.schemas.notification import (
    NotificationCreate,
    NotificationResponse,
    NotificationListResponse,
    MarkReadResponse,
)
from app.services.notification_service import notification_service
from app.api.deps import get_current_user

router = APIRouter()


@router.get("", response_model=NotificationListResponse)
async def list_notifications(
    limit: int = 50,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Returns all notifications for the authenticated user, ordered newest first.
    """
    uid = current_user.get("uid")
    return await notification_service.get_user_notifications(uid=uid, limit=limit)


@router.post("", response_model=NotificationResponse, status_code=status.HTTP_201_CREATED)
async def create_notification(
    data: NotificationCreate,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Creates a notification for the authenticated user.
    """
    uid = current_user.get("uid")
    return await notification_service.create_notification(
        uid=uid,
        title=data.title,
        description=data.description,
        notification_type=data.type,
        icon=data.icon,
        icon_color=data.icon_color,
    )


@router.patch("/{notification_id}/read", response_model=Dict[str, Any])
async def mark_notification_read(
    notification_id: str,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Marks a specific notification as read.
    """
    uid = current_user.get("uid")
    success = await notification_service.mark_as_read(uid=uid, notification_id=notification_id)
    if not success:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Notification not found",
        )
    return {"status": "ok", "id": notification_id, "is_unread": False}


@router.post("/mark-all-read", response_model=MarkReadResponse)
async def mark_all_notifications_read(
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Marks all unread notifications for the user as read.
    """
    uid = current_user.get("uid")
    updated_count = await notification_service.mark_all_read(uid=uid)
    return {"status": "ok", "updated_count": updated_count}
