from typing import List, Dict, Any
from fastapi import APIRouter, Depends, status
from app.api.deps import get_current_user
from app.schemas.emergency import (
    SOSCreate,
    IncidentResponse,
    SafetyTimerStart,
    SafetyTimerCheckIn,
    SafetyTimerResponse,
    SafetyMonitorStart,
    SafetyMonitorPing,
    SafetyMonitorStop,
    SafetyMonitorResponse,
)
from app.services.emergency_service import emergency_service

router = APIRouter()


@router.post("/sos", response_model=IncidentResponse, status_code=status.HTTP_201_CREATED)
async def trigger_sos(
    data: SOSCreate,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Triggers an emergency SOS alert.
    Logs GPS location, alerts emergency contacts, creates incident.
    """
    return await emergency_service.trigger_sos(current_user["uid"], data)


@router.put("/incidents/{incident_id}/resolve", response_model=IncidentResponse)
async def resolve_incident(
    incident_id: str,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Marks an active incident as resolved."""
    return await emergency_service.resolve_incident(current_user["uid"], incident_id)


@router.get("/history", response_model=List[IncidentResponse])
async def list_incident_history(
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """
    Returns incident history bounded by retention entitlement
    (3 days for Free plan).
    """
    return await emergency_service.list_incidents(current_user["uid"])


@router.post("/timer/start", response_model=SafetyTimerResponse, status_code=status.HTTP_201_CREATED)
async def start_safety_timer(
    data: SafetyTimerStart,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Starts a safety timer session."""
    return await emergency_service.start_safety_timer(current_user["uid"], data)


@router.post("/timer/checkin")
async def check_in_safety_timer(
    data: SafetyTimerCheckIn = SafetyTimerCheckIn(),
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Disarms the active safety timer with 'I am Safe'."""
    return await emergency_service.check_in_safety_timer(current_user["uid"], data)


@router.post("/timer/cancel")
async def cancel_safety_timer(
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Cancels the active safety timer."""
    return await emergency_service.cancel_safety_timer(current_user["uid"])


# Safety Monitor Endpoints (Premium Plan)
@router.post("/monitor/start", response_model=SafetyMonitorResponse, status_code=status.HTTP_201_CREATED)
async def start_safety_monitor(
    data: SafetyMonitorStart,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Starts a real-time safety monitoring session (Premium Plan only)."""
    return await emergency_service.start_safety_monitor(current_user["uid"], data)


@router.post("/monitor/ping", response_model=SafetyMonitorResponse)
async def ping_safety_monitor(
    data: SafetyMonitorPing,
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Pings location and device telemetry for active safety monitor."""
    return await emergency_service.ping_safety_monitor(current_user["uid"], data)


@router.post("/monitor/stop", response_model=SafetyMonitorResponse)
async def stop_safety_monitor(
    data: SafetyMonitorStop = SafetyMonitorStop(),
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Disarms and stops the active safety monitoring session."""
    return await emergency_service.stop_safety_monitor(current_user["uid"], data)


@router.get("/monitor/status", response_model=SafetyMonitorResponse)
async def get_safety_monitor_status(
    current_user: Dict[str, Any] = Depends(get_current_user),
):
    """Returns active safety monitor state or inactive status."""
    return await emergency_service.get_active_safety_monitor(current_user["uid"])
