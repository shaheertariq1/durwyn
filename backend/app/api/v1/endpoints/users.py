from typing import List, Dict, Any, Optional
from fastapi import APIRouter, Depends, HTTPException, status
from app.schemas.user import (
    UserProfileResponse,
    UserUpdate,
    PlanUpdate,
    EmergencySettingsUpdate,
)
from app.services.user_service import user_service
from app.api.deps import get_current_user

router = APIRouter()


@router.get("", response_model=List[UserProfileResponse])
async def list_users(limit: int = 50):
    """
    List registered users for Admin Portal.
    """
    return await user_service.list_users(limit=limit)


@router.get("/{uid}", response_model=UserProfileResponse)
async def get_user_profile(uid: str):
    """
    Fetch a user's profile by their UID.
    """
    return await user_service.get_user_by_uid(uid)


@router.put("/{uid}/profile", response_model=UserProfileResponse)
async def update_profile(uid: str, updates: UserUpdate):
    """
    Updates profile details (full name, phone, avatar URL).
    """
    update_data = {}
    if updates.full_name is not None:
        update_data["fullName"] = updates.full_name
    if updates.phone_number is not None:
        update_data["phoneNumber"] = updates.phone_number
    if updates.avatar_url is not None:
        update_data["avatarUrl"] = updates.avatar_url
    if updates.subscription_plan is not None:
        update_data["subscriptionPlan"] = updates.subscription_plan

    return await user_service.update_user(uid, update_data)


@router.put("/{uid}/plan", response_model=UserProfileResponse)
async def update_plan(uid: str, plan_data: PlanUpdate):
    """
    Updates a user's subscription plan ('free', 'standard', 'premium').
    """
    valid_plans = ["free", "standard", "premium"]
    if plan_data.subscription_plan.lower() not in valid_plans:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Invalid subscription plan. Must be one of {valid_plans}",
        )

    return await user_service.update_user(
        uid, {"subscriptionPlan": plan_data.subscription_plan.lower()}
    )


@router.put("/{uid}/emergency", response_model=UserProfileResponse)
async def update_emergency_settings(uid: str, data: EmergencySettingsUpdate):
    """
    Updates a user's emergency trigger phrase and emergency alert message.
    """
    update_data = {}
    if data.emergency_message is not None:
        update_data["emergencyMessage"] = data.emergency_message
    if data.emergency_phrase is not None:
        update_data["emergencyPhrase"] = data.emergency_phrase

    return await user_service.update_user(uid, update_data)
