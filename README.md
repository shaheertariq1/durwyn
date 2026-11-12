# Trouble-Cheat Security App (Durwyn Talley)

A comprehensive personal safety and emergency response platform consisting of a Flutter mobile application (iOS & Android), a high-performance FastAPI backend connected to Firebase (Auth, Firestore, Cloud Storage), and a Vite/React Admin Dashboard.

---

## Architecture Overview

```
├── backend/                  # FastAPI REST API (Firebase Admin SDK, Auth, Firestore, Emergency Services)
├── durwyn_talley-app/        # Flutter Mobile Application (iOS & Android)
├── durwyn_admin_panel-main/  # Web Admin Dashboard (Vite + React)
├── start_all.sh              # Local development launcher
└── stop_all.sh               # Shutdown script
```

---

## Core Capabilities

1. **Emergency & SOS Operations**:
   - One-touch and discreet voice-triggered SOS distress broadcasting.
   - Real-time GPS coordinate streaming with public/emergency contact web tracking links.
   - Incident audit trails and resolution lifecycle tracking.

2. **24/7 Safety Timers**:
   - Time-bound safety checks (e.g., walking home, meeting a stranger).
   - "I'm Safe" check-in mechanism.
   - Automatic escalation to emergency contacts upon expired timer window.

3. **Live Phone Code (SMS OTP) Verification**:
   - E.164 phone number verification via Firebase Phone Auth & Firestore session verification.
   - Resend timer handling and automated profile verification flagging.

4. **Notifications Architecture**:
   - Native OS system alerts via `flutter_local_notifications` for SOS alerts, timers, and security verifications.
   - In-app notification center with real-time Firestore persistence and read-state management.

5. **Subscription Tier Entitlements**:
   - Tiered plans (`Free`, `Standard`, `Premium`) governing contact limits, cloud evidence retention, and advanced radar monitoring.

---

## Getting Started

### 1. Prerequisites
- Python 3.11+
- Flutter 3.24+
- Node.js 18+ (for Admin Panel)
- Firebase Project configured with Google Cloud Application Default Credentials

### 2. Backend Setup
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
./run_backend.sh
```

### 3. Flutter App Setup
```bash
cd durwyn_talley-app
cp .env.example .env
flutter pub get
flutter run
```

### 4. Admin Panel Setup
```bash
cd durwyn_admin_panel-main
npm install
npm run dev
```

---

## License
Proprietary & Confidential. All rights reserved.
