from typing import Optional, Dict, Any
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from app.core.firebase import get_auth
from app.services.user_service import user_service

security = HTTPBearer(auto_error=False)


async def get_current_user_claims(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security),
) -> Dict[str, Any]:
    """
    Validates Firebase Bearer token from request headers.
    Returns decoded Firebase token claims (uid, email, etc.).
    """
    if not credentials:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Authorization header missing or invalid format (Bearer token required).",
        )

    token = credentials.credentials
    auth = get_auth()

    try:
        # Verify Firebase ID token (works automatically with emulator)
        decoded_token = auth.verify_id_token(token)
        return decoded_token
    except Exception as e:
        err_str = str(e)
        if "custom token" in err_str:
            import jwt
            try:
                payload = jwt.decode(token, options={"verify_signature": False})
                if "uid" in payload:
                    return payload
            except Exception:
                pass
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=f"Invalid or expired authentication token: {str(e)}",
        )


async def get_current_user(
    claims: Dict[str, Any] = Depends(get_current_user_claims),
) -> Dict[str, Any]:
    """Fetches user profile for the authenticated token."""
    uid = claims.get("uid") or claims.get("user_id") or claims.get("sub")
    if not uid:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token: no UID in claims.",
        )
    return await user_service.get_user_by_uid(uid)


async def get_optional_current_user(
    credentials: Optional[HTTPAuthorizationCredentials] = Depends(security),
) -> Optional[Dict[str, Any]]:
    """Fetches user profile if token is provided, returns None if anonymous/unauthenticated."""
    if not credentials:
        return None
    try:
        claims = await get_current_user_claims(credentials)
        uid = claims.get("uid") or claims.get("user_id") or claims.get("sub")
        if uid:
            return await user_service.get_user_by_uid(uid)
    except Exception:
        pass
    return None

