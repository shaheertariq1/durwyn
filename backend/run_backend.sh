#!/bin/bash
# Script to launch FastAPI Backend Server
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "🚀 Starting FastAPI Backend Server on http://0.0.0.0:8000..."
source ./venv/bin/activate
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
