#!/bin/bash
# Script to launch Firebase Local Emulator Suite
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

if [ -d "$DIR/emulator_data" ]; then
    echo "📦 Found saved emulator data in $DIR/emulator_data. Loading saved data..."
    firebase emulators:start --import=./emulator_data --export-on-exit=./emulator_data
else
    echo "⚠️ No saved emulator data found. Starting fresh and exporting on exit to ./emulator_data..."
    firebase emulators:start --export-on-exit=./emulator_data
fi
