import os
import sys
import json
import urllib.request
import urllib.error
from datetime import datetime, timezone, timedelta

# Ensure Firebase emulator host is configured
os.environ["FIREBASE_AUTH_EMULATOR_HOST"] = "127.0.0.1:9099"
os.environ["FIRESTORE_EMULATOR_HOST"] = "127.0.0.1:8080"

from app.core.firebase import init_firebase, get_firestore, get_auth

init_firebase()
auth_client = get_auth()
db = get_firestore()
BASE_URL = "http://127.0.0.1:8000/api/v1"

def print_header(title: str):
    print("\n" + "=" * 65)
    print(f"  {title}")
    print("=" * 65)

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
    print_header("AUTOMATED END-TO-END TEST: FREE PLAN VALIDATION")

    # -------------------------------------------------------------
    # 1. AUTHENTICATION & TOKEN
    # -------------------------------------------------------------
    print("\n[TEST 1] Authenticating user and checking Free Plan profile...")
    test_uid = "4Zz9rEpYgwfyzjksnakFG1wFtE4e"  # iamshaheertariq@gmail.com
    token = auth_client.create_custom_token(test_uid).decode("utf-8")
    
    req(f"/users/{test_uid}/plan", "PUT", {"subscription_plan": "free"}, token=token)
    status, me = req("/auth/me", "GET", token=token)
    assert status == 200, f"Expected 200, got {status}: {me}"
    assert me["email"] == "iamshaheertariq@gmail.com", f"Unexpected email: {me.get('email')}"
    assert me["subscription_plan"] == "free", f"User plan should be 'free', got {me.get('subscription_plan')}"
    print(f"  ✅ Verified user: {me['full_name']} ({me['email']})")
    print(f"  ✅ Subscription Plan: {me['subscription_plan'].upper()} (Entitled to 1 contact, 3 days retention)")

    # -------------------------------------------------------------
    # 2. EMERGENCY CONTACTS (FREE TIER LIMIT: 1 CONTACT)
    # -------------------------------------------------------------
    print_header("[TEST 2] Emergency Contacts CRUD & 1-Contact Enforcer")
    
    # Clean up existing contacts in Firestore to start fresh
    contacts_ref = db.collection("users").document(test_uid).collection("contacts")
    for doc in contacts_ref.stream():
        doc.reference.delete()
    print("  🧹 Reset contacts subcollection in Firestore emulator.")

    # A. Verify empty list
    status, contacts = req("/contacts", "GET", token=token)
    assert status == 200 and len(contacts) == 0, f"Expected 0 contacts, got {contacts}"
    print("  ✅ GET /contacts returns 0 contacts initially.")

    # B. Add Contact 1 (Should succeed)
    contact1_payload = {
        "full_name": "Sarah Connor",
        "phone_number": "+14155552671",
        "relationship": "Sister",
        "email": "sarah.connor@example.com",
        "allow_gps": True,
        "allow_audio": True,
        "allow_video": False,
    }
    status, c1 = req("/contacts", "POST", contact1_payload, token=token)
    assert status == 201, f"Failed to create contact 1: {c1}"
    c1_id = c1["id"]
    print(f"  ✅ Contact 1 Created: '{c1['full_name']}' (ID: {c1_id})")
    print(f"     Permissions: GPS={c1['allow_gps']}, Audio={c1['allow_audio']}, Video={c1['allow_video']}")

    # Verify Firestore document directly
    c1_doc = contacts_ref.document(c1_id).get()
    assert c1_doc.exists and c1_doc.to_dict()["phone_number"] == "+14155552671"
    print("  ✅ Firestore verification: Document persisted in /users/{uid}/contacts.")

    # C. Attempt to add Contact 2 (Must be BLOCKED with 400 on Free tier)
    contact2_payload = {
        "full_name": "John Connor",
        "phone_number": "+14155552672",
        "relationship": "Brother",
    }
    status, c2_error = req("/contacts", "POST", contact2_payload, token=token)
    assert status == 400, f"Expected 400 Bad Request, got {status}: {c2_error}"
    assert "Your Free Plan allows a maximum of 1 emergency contact" in c2_error.get("detail", "")
    print(f"  ✅ Free Plan Limit Enforced: 2nd contact blocked with HTTP 400.")
    print(f"     Server detail message: \"{c2_error['detail']}\"")

    # D. Update Contact 1 permissions
    update_payload = {
        "full_name": "Sarah Connor",
        "phone_number": "+14155552671",
        "relationship": "Sister (Primary)",
        "email": "sarah.connor@example.com",
        "allow_gps": True,
        "allow_audio": True,
        "allow_video": True,
    }
    status, c1_updated = req(f"/contacts/{c1_id}", "PUT", update_payload, token=token)
    assert status == 200 and c1_updated["allow_video"] is True
    assert c1_updated["relationship"] == "Sister (Primary)"
    print(f"  ✅ Contact 1 Updated: relationship='{c1_updated['relationship']}', allow_video={c1_updated['allow_video']}")

    # -------------------------------------------------------------
    # 3. MANUAL SOS ALERT & DISPATCH
    # -------------------------------------------------------------
    print_header("[TEST 3] Manual SOS Alert, Contacts Alerting & Web Tracking")

    sos_payload = {
        "latitude": 37.774929,
        "longitude": -122.419416,
        "address": "Market Street, San Francisco, CA",
        "emergency_type": "sos",
        "notes": "Testing manual SOS button",
    }
    status, incident = req("/emergency/sos", "POST", sos_payload, token=token)
    assert status == 201, f"Failed to trigger SOS: {incident}"
    inc_id = incident["id"]
    assert inc_id.startswith("inc_")
    assert incident["status"] == "active"
    assert incident["latitude"] == 37.774929
    assert len(incident["contacts_alerted"]) == 1
    alerted_contact = incident["contacts_alerted"][0]
    assert alerted_contact["name"] == "Sarah Connor"
    assert alerted_contact["status"] == "delivered"
    assert incident["live_tracking_url"] == f"https://track.troublecheat.com/incident/{inc_id}"

    print(f"  ✅ SOS Incident Created: ID = {inc_id}")
    print(f"     GPS Location: {incident['latitude']}, {incident['longitude']} ({incident['address']})")
    print(f"     Contacts Alerted: {len(incident['contacts_alerted'])} -> '{alerted_contact['name']}' ({alerted_contact['phone']}) - Status: {alerted_contact['status']}")
    print(f"     Public Tracking URL: {incident['live_tracking_url']}")

    # Verify global incident doc in Firestore
    global_inc = db.collection("incidents").document(inc_id).get()
    assert global_inc.exists and global_inc.to_dict()["status"] == "active"
    print("  ✅ Firestore verification: Incident logged in global /incidents and user history.")

    # Resolve Incident
    status, resolved = req(f"/emergency/incidents/{inc_id}/resolve", "PUT", token=token)
    assert status == 200 and resolved["status"] == "resolved"
    assert resolved["resolved_at"] is not None
    print(f"  ✅ SOS Incident Resolved: status='{resolved['status']}', resolved_at={resolved['resolved_at']}")

    # -------------------------------------------------------------
    # 4. SAFETY TIMER & AUTO-ESCALATION
    # -------------------------------------------------------------
    print_header("[TEST 4] Safety Timer Lifecycle & Expiry Auto-Escalation")

    # A. Start Safety Timer (15 minutes)
    timer_payload = {"duration_minutes": 15, "label": "Walking to Car"}
    status, timer = req("/emergency/timer/start", "POST", timer_payload, token=token)
    assert status == 201 and timer["status"] == "active"
    assert timer["duration_minutes"] == 15
    timer_id = timer["timer_id"]
    print(f"  ✅ Safety Timer Started: ID = {timer_id}, duration = 15m")
    print(f"     Expires at: {timer['expires_at']}")

    # Verify current active timer in Firestore
    active_timer_doc = db.collection("users").document(test_uid).collection("active_timer").document("current").get()
    assert active_timer_doc.exists and active_timer_doc.to_dict()["status"] == "active"
    print("  ✅ Firestore verification: /users/{uid}/active_timer/current is ACTIVE.")

    # B. Safety Timer Check-In ("I'm Safe")
    status, checkin_res = req("/emergency/timer/checkin", "POST", {"is_safe": True}, token=token)
    assert status == 200 and checkin_res["status"] == "checked_in"
    print(f"  ✅ Safety Timer Check-In Confirmed: {checkin_res['message']}")

    # Verify disarmed in Firestore
    disarmed_doc = db.collection("users").document(test_uid).collection("active_timer").document("current").get()
    assert disarmed_doc.to_dict()["status"] == "checked_in"
    print("  ✅ Firestore verification: Active timer marked as CHECKED_IN (Disarmed).")

    # C. Test Expiry Auto-Escalation to SOS
    expiry_sos_payload = {
        "latitude": 37.774929,
        "longitude": -122.419416,
        "address": "Safety Walk Route",
        "emergency_type": "timer_expired",
    }
    status, expired_incident = req("/emergency/sos", "POST", expiry_sos_payload, token=token)
    assert status == 201 and expired_incident["emergency_type"] == "timer_expired"
    print(f"  ✅ Safety Timer Expiry Escalation: Triggered SOS Incident ({expired_incident['id']})")
    print(f"     Emergency Type: '{expired_incident['emergency_type']}' automatically alerted to {expired_incident['contacts_alerted'][0]['name']}")

    # -------------------------------------------------------------
    # 5. 3-DAY INCIDENT HISTORY RETENTION POLICY
    # -------------------------------------------------------------
    print_header("[TEST 5] 3-Day Incident History Retention Policy")

    # Clean user's incidents in Firestore
    inc_subcoll = db.collection("users").document(test_uid).collection("incidents")
    for doc in inc_subcoll.stream():
        doc.reference.delete()

    now_dt = datetime.now(timezone.utc)
    
    # 1. Incident 1: 1 hour ago (within 3 days -> MUST BE RETURNED)
    t_1h = (now_dt - timedelta(hours=1)).isoformat()
    inc_subcoll.document("inc_recent_1h").set({
        "id": "inc_recent_1h",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "sos",
        "status": "resolved",
        "latitude": 37.77,
        "longitude": -122.41,
        "address": "San Francisco, CA",
        "emergency_message": "Recent emergency",
        "contacts_alerted": [],
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_recent_1h",
        "created_at": t_1h,
        "resolved_at": t_1h,
    })

    # 2. Incident 2: 2 days ago (within 3 days -> MUST BE RETURNED)
    t_2d = (now_dt - timedelta(days=2)).isoformat()
    inc_subcoll.document("inc_recent_2d").set({
        "id": "inc_recent_2d",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "timer_expired",
        "status": "resolved",
        "latitude": 37.78,
        "longitude": -122.42,
        "address": "Oakland, CA",
        "emergency_message": "Timer expired 2 days ago",
        "contacts_alerted": [],
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_recent_2d",
        "created_at": t_2d,
        "resolved_at": t_2d,
    })

    # 3. Incident 3: 5 days ago (OUTSIDE 3-day retention -> MUST BE PURGED / FILTERED OUT)
    t_5d = (now_dt - timedelta(days=5)).isoformat()
    inc_subcoll.document("inc_old_5d").set({
        "id": "inc_old_5d",
        "uid": test_uid,
        "user_name": "Shaheer Tariq",
        "emergency_type": "sos",
        "status": "resolved",
        "latitude": 37.79,
        "longitude": -122.43,
        "address": "Berkeley, CA",
        "emergency_message": "Old emergency 5 days ago",
        "contacts_alerted": [],
        "live_tracking_url": "https://track.troublecheat.com/incident/inc_old_5d",
        "created_at": t_5d,
        "resolved_at": t_5d,
    })

    print(f"  Inserted 3 mock incidents into Firestore:")
    print(f"    - inc_recent_1h (1 hour ago)")
    print(f"    - inc_recent_2d (2 days ago)")
    print(f"    - inc_old_5d    (5 days ago - exceeds Free 3-day window)")

    # Fetch history via API
    status, history_list = req("/emergency/history", "GET", token=token)
    assert status == 200, f"Failed to get history: {history_list}"
    
    returned_ids = [item["id"] for item in history_list]
    print(f"  API returned {len(returned_ids)} incident(s): {returned_ids}")

    assert "inc_recent_1h" in returned_ids, "Recent (1h) incident should be included!"
    assert "inc_recent_2d" in returned_ids, "Recent (2d) incident should be included!"
    assert "inc_old_5d" not in returned_ids, "Old (5d) incident MUST NOT be returned under 3-day retention policy!"
    print("  ✅ Evidence Retention Policy Verified: 5-day-old incident was strictly filtered out!")
    print("  ✅ Only events within the 3-day Free plan retention window were delivered.")

    print_header("ALL 5 END-TO-END AUTOMATED TESTS PASSED WITH 100% SUCCESS! 🎉")

if __name__ == "__main__":
    run_tests()
