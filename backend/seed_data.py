#!/usr/bin/env python3
"""
Seed Script for Durwyn Talley Firebase Emulator Suite.
Populates standard/premium/free test users, emergency contacts, phrases, and mock incidents.
"""
import os
import sys
import argparse
from datetime import datetime, timezone, timedelta

# Connect directly to live Firebase project
os.environ["GCLOUD_PROJECT"] = "trouble-cheat-security-app"
os.environ.pop("FIREBASE_AUTH_EMULATOR_HOST", None)
os.environ.pop("FIRESTORE_EMULATOR_HOST", None)
os.environ.pop("STORAGE_EMULATOR_HOST", None)

from app.core.firebase import init_firebase, get_firestore, get_auth

DUMMY_USERS = [
    {
        "email": "free_user@troublecheat.com",
        "name": "Alex Free",
        "phone": "+14155551001",
        "plan": "free",
    },
    {
        "email": "standard_user@troublecheat.com",
        "name": "Sam Standard",
        "phone": "+14155551002",
        "plan": "standard",
    },
    {
        "email": "premium_user@troublecheat.com",
        "name": "Jordan Premium",
        "phone": "+14155551003",
        "plan": "premium",
    },
    {
        "email": "iamshaheertariq@gmail.com",
        "name": "Shaheer Tariq",
        "phone": "+923235956666",
        "plan": "premium",
    },
]


