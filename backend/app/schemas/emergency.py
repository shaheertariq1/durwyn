from typing import Optional, List, Dict, Any
from pydantic import BaseModel, Field


class SOSCreate(BaseModel):
    latitude: float = Field(..., description="GPS Latitude")
    longitude: float = Field(..., description="GPS Longitude")
    address: Optional[str] = Field(default="Current Location", description="Reverse-geocoded address or label")
    emergency_type: str = Field(default="sos", description="'sos' | 'timer_expired' | 'manual'")
    notes: Optional[str] = None


class IncidentResponse(BaseModel):
    id: str
    uid: str
    user_name: str
    user_phone: Optional[str] = None
    emergency_type: str
    status: str = "active"  # "active" | "resolved" | "cancelled"
    latitude: float
    longitude: float
    address: str
    emergency_message: Optional[str] = "Emergency Alert"
    contacts_alerted: List[Dict[str, Any]] = []
    live_tracking_url: Optional[str] = ""
    created_at: str
    resolved_at: Optional[str] = None


class SafetyTimerStart(BaseModel):
    duration_minutes: int = Field(..., ge=1, le=1440, description="Duration in minutes (1 to 1440)")
    label: Optional[str] = Field(default="Walking Home", description="Optional label for timer")


class SafetyTimerCheckIn(BaseModel):
    is_safe: bool = True
    notes: Optional[str] = None


class SafetyTimerResponse(BaseModel):
    timer_id: str
    uid: str
    duration_minutes: int
    expires_at: str
    status: str = "active"  # "active" | "checked_in" | "expired" | "cancelled"
    created_at: str
    checked_in_at: Optional[str] = None


class SafetyMonitorStart(BaseModel):
    monitor_type: str = Field(default="Travel Safe", description="'Travel Safe' | 'Activity Tracking' | 'High Risk Area'")
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    check_in_interval_minutes: Optional[int] = 15


class SafetyMonitorPing(BaseModel):
    latitude: float
    longitude: float
    battery_level: Optional[int] = None
    speed_kmh: Optional[float] = None
    status: Optional[str] = "normal"  # "normal" | "caution" | "critical"


class SafetyMonitorStop(BaseModel):
    reason: Optional[str] = "user_completed"


class SafetyMonitorResponse(BaseModel):
    session_id: str
    uid: str
    monitor_type: str
    status: str = "active"  # "active" | "completed" | "stopped" | "inactive"
    risk_score: float = 0.15
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    battery_level: Optional[int] = None
    last_ping_at: Optional[str] = None
    created_at: str
    stopped_at: Optional[str] = None
