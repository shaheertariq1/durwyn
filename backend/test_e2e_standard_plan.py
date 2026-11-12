import os
import sys
import json
import urllib.request
import urllib.error
from datetime import datetime, timezone, timedelta

# Configure Firebase emulator environment
os.environ["FIREBASE_AUTH_EMULATOR_HOST"] = "127.0.0.1:9099"
os.environ["FIRESTORE_EMULATOR_HOST"] = "127.0.0.1:8080"

from app.core.firebase import init_firebase, get_firestore, get_auth
from app.core.entitlements import get_plan_entitlements

init_firebase()
auth_client = get_auth()
db = get_firestore()
BASE_URL = "http://127.0.0.1:8000/api/v1"

def print_header(title: str):
    print("\n" + "=" * 70)
    print(f"  {title}")
    print("=" * 70)

def req(endpoint: str, method: str = "GET", data: dict = None, token: str = None) -> tuple[int, dict]:
    url = f"{BASE_URL}{endpoint}"
    headers = {"Content-Type": "application/json"}
    if token:
        headers["Authorization"] = f"Bearer {token}"
    body = json.dumps(data).encode("utf-8") if data is not None else None
    request = urllib.request.Request(url, data=body, headers=headers, method=method)
    try:
        with urllib.request.urlopen(request) as response:
            status_code = response.getcode()
            res_body = json.loads(response.read().decode("utf-8"))
            return status_code, res_body
    except urllib.error.HTTPError as e:
        status_code = e.code
        try:
            res_body = json.loads(e.read().decode("utf-8"))
        except Exception:
            res_body = {"detail": e.reason}
        return status_code, res_body