def seed_database(target_plan="premium", email="iamshaheertariq@gmail.com", name=None, phone=None):
    print(f"\n🌱 Seeding account: {email} (Plan: {target_plan.upper()})...")
    init_firebase()
    db = get_firestore()
    auth = get_auth()

    # Determine name and phone
    default_name = name or ("Shaheer Tariq" if "shaheer" in email.lower() else "Durwyn Talley")
    default_phone = phone or ("+923235956666" if "shaheer" in email.lower() else "+14155552671")

    # 1. Ensure User in Auth Emulator
    try:
        user = auth.get_user_by_email(email)
        uid = user.uid
        auth.update_user(uid, password="Password123!", display_name=default_name, phone_number=default_phone)
        print(f"  ✅ Found existing auth user: {email} (UID: {uid}) and reset password.")
    except Exception:
        try:
            user = auth.create_user(
                email=email,
                password="Password123!",
                display_name=default_name,
                phone_number=default_phone
            )
            uid = user.uid
            print(f"  ✅ Created new auth user: {email} (UID: {uid})")
        except Exception as e:
            # If phone exists, create without phone then update
            user = auth.create_user(
                email=email,
                password="Password123!",
                display_name=default_name
            )
            uid = user.uid
            print(f"  ✅ Created new auth user (no phone collision): {email} (UID: {uid})")

    resolved_name = default_name
    resolved_phone = default_phone

    now_iso = datetime.now(timezone.utc).isoformat()

    # 2. Update User Profile & Plan
    user_ref = db.collection("users").document(uid)
    plan_data = {
        "uid": uid,
        "email": email,
        "full_name": resolved_name,
        "fullName": resolved_name,
        "name": resolved_name,
        "phone_number": resolved_phone,
        "phoneNumber": resolved_phone,
        "subscription_plan": target_plan.lower(),
        "subscriptionPlan": target_plan.lower(),
        "plan": target_plan.lower(),
        "subscription": {
            "tier": target_plan.lower(),
            "status": "active",
            "activatedAt": now_iso,
            "expiresAt": (datetime.now(timezone.utc) + timedelta(days=365)).isoformat()
        },
        "emergency_phrase": "Red Umbrella",
        "emergencyPhrase": "Red Umbrella",
        "emergency_message": "Stealth emergency alert! Please track my location immediately.",
        "emergencyMessage": "Stealth emergency alert! Please track my location immediately.",
        "avatar_url": "",
        "avatarUrl": "",
        "is_email_verified": True,
        "isEmailVerified": True,
        "created_at": now_iso,
        "createdAt": now_iso,
        "updated_at": now_iso,
        "updatedAt": now_iso
    }
    user_ref.set(plan_data, merge=True)
    print(f"  ✅ User profile updated: Plan set to '{target_plan.upper()}'.")

    # 3. Seed Emergency Contacts
    contacts_ref = db.collection("users").document(uid).collection("contacts")
    for doc in contacts_ref.stream():
        doc.reference.delete()

    sample_contacts = [
        {"name": "Sarah Connor", "phone": "+14155552671", "relationship": "Mother"},
        {"name": "John Connor", "phone": "+14155552672", "relationship": "Brother"},
        {"name": "Kyle Reese", "phone": "+14155552673", "relationship": "Partner"},
        {"name": "Dr. Silberman", "phone": "+14155552674", "relationship": "Doctor"},
        {"name": "Miles Dyson", "phone": "+14155552675", "relationship": "Colleague"},
        {"name": "Danny Dyson", "phone": "+14155552676", "relationship": "Friend"},
        {"name": "Tarissa Dyson", "phone": "+14155552677", "relationship": "Emergency Contact"},
    ]

    limit = 7 if target_plan.lower() == "premium" else (4 if target_plan.lower() == "standard" else 1)
    seeded_contacts = sample_contacts[:limit]

    for idx, c in enumerate(seeded_contacts):
        doc_id = f"contact_{idx + 1}"
        contact_dict = {
            "id": doc_id,
            "uid": uid,
            "full_name": c["name"],
            "name": c["name"],
            "phone_number": c["phone"],
            "phoneNumber": c["phone"],
            "relationship": c["relationship"],
            "email": f"{c['name'].lower().replace('.', '').replace(' ', '.')}@example.com",
            "allow_gps": True,
            "allow_audio": True,
            "allow_video": True,
            "canReceiveLiveLocation": True,
            "canReceiveAudioRecordings": True,
            "canReceiveMedicalInfo": True,
            "priority": idx + 1,
            "created_at": now_iso,
            "createdAt": now_iso,
            "updated_at": now_iso,
            "updatedAt": now_iso
        }
        contacts_ref.document(doc_id).set(contact_dict)
    print(f"  ✅ Seeded {len(seeded_contacts)} emergency contacts for {target_plan.upper()} tier.")

    # 4. Seed Mock Emergency Incidents
    incidents_ref = db.collection("users").document(uid).collection("incidents")
    for doc in incidents_ref.stream():
        doc.reference.delete()

    mock_incidents = [
        {
            "id": "inc_recent_1h",
            "uid": uid,
            "user_name": resolved_name,
            "user_phone": resolved_phone,
            "emergency_type": "standard",
            "status": "resolved",
            "latitude": 37.7749,
            "longitude": -122.4194,
            "address": "Market St & 4th St, San Francisco, CA",
            "emergency_message": "SOS triggered during testing",
            "contacts_alerted": [
                {"name": c["name"], "phone": c["phone"], "relationship": c["relationship"], "status": "delivered"}
                for c in seeded_contacts
            ],
            "live_tracking_url": "https://track.troublecheat.com/incident/inc_recent_1h",
            "created_at": (datetime.now(timezone.utc) - timedelta(hours=1)).isoformat(),
            "resolved_at": (datetime.now(timezone.utc) - timedelta(minutes=45)).isoformat(),
        },
        {
            "id": "inc_recent_2d",
            "uid": uid,
            "user_name": resolved_name,
            "user_phone": resolved_phone,
            "emergency_type": "silent",
            "status": "resolved",
            "latitude": 37.7833,
            "longitude": -122.4167,
            "address": "Civic Center Plaza, San Francisco, CA",
            "emergency_message": "Stealth SOS alert",
            "contacts_alerted": [
                {"name": c["name"], "phone": c["phone"], "relationship": c["relationship"], "status": "delivered"}
                for c in seeded_contacts
            ],
            "live_tracking_url": "https://track.troublecheat.com/incident/inc_recent_2d",
            "created_at": (datetime.now(timezone.utc) - timedelta(days=2)).isoformat(),
            "resolved_at": (datetime.now(timezone.utc) - timedelta(days=2, hours=-1)).isoformat(),
        },
        {
            "id": "inc_test_10d",
            "uid": uid,
            "user_name": resolved_name,
            "user_phone": resolved_phone,
            "emergency_type": "voice",
            "status": "resolved",
            "latitude": 37.7699,
            "longitude": -122.4469,
            "address": "Buena Vista Park, San Francisco, CA",
            "emergency_message": "Voice trigger SOS",
            "contacts_alerted": [
                {"name": c["name"], "phone": c["phone"], "relationship": c["relationship"], "status": "delivered"}
                for c in seeded_contacts
            ],
            "live_tracking_url": "https://track.troublecheat.com/incident/inc_test_10d",
            "created_at": (datetime.now(timezone.utc) - timedelta(days=10)).isoformat(),
            "resolved_at": (datetime.now(timezone.utc) - timedelta(days=10, hours=-1)).isoformat(),
        }
    ]

    for inc in mock_incidents:
        incidents_ref.document(inc["id"]).set(inc)
    print(f"  ✅ Seeded {len(mock_incidents)} incident logs into user history.")
    print(f"  ✨ Seed complete for {email} ({target_plan.upper()})")


def seed_all():
    print("🌱 Initializing Firebase Admin connecting to Emulators...")
    init_firebase()
    for acc in DUMMY_USERS:
        seed_database(target_plan=acc["plan"], email=acc["email"], name=acc["name"], phone=acc["phone"])
    print("\n" + "="*60)
    print("✨ ALL 3 TIER DUMMY ACCOUNTS READY TO USE:")
    print("   1. Free Tier:     free_user@troublecheat.com     (Password123!)")
    print("   2. Standard Tier: standard_user@troublecheat.com (Password123!)")
    print("   3. Premium Tier:  premium_user@troublecheat.com  (Password123!)")
    print("   4. Master User:   iamshaheertariq@gmail.com      (Password123!)")
    print("="*60 + "\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Seed Firebase Emulator Database")
    parser.add_argument("--plan", choices=["free", "standard", "premium"], help="Plan to assign")
    parser.add_argument("--email", help="User email")
    parser.add_argument("--all", action="store_true", help="Seed all tier dummy accounts")
    args = parser.parse_args()

    if args.plan and args.email:
        seed_database(target_plan=args.plan, email=args.email)
    else:
        seed_all()
