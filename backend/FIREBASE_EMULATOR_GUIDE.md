# Firebase Local Emulator Suite Guide — Trouble Cheat

This document contains all necessary commands, setup instructions, and connection guidelines for running the **Firebase Local Emulator Suite** (Auth, Cloud Firestore, Firebase Storage, and Emulator UI) on macOS.

---

## 1. Emulator Ports & Endpoints

| Service | Port | Host | Web / API Endpoint |
| :--- | :--- | :--- | :--- |
| **Emulator UI** | `4000` | `0.0.0.0` | [http://localhost:4000](http://localhost:4000) |
| **Authentication** | `9099` | `0.0.0.0` | `http://localhost:9099` |
| **Cloud Firestore** | `8080` | `0.0.0.0` | `http://localhost:8080` |
| **Cloud Storage** | `9199` | `0.0.0.0` | `http://localhost:9199` |

> **Note:** The host is bound to `0.0.0.0` in `firebase.json` so that both your Mac browser (`localhost`) and Android emulators (`10.0.2.2`) can connect seamlessly.

---

## 2. Environment Setup (Java Runtime)

Firebase Emulator Suite requires a Java Runtime Environment (JRE). macOS has Android Studio's bundled OpenJDK available.

### One-Time Terminal Export (Session):
```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

### Permanent Setup (Recommended):
Add this to your `~/.zshrc`:
```bash
echo 'export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"' >> ~/.zshrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify Java is recognized:
```bash
java -version
```

---

## 3. Necessary Firebase Emulator Commands

### A. Starting the Emulators
| Command | Description |
| :--- | :--- |
| `firebase emulators:start` | Starts all configured emulators (Auth, Firestore, Storage, UI). |
| `firebase emulators:start --only auth,firestore,storage` | Starts only selected services. |
| `firebase emulators:start --export-on-exit=./emulator_data` | Automatically saves all created test accounts, documents, and files to `./emulator_data` when you stop with `Ctrl + C`. |
| `firebase emulators:start --import=./emulator_data` | Starts emulators loaded with previously saved data. |
| `firebase emulators:start --import=./emulator_data --export-on-exit` | **(Recommended)** Loads saved test data on launch and saves updates when quitting. |

### B. Setup & Pre-caching Binaries
| Command | Description |
| :--- | :--- |
| `firebase setup:emulators:firestore` | Downloads the Cloud Firestore emulator jar. |
| `firebase setup:emulators:storage` | Downloads the Cloud Storage emulator jar. |
| `firebase setup:emulators:ui` | Downloads the Emulator UI package. |

### C. Automated Testing / Execution
| Command | Description |
| :--- | :--- |
| `firebase emulators:exec "npm test"` | Starts emulators, runs your test script, and shuts down emulators automatically. |

### D. Resetting / Clearing Data
To wipe all test accounts and database records:
```bash
rm -rf ./emulator_data
```

---

## 4. Connecting from Flutter App

In Flutter, configure your Firebase instances during app initialization (e.g. in `main.dart` or your DI service) before interacting with Firebase:

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> setupFirebaseEmulators() async {
  // If running in debug/development mode:
  if (kDebugMode) {
    // Android emulator connects to host via 10.0.2.2; iOS Simulator connects via localhost (127.0.0.1)
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';

    // 1. Auth Emulator
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);

    // 2. Firestore Emulator
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);

    // 3. Storage Emulator
    await FirebaseStorage.instance.useStorageEmulator(host, 9199);

    print('Connected to Firebase Local Emulators on host: $host');
  }
}
```

---

## 5. Network Address Reference

* **Mac Browser:** Open [http://localhost:4000](http://localhost:4000) to view the Firebase Emulator Web UI.
* **Android Emulator (Pixel 7):** Use `10.0.2.2:<port>`.
* **iOS Simulator:** Use `127.0.0.1:<port>`.
* **Physical Device over Wi-Fi:** Use your Mac's LAN IP (e.g. `192.168.1.x:<port>`).

---

## 6. Helper Quick Script

You can run the emulator with persistent data anytime using:

```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
firebase emulators:start --import=./emulator_data --export-on-exit=./emulator_data
```
