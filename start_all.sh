#!/bin/bash
# ==============================================================================
# Durwyn Talley - Master Dev Launcher
# Starts Firebase Emulators (with saved data imported), FastAPI backend,
# and optionally launches the Flutter App on the iOS Simulator.
# ==============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$ROOT_DIR/backend"
APP_DIR="$ROOT_DIR/durwyn_talley-app"

echo "=========================================================="
echo "🛡️  STARTING DURWYN TALLEY DEV ENVIRONMENT"
echo "=========================================================="

# 1. Start Firebase Local Emulators (Importing saved ./emulator_data)
echo "1️⃣  Checking Firebase Emulators..."
if lsof -i :8080 > /dev/null 2>&1; then
    echo "   ✅ Firebase Firestore emulator is already running on port 8080."
else
    echo "   🔥 Launching Firebase Emulators with saved data import..."
    "$BACKEND_DIR/run_emulators.sh" > /dev/null 2>&1 &
    EMULATOR_PID=$!
    echo "   ⏳ Waiting for emulators to initialize (PID: $EMULATOR_PID)..."
    for i in {1..30}; do
        if lsof -i :8080 > /dev/null 2>&1 && lsof -i :9099 > /dev/null 2>&1; then
            echo "   ✅ Firebase Emulators ready (Auth: 9099, Firestore: 8080, UI: 4000)."
            break
        fi
        sleep 1
    done
fi

# 2. Start FastAPI Backend Server
echo "2️⃣  Checking FastAPI Backend Server..."
if lsof -i :8000 > /dev/null 2>&1; then
    echo "   ✅ FastAPI backend is already running on port 8000."
else
    echo "   🚀 Launching FastAPI backend server on http://0.0.0.0:8000..."
    "$BACKEND_DIR/run_backend.sh" > /dev/null 2>&1 &
    BACKEND_PID=$!
    echo "   ⏳ Waiting for FastAPI to initialize (PID: $BACKEND_PID)..."
    for i in {1..20}; do
        if lsof -i :8000 > /dev/null 2>&1; then
            echo "   ✅ FastAPI Backend ready on http://0.0.0.0:8000."
            break
        fi
        sleep 1
    done
fi

# 3. Seed / Verify Data
echo "3️⃣  Verifying Test Data in Firebase..."
if [ -x "$BACKEND_DIR/venv/bin/python3" ]; then
    "$BACKEND_DIR/venv/bin/python3" "$BACKEND_DIR/seed_data.py" --plan premium
else
    python3 "$BACKEND_DIR/seed_data.py" --plan premium
fi

echo "=========================================================="
echo "✨ ALL SERVICES ARE LIVE AND DATA IS SEEDED!"
echo "   - Test User: iamshaheertariq@gmail.com (Password: Password123!)"
echo "   - Tier: Premium (7 contacts, 30-day history, Safety Monitor)"
echo "   - Firebase UI: http://localhost:4000"
echo "   - API Docs:    http://localhost:8000/docs"
echo "=========================================================="

# 4. Optional Flutter Launch
if [ "$1" == "--run-app" ] || [ "$1" == "-a" ]; then
    echo "📱 Launching Flutter App on iPhone 17 Pro simulator..."
    cd "$APP_DIR"
    flutter run -d "iPhone 17 Pro"
fi
