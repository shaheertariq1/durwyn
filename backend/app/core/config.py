import os
from typing import List
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    PROJECT_NAME: str = "Trouble Cheat API"
    VERSION: str = "1.0.0"
    API_V1_STR: str = "/api/v1"

    # Firebase Settings
    FIREBASE_PROJECT_ID: str = "trouble-cheat-security-app"
    FIREBASE_STORAGE_BUCKET: str = "trouble-cheat-security-app.firebasestorage.app"
    FIREBASE_WEB_API_KEY: str = "AIzaSyCns8hFq7QFJmHE8VNB42S1BzAUlUNcg9Q"
    USE_FIREBASE_EMULATOR: bool = False
    FIREBASE_AUTH_EMULATOR_HOST: str = "127.0.0.1:9099"
    FIRESTORE_EMULATOR_HOST: str = "127.0.0.1:8080"
    STORAGE_EMULATOR_HOST: str = "http://127.0.0.1:9199"

    # CORS
    CORS_ORIGINS: List[str] = [
        "http://localhost:3000",
        "http://localhost:5173",
        "http://127.0.0.1:5173",
        "http://localhost:8080",
        "http://10.0.2.2:8000",
        "*",
    ]

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )


settings = Settings()
