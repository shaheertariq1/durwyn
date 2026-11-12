from datetime import datetime, timezone
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.core.firebase import init_firebase
from app.api.v1.api import api_router
from app.schemas.user import HealthResponse

# Ensure Firebase Admin is initialized
init_firebase()

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="Trouble Cheat Safety App & Admin Portal Backend API with Firebase Integration",
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include API router
app.include_router(api_router, prefix=settings.API_V1_STR)


@app.get("/", tags=["Health"])
@app.get("/health", tags=["Health"], response_model=HealthResponse)
@app.get(f"{settings.API_V1_STR}/health", tags=["Health"], response_model=HealthResponse)
async def health_check():
    return {
        "status": "healthy",
        "project": settings.FIREBASE_PROJECT_ID,
        "emulators_enabled": settings.USE_FIREBASE_EMULATOR,
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }
