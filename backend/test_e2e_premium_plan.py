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
    print_header("AUTOMATED END-TO-END TEST: PREMIUM PLAN VALIDATION")

    test_uid = "4Zz9rEpYgwfyzjksnakFG1wFtE4e"  # iamshaheertariq@gmail.com
    token = auth_client.create_custom_token(test_uid).decode("utf-8")

    # -------------------------------------------------------------
    # 1. UPGRADE TO PREMIUM PLAN
    # -------------------------------------------------------------
    print("\n[TEST 1] Upgrading user to PREMIUM PLAN...")
    upgrade_payload = {"subscription_plan": "premium"}
    status, updated_user = req(f"/users/{test_uid}/plan", "PUT", upgrade_payload, token=token)
    assert status == 200, f"Expected 200, got {status}: {updated_user}"
    assert updated_user["subscription_plan"] == "premium", f"Plan should be premium, got: {updated_user.get('subscription_plan')}"

    # Verify via /auth/me
    status, me = req("/auth/me", "GET", token=token)
    assert status == 200 and me["subscription_plan"] == "premium", f"Profile plan not updated: {me}"

    entitlements = get_plan_entitlements("premium")
    print(f"  ✅ User upgraded to: {me['subscription_plan'].upper()}")
    print(f"  ✅ Max Contacts: {entitlements.max_contacts} (vs 4 on Standard, 1 on Free)")
    print(f"  ✅ Retention Window: {entitlements.evidence_retention_days} days (vs 14 on Standard, 3 on Free)")
    print(f"  ✅ Safety Monitor: {'Enabled' if entitlements.has_safety_monitor else 'Disabled'}")
    print(f"  ✅ Silent Emergency: {'Enabled' if entitlements.has_silent_emergency else 'Disabled'}")
    print(f"  ✅ Voice Trigger: {'Enabled' if entitlements.has_voice_trigger else 'Disabled'}")

    # -------------------------------------------------------------
    # 2. EMERGENCY CONTACTS (PREMIUM TIER LIMIT: UP TO 7 CONTACTS)
    # -------------------------------------------------------------
    print_header("[TEST 2] Emergency Contacts (Premium: 7-Contact Allowance)")

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
        {"full_name": "Miles Dyson", "phone_number": "+14155552675", "relationship": "Colleague"},
        {"full_name": "Danny Dyson", "phone_number": "+14155552676", "relationship": "Friend"},
        {"full_name": "Tarissa Dyson", "phone_number": "+14155552677", "relationship": "Neighbor"},
    ]

    for i, cdata in enumerate(contacts_to_create, start=1):
        status, res = req("/contacts", "POST", {**cdata, "allow_gps": True, "allow_audio": True, "allow_video": True}, token=token)
        assert status == 201, f"Failed to create contact {i}: {res}"
        print(f"  ✅ Contact {i}/7 Created: '{res['full_name']}' ({res['phone_number']}) - ID: {res['id']}")

    # Verify list returns 7 contacts
    status, contact_list = req("/contacts", "GET", token=token)
    assert status == 200 and len(contact_list) == 7, f"Expected 7 contacts, got {len(contact_list)}"
    print(f"  ✅ GET /contacts verified: {len(contact_list)}/7 active emergency contacts.")

    # Attempt to create Contact 8 (Must be BLOCKED with 400 on Premium tier)
    print("\n  Testing 8th contact insertion (Limit Enforcer):")
    contact8_payload = {
        "full_name": "Marcus Wright",
        "phone_number": "+14155552678",
        "relationship": "Ally",
        "allow_gps": True,
        "allow_audio": False,
        "allow_video": False,
    }
    status, blocked_res = req("/contacts", "POST", contact8_payload, token=token)
    assert status == 400, f"Expected 400 Bad Request, got {status}: {blocked_res}"
    print(f"  ✅ 8th Contact correctly REJECTED (HTTP 400): {blocked_res.get('detail')}")

    # -------------------------------------------------------------
    # 3. SAFETY MONITOR (PREMIUM EXCLUSIVE FEATURE)
    # -------------------------------------------------------------
    print_header("[TEST 3] Real-time Safety Monitor (Start, Ping, Stop, Entitlement Enforcer)")

    # A. Verify Entitlement Gate: Standard/Free user must be REJECTED with 403 Forbidden
    print("  A. Verifying Entitlement Gate (Downgrading temporarily to Standard to test 403 gate)...")
    req(f"/users/{test_uid}/plan", "PUT", {"subscription_plan": "standard"}, token=token)
    status, forbidden_res = req("/emergency/monitor/start", "POST", {"monitor_type": "Travel Safe"}, token=token)
    assert status == 403, f"Expected 403 Forbidden for Standard plan, got {status}: {forbidden_res}"
    print(f"  ✅ Entitlement Gate passed: Standard user correctly blocked from Safety Monitor (HTTP 403): {forbidden_res.get('detail')}")

    # Restore to Premium
    req(f"/users/{test_uid}/plan", "PUT", {"subscription_plan": "premium"}, token=token)
    print("  ✅ User restored to Premium plan.")

    # B. Start Safety Monitor session
    start_payload = {
        "monitor_type": "Travel Safe",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "check_in_interval_minutes": 15,
    }
    status, monitor_session = req("/emergency/monitor/start", "POST", start_payload, token=token)
    assert status == 201, f"Failed to start safety monitor: {monitor_session}"
    session_id = monitor_session["session_id"]
    assert monitor_session["status"] == "active"
    assert monitor_session["monitor_type"] == "Travel Safe"
    assert monitor_session["risk_score"] == 0.15
    print(f"  ✅ Safety Monitor Session Started: ID={session_id}")
    print(f"     Type: {monitor_session['monitor_type']}, Status: {monitor_session['status']}, Risk Score: {monitor_session['risk_score']}")

    # Verify Firestore document
    active_doc = db.collection("users").document(test_uid).collection("active_monitor").document("current").get()
    assert active_doc.exists and active_doc.to_dict()["session_id"] == session_id
    print("  ✅ Firestore verification: Active monitor recorded in /users/{uid}/active_monitor/current.")

    # C. Telemetry Ping (Location & Device Status update)
    ping_payload = {
        "latitude": 37.7755,
        "longitude": -122.4180,
        "battery_level": 94,
        "speed_kmh": 12.5,
        "status": "normal",
    }
    status, ping_res = req("/emergency/monitor/ping", "POST", ping_payload, token=token)
    assert status == 200, f"Failed to ping monitor: {ping_res}"
    assert ping_res["latitude"] == 37.7755
    assert ping_res["battery_level"] == 94
    print(f"  ✅ Safety Monitor Ping successful: Lat={ping_res['latitude']}, Battery={ping_res['battery_level']}%, LastPing={ping_res['last_ping_at']}")

    # D. GET /emergency/monitor/status
    status, status_res = req("/emergency/monitor/status", "GET", token=token)
    assert status == 200 and status_res["status"] == "active" and status_res["session_id"] == session_id
    print(f"  ✅ GET /emergency/monitor/status verified: Session active.")

    # E. Stop Safety Monitor session
    status, stop_res = req("/emergency/monitor/stop", "POST", {"reason": "user_reached_destination"}, token=token)
    assert status == 200 and stop_res["status"] == "stopped", f"Failed to stop monitor: {stop_res}"
    print(f"  ✅ Safety Monitor Session Stopped: Status={stop_res['status']}, StoppedAt={stop_res['stopped_at']}")

    # -------------------------------------------------------------
    # 4. 30-DAY INCIDENT HISTORY EVIDENCE RETENTION
    # -------------------------------------------------------------
    print_header("[TEST 4] 30-Day Evidence Retention Window")

    # Clear user incidents for precise window test
    incidents_ref = db.collection("users").document(test_uid).collection("incidents")
    for doc in incidents_ref.stream():
        doc.reference.delete()
    print("  🧹 Reset user incidents subcollection in Firestore.")

    now_utc = datetime.now(timezone.utc)

    # Incident A: 10 days ago (Within 30 days -> SHOULD be returned)
    doc_10d = {
        "id": "inc_premium_10d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "sos",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "10 Days Ago Location",
        "emergency_message": "10-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_premium_10d_ago",
        "created_at": (now_utc - timedelta(days=10)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=10, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_10d["id"]).set(doc_10d)

    # Incident B: 25 days ago (Within 30 days -> SHOULD be returned)
    doc_25d = {
        "id": "inc_premium_25d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "silent",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "25 Days Ago Location",
        "emergency_message": "25-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_premium_25d_ago",
        "created_at": (now_utc - timedelta(days=25)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=25, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_25d["id"]).set(doc_25d)

    # Incident C: 35 days ago (Outside 30 days -> MUST BE FILTERED OUT)
    doc_35d = {
        "id": "inc_premium_35d_ago",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "timer_expired",
        "status": "resolved",
        "latitude": 37.7749,
        "longitude": -122.4194,
        "address": "35 Days Ago Location (Expired)",
        "emergency_message": "35-day-old emergency alert",
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_premium_35d_ago",
        "created_at": (now_utc - timedelta(days=35)).isoformat(),
        "resolved_at": (now_utc - timedelta(days=35, minutes=-10)).isoformat(),
    }
    incidents_ref.document(doc_35d["id"]).set(doc_35d)

    print("  Inserted mock incidents:")
    print("    - inc_premium_10d_ago (10 days old -> inside 30-day window)")
    print("    - inc_premium_25d_ago (25 days old -> inside 30-day window)")
    print("    - inc_premium_35d_ago (35 days old -> EXPIRED for Premium tier)")

    # Query GET /emergency/history
    status, history = req("/emergency/history", "GET", token=token)
    assert status == 200, f"Failed to get incidents: {history}"
    history_ids = [inc["id"] for inc in history]

    print(f"  GET /emergency/history returned {len(history)} items: {history_ids}")
    assert "inc_premium_10d_ago" in history_ids, "10-day-old incident should be present!"
    assert "inc_premium_25d_ago" in history_ids, "25-day-old incident should be present!"
    assert "inc_premium_35d_ago" not in history_ids, "35-day-old incident MUST NOT be present on Premium plan!"
    print("  ✅ 30-Day Retention strictly ENFORCED: Returned 10-day & 25-day incidents; filtered out 35-day incident.")

    print_header("🎉 ALL 4 PREMIUM PLAN TESTS PASSED WITH 100% SUCCESS!")

if __name__ == "__main__":
    run_tests()
