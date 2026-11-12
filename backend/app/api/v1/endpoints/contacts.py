from typing import List, Dict, Any
from fastapi import APIRouter, Depends, HTTPException, status
from app.api.deps import get_current_user
from app.schemas.contact import ContactCreate, ContactUpdate, ContactResponse
from app.services.contact_service import contact_service

router = APIRouter()


@router.get("", response_model=List[ContactResponse])
async def list_contacts(current_user: Dict[str, Any] = Depends(get_current_user)):
    """List all emergency contacts for the authenticated user."""
    return await contact_service.list_contacts(current_user["uid"])


@router.post("", response_model=ContactResponse, status_code=status.HTTP_201_CREATED)
async def create_contact(
    data: ContactCreate,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Create a new emergency contact.
    Enforces maximum contact limit based on user's subscription plan.
    """
    return await contact_service.create_contact(current_user["uid"], data)


@router.get("/{contact_id}", response_model=ContactResponse)
async def get_contact(
    contact_id: str,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Get a specific emergency contact."""
    return await contact_service.get_contact(current_user["uid"], contact_id)


@router.put("/{contact_id}", response_model=ContactResponse)
async def update_contact(
    contact_id: str,
    data: ContactUpdate,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Update an emergency contact."""
    return await contact_service.update_contact(current_user["uid"], contact_id, data)


@router.delete("/{contact_id}")
async def delete_contact(
    contact_id: str,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Delete an emergency contact."""
    return await contact_service.delete_contact(current_user["uid"], contact_id)
