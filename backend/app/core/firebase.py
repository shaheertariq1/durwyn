import os
import logging
import firebase_admin
from firebase_admin import credentials, auth, firestore, storage
from google.auth.credentials import AnonymousCredentials
from app.core.config import settings

logger = logging.getLogger("uvicorn.error")

_initialized = False


class EmulatorCredential(credentials.Base):
    """Credential provider for local Firebase Emulators."""
    def get_credential(self):
        return AnonymousCredentials()


def init_firebase():
    global _initialized
    if _initialized:
        return

    if settings.USE_FIREBASE_EMULATOR:
        logger.info("🔧 Configuring Firebase Admin SDK for Local Emulator Suite...")
        os.environ["FIREBASE_AUTH_EMULATOR_HOST"] = settings.FIREBASE_AUTH_EMULATOR_HOST
        os.environ["FIRESTORE_EMULATOR_HOST"] = settings.FIRESTORE_EMULATOR_HOST
        os.environ["STORAGE_EMULATOR_HOST"] = settings.STORAGE_EMULATOR_HOST
        os.environ["GCLOUD_PROJECT"] = settings.FIREBASE_PROJECT_ID

    try:
        firebase_admin.get_app()
        logger.info("Firebase app already initialized.")
    except ValueError:
        if settings.USE_FIREBASE_EMULATOR:
            firebase_admin.initialize_app(
                credential=EmulatorCredential(),
                options={
                    "projectId": settings.FIREBASE_PROJECT_ID,
                    "storageBucket": settings.FIREBASE_STORAGE_BUCKET,
                },
            )
        else:
            firebase_admin.initialize_app(
                options={
                    "projectId": settings.FIREBASE_PROJECT_ID,
                    "storageBucket": settings.FIREBASE_STORAGE_BUCKET,
                }
            )
        logger.info(
            f"✅ Firebase Admin initialized successfully for project: {settings.FIREBASE_PROJECT_ID}"
        )

    _initialized = True


# Run initialization
init_firebase()


def get_auth():
    return auth


def get_firestore():
    return firestore.client()


def get_storage():
    return storage.bucket()
