from fastapi import APIRouter
from app.api.v1.endpoints import auth, users, contacts, emergency, notifications

api_router = APIRouter()
api_router.include_router(auth.router, prefix="/auth", tags=["Authentication"])
api_router.include_router(users.router, prefix="/users", tags=["Users"])
api_router.include_router(contacts.router, prefix="/contacts", tags=["Emergency Contacts"])
api_router.include_router(emergency.router, prefix="/emergency", tags=["Emergency Operations"])
api_router.include_router(notifications.router, prefix="/notifications", tags=["Notifications"])

