from typing import Dict, Any
from pydantic import BaseModel


class PlanEntitlements(BaseModel):
    plan_name: str
    max_contacts: int
    evidence_retention_days: int
    has_voice_trigger: bool
    has_safety_monitor: bool
    has_silent_emergency: bool
    has_cloud_backup: bool


# Single source of truth for subscription entitlements
PLAN_ENTITLEMENTS: Dict[str, PlanEntitlements] = {
    "free": PlanEntitlements(
        plan_name="free",
        max_contacts=1,
        evidence_retention_days=3,
        has_voice_trigger=False,
        has_safety_monitor=False,
        has_silent_emergency=False,
        has_cloud_backup=False,
    ),
    "standard": PlanEntitlements(
        plan_name="standard",
        max_contacts=4,
        evidence_retention_days=14,
        has_voice_trigger=True,
        has_safety_monitor=False,
        has_silent_emergency=True,
        has_cloud_backup=True,
    ),
    "premium": PlanEntitlements(
        plan_name="premium",
        max_contacts=7,
        evidence_retention_days=30,
        has_voice_trigger=True,
        has_safety_monitor=True,
        has_silent_emergency=True,
        has_cloud_backup=True,
    ),
}


def get_plan_entitlements(plan_name: str) -> PlanEntitlements:
    normalized = (plan_name or "free").lower()
    return PLAN_ENTITLEMENTS.get(normalized, PLAN_ENTITLEMENTS["free"])