def run_tests():
    print_header("AUTOMATED END-TO-END TEST: STANDARD PLAN VALIDATION")

    test_uid = "4Zz9rEpYgwfyzjksnakFG1wFtE4e"  # iamshaheertariq@gmail.com
    token = auth_client.create_custom_token(test_uid).decode("utf-8")

    # -------------------------------------------------------------
    # 1. UPGRADE TO STANDARD PLAN
    # -------------------------------------------------------------
    print("\n[TEST 1] Upgrading user to STANDARD PLAN...")
    upgrade_payload = {"subscription_plan": "standard"}
    status, updated_user = req(f"/users/{test_uid}/plan", "PUT", upgrade_payload, token=token)
    assert status == 200, f"Expected 200, got {status}: {updated_user}"
    assert updated_user["subscription_plan"] == "standard", f"Plan should be standard, got: {updated_user.get('subscription_plan')}"
    
    # Verify via /auth/me
    status, me = req("/auth/me", "GET", token=token)
    assert status == 200 and me["subscription_plan"] == "standard", f"Profile plan not updated: {me}"
    
    entitlements = get_plan_entitlements("standard")
    print(f"  ✅ User upgraded to: {me['subscription_plan'].upper()}")
    print(f"  ✅ Max Contacts: {entitlements.max_contacts} (vs 1 on Free)")
    print(f"  ✅ Retention Window: {entitlements.evidence_retention_days} days (vs 3 on Free)")
    print(f"  ✅ Silent Emergency: {'Enabled' if entitlements.has_silent_emergency else 'Disabled'}")
    print(f"  ✅ Voice Trigger: {'Enabled' if entitlements.has_voice_trigger else 'Disabled'}")

    # -------------------------------------------------------------
    # 2. EMERGENCY CONTACTS (STANDARD TIER LIMIT: UP TO 4 CONTACTS)
    # -------------------------------------------------------------
    print_header("[TEST 2] Emergency Contacts (Standard: 4-Contact Allowance)")

    # Reset existing contacts
    contacts_ref = db.collection("users").document(test_uid).collection("contacts")
    for doc in contacts_ref.stream():
        doc.reference.delete()
    print("  🧹 Reset contacts subcollection in Firestore emulator.")

    contacts_to_create = [
        {"full_name": "Sarah Connor", "phone_number": "+14155552671", "relationship": "Sister"},
        {"full_name": "John Connor", "phone_number": "+14155552672", "relationship": "Brother"},
        {"full_name": "Kyle Reese", "phone_number": "+14155552673", "relationship": "Partner"},
        {"full_name": "Dr. Silberman", "phone_number": "+14155552674", "relationship": "Doctor"},
    ]

    created_ids = []
    for i, cdata in enumerate(contacts_to_create, start=1):
        status, res = req("/contacts", "POST", {**cdata, "allow_gps": True, "allow_audio": True, "allow_video": False}, token=token)
        assert status == 201, f"Failed to create contact {i}: {res}"
        created_ids.append(res["id"])
        print(f"  ✅ Contact {i}/4 Created: '{res['full_name']}' ({res['phone_number']}) - ID: {res['id']}")

    # Verify list returns 4 contacts
    status, contact_list = req("/contacts", "GET", token=token)
    assert status == 200 and len(contact_list) == 4, f"Expected 4 contacts, got {len(contact_list)}"
    print(f"  ✅ GET /contacts verified: {len(contact_list)}/4 active emergency contacts.")

    # Attempt to create Contact 5 (Must be BLOCKED with 400 on Standard tier)
    print("\n  Testing 5th contact insertion (Limit Enforcer):")
    contact5_payload = {
        "full_name": "Miles Dyson",
        "phone_number": "+14155552675",
        "relationship": "Colleague",
        "allow_gps": True,
        "allow_audio": False,
        "allow_video": False,
    }
    status, blocked_res = req("/contacts", "POST", contact5_payload, token=token)
    assert status == 400, f"Expected 400 Bad Request, got {status}: {blocked_res}"
    print(f"  ✅ 5th Contact correctly REJECTED (HTTP 400): {blocked_res.get('detail')}")

    # -------------------------------------------------------------
    # 3. SILENT EMERGENCY (STEALTH SOS)
    # -------------------------------------------------------------
    print_header("[TEST 3] Silent Emergency (Stealth SOS)")

    silent_sos_payload = {
        "emergency_type": "silent",
        "latitude": 37.7891796,
        "longitude": -122.4014415,
        "address": "Market St & 4th St, San Francisco, CA",
        "notes": "Stealth silent trigger from smartwatch or quick toggle",
    }
    status, silent_incident = req("/emergency/sos", "POST", silent_sos_payload, token=token)
    assert status == 201, f"Failed to trigger silent SOS: {silent_incident}"
    incident_id = silent_incident["id"]
    assert silent_incident["emergency_type"] == "silent", f"Expected silent type, got {silent_incident.get('emergency_type')}"
    assert silent_incident["status"] == "active"
    assert len(silent_incident["contacts_alerted"]) == 4, f"Expected all 4 contacts alerted, got {len(silent_incident['contacts_alerted'])}"
    print(f"  ✅ Silent SOS Triggered successfully! Incident ID: {incident_id}")
    print(f"     Emergency Type: {silent_incident['emergency_type']}")
    print(f"     Status: {silent_incident['status']}")
    print(f"     Alerted Contacts ({len(silent_incident['contacts_alerted'])}):")
    for ca in silent_incident["contacts_alerted"]:
        print(f"       - {ca['name']} ({ca['phone']}) -> {ca['status']} at {ca['notified_at']}")
    print(f"     Live Tracking URL: {silent_incident['live_tracking_url']}")

    # Verify Firestore document
    global_doc = db.collection("incidents").document(incident_id).get()
    assert global_doc.exists and global_doc.to_dict()["emergency_type"] == "silent"
    print("  ✅ Firestore verification: Incident document stored in global /incidents collection.")

    # Resolve the silent incident
    status, resolved = req(f"/emergency/incidents/{incident_id}/resolve", "PUT", token=token)
    assert status == 200 and resolved["status"] == "resolved", f"Failed to resolve silent incident: {resolved}"
    print(f"  ✅ Incident resolved: Status={resolved['status']}, ResolvedAt={resolved.get('resolved_at')}")

    # -------------------------------------------------------------
    # 4. VOICE TRIGGER & EMERGENCY PREFERENCES
    # -------------------------------------------------------------
    print_header("[TEST 4] Voice Trigger & Custom Emergency Phrase")

    voice_payload = {
        "emergency_phrase": "Red Umbrella",
        "emergency_message": "Stealth emergency! Please trace my coordinates immediately.",
    }
    status, updated_settings = req(f"/users/{test_uid}/emergency", "PUT", voice_payload, token=token)
    assert status == 200, f"Failed to update emergency settings: {updated_settings}"
    assert updated_settings.get("emergency_phrase") == "Red Umbrella", f"Phrase not saved: {updated_settings}"
    assert updated_settings.get("emergency_message") == "Stealth emergency! Please trace my coordinates immediately."
    print("  ✅ Voice Trigger phrase updated in backend:")
    print(f"     Phrase:  \"{updated_settings['emergency_phrase']}\"")
    print(f"     Message: \"{updated_settings['emergency_message']}\"")

    # Verify user profile in Firestore
    user_doc = db.collection("users").document(test_uid).get().to_dict()
    assert (user_doc.get("emergencyPhrase") or user_doc.get("emergency_phrase")) == "Red Umbrella"
    print("  ✅ Firestore verification: Saved under /users/{uid}.")

    # -------------------------------------------------------------
    # 5. 14-DAY INCIDENT HISTORY EVIDENCE RETENTION
    # -------------------------------------------------------------
    print_header("[TEST 5] 14-Day Evidence Retention Window")

    # Clear user incidents for precise window test
    incidents_ref = db.collection("users").document(test_uid).collection("incidents")
    for doc in incidents_ref.stream():
        doc.reference.delete()
    print("  🧹 Reset user incidents subcollection in Firestore.")

    now_utc = datetime.now(timezone.utc)
    
    # Incident A: 5 days ago (Within 14 days -> SHOULD be returned)
    doc_5d = {
        "id": "inc_standard_5d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "sos",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "5 Days Ago Location",
        "emergency_message": "5-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_standard_5d_ago",
        "created_at": (now_utc - timedelta(days=5)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=5, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_5d["id"]).set(doc_5d)

    # Incident B: 12 days ago (Within 14 days -> SHOULD be returned)
    doc_12d = {
        "id": "inc_standard_12d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "silent",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "12 Days Ago Location",
        "emergency_message": "12-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_standard_12d_ago",
        "created_at": (now_utc - timedelta(days=12)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=12, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_12d["id"]).set(doc_12d)

    # Incident C: 16 days ago (Outside 14 days -> MUST BE FILTERED OUT)
    doc_16d = {
        "id": "inc_standard_16d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "timer_expired",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "16 Days Ago Location (Expired)",
        "emergency_message": "16-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_standard_16d_ago",
        "created_at": (now_utc - timedelta(days=16)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=16, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_16d["id"]).set(doc_16d)

    print("  Inserted mock incidents:")
    print("    - inc_standard_5d_ago  (5 days old  -> inside 14-day window)")
    print("    - inc_standard_12d_ago (12 days old -> inside 14-day window)")
    print("    - inc_standard_16d_ago (16 days old -> EXPIRED for Standard tier)")

    # Query GET /emergency/history
    status, history = req("/emergency/history", "GET", token=token)
    assert status == 200, f"Failed to get incidents: {history}"
    history_ids = [inc["id"] for inc in history]
    
    print(f"  GET /emergency/history returned {len(history)} items: {history_ids}")
    assert "inc_standard_5d_ago" in history_ids, "5-day-old incident should be present!"
    assert "inc_standard_12d_ago" in history_ids, "12-day-old incident should be present!"
    assert "inc_standard_16d_ago" not in history_ids, "16-day-old incident MUST NOT be present on Standard plan!"
    print("  ✅ 14-Day Retention strictly ENFORCED: Returned 5-day & 12-day incidents; filtered out 16-day incident.")

    print_header("🎉 ALL 5 STANDARD PLAN TESTS PASSED WITH 100% SUCCESS!")

if __name__ == "__main__":
    run_tests()
