#!/bin/bash
# ==============================================================================
# Durwyn Talley - Master Dev Shutdown
# Gracefully shuts down Flutter App, iOS Simulator, FastAPI, and Firebase Emulators.
# ==============================================================================

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$ROOT_DIR/backend"

echo "🛑 Stopping all Durwyn Talley services..."

# 1. Export Firebase emulator data before exiting if running
if lsof -i :8080 > /dev/null 2>&1; then
    echo "💾 Exporting Firebase emulator data to $BACKEND_DIR/emulator_data..."
    cd "$BACKEND_DIR" && firebase emulators:export --force ./emulator_data > /dev/null 2>&1
    echo "✅ Emulator data exported successfully."
fi

# 2. Terminate Flutter processes
echo "📱 Terminating Flutter app processes..."
pkill -f "flutter_tools.snapshot" > /dev/null 2>&1
pkill -f "durwyn_talley" > /dev/null 2>&1

# 3. Shutdown iOS Simulator
echo "📲 Shutting down iOS Simulator..."
xcrun simctl shutdown all > /dev/null 2>&1
killall "Simulator" > /dev/null 2>&1

# 4. Terminate FastAPI backend server (port 8000)
echo "🚀 Terminating FastAPI backend on port 8000..."
lsof -ti :8000 | xargs kill -9 > /dev/null 2>&1

# 5. Terminate Firebase emulators (ports 8080, 9099, 4000, 4400, 9199)
echo "🔥 Terminating Firebase Emulators..."
for port in 8080 9099 4000 4400 9199; do
    lsof -ti :$port | xargs kill -9 > /dev/null 2>&1
done

echo "✨ All services, emulators, and simulators have been stopped cleanly!"
