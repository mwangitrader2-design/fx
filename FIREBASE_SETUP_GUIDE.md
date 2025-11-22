# Firebase Setup Guide for Kimutai FX

Follow these steps to set up Firebase for logging and analytics in your trading app.

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or select existing project
3. Enter project name: `kimutai-fx` (or your preferred name)
4. Disable Google Analytics (optional, can enable later)
5. Click **"Create project"**

## Step 2: Register Your Android App

1. In Firebase Console, click the **Android icon** (⚙️ gear icon)
2. Enter Android package name: `com.kimutai.fx` (must match your app)
   - Find it in: `android/app/build.gradle` → `applicationId`
3. App nickname (optional): `Kimutai FX Android`
4. Click **"Register app"**

## Step 3: Download Configuration File

1. Download `google-services.json`
2. Place it in: `android/app/google-services.json`
   ```
   kimutai_fx/
   └── android/
       └── app/
           └── google-services.json  ← Put it here
   ```

## Step 4: Update Android Build Files

### 4a. Update `android/build.gradle`:

Add Google services classpath in `buildscript` → `dependencies`:

```gradle
buildscript {
    dependencies {
        // Add this line:
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### 4b. Update `android/app/build.gradle`:

Add at the **very bottom** of the file:

```gradle
// At the bottom of the file, add:
apply plugin: 'com.google.gms.google-services'
```

## Step 5: Enable Firebase Services

In Firebase Console:

### 5a. Enable Firestore Database
1. Go to **Firestore Database**
2. Click **"Create database"**
3. Choose **"Start in test mode"** (for development)
4. Select a location (choose closest to you)
5. Click **"Enable"**

### 5b. Enable Realtime Database (Optional)
1. Go to **Realtime Database**
2. Click **"Create database"**
3. Choose **"Start in test mode"**
4. Click **"Enable"**

### 5c. Enable Analytics (Optional)
1. Go to **Analytics**
2. Click **"Enable Google Analytics"**
3. Follow the setup wizard

## Step 6: Create Firebase Options File

Run this command in your project root:

```bash
# Install FlutterFire CLI (first time only)
dart pub global activate flutterfire_cli

# Generate Firebase configuration
flutterfire configure
```

This will create `lib/firebase_options.dart` automatically.

**OR** manually create the file (if CLI doesn't work):

Create `lib/firebase_options.dart`:

```dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',  // Get from google-services.json → current_key → api_key
    appId: 'YOUR_APP_ID',    // Get from google-services.json → client → mobilesdk_app_id
    messagingSenderId: 'YOUR_SENDER_ID',  // Get from google-services.json → project_number
    projectId: 'YOUR_PROJECT_ID',  // Get from google-services.json → project_id
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',  // Get from google-services.json → storage_bucket
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.kimutai.fx',
  );
}
```

## Step 7: Update main.dart

Your `lib/main.dart` needs to initialize Firebase:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // Add this import
// ... other imports

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Add this
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const KimutaiFXApp());
}
```

## Step 8: Verify Setup

Run this test to verify Firebase is working:

```bash
flutter run
```

You should see in console:
```
✓ Firebase initialized successfully
```

## Step 9: Test Logging

Once app is running, go to **Signals Page** and pull to refresh. Check:

1. **Flutter Console** - Should see Firebase events
2. **Firebase Console → Analytics → Events** - Should see events logged
3. **Firestore → logs collection** - Should see log documents

## Quick Commands

```bash
# Check your Android package name
grep applicationId android/app/build.gradle

# Install dependencies
flutter pub get

# Run app
flutter run

# Clean and rebuild (if issues)
flutter clean
flutter pub get
flutter run
```

## Troubleshooting

### Error: "No Firebase App '[DEFAULT]' has been created"
- ✅ Make sure `Firebase.initializeApp()` is called in `main()`
- ✅ Make sure `WidgetsFlutterBinding.ensureInitialized()` is called first
- ✅ Check `firebase_options.dart` exists

### Error: "google-services.json not found"
- ✅ Place file in `android/app/google-services.json`
- ✅ Run `flutter clean && flutter pub get`

### Error: Build fails with Google Services error
- ✅ Check `android/build.gradle` has `classpath 'com.google.gms:google-services:4.4.0'`
- ✅ Check `android/app/build.gradle` has `apply plugin: 'com.google.gms.google-services'` at bottom

### Events not showing in Firebase Console
- ✅ Wait 10-30 minutes (Analytics has delay)
- ✅ Check Firestore → logs collection (immediate)
- ✅ Enable Debug mode in Analytics

## Security Rules (Production)

Before deploying to production, update Firestore rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /logs/{document=**} {
      allow read, write: if request.auth != null;  // Only authenticated users
    }
    match /trades/{document=**} {
      allow read, write: if request.auth != null;
    }
    match /portfolios/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## What Gets Logged

Your app logs these events:

- `fetching_mt5_chart_data` - When fetching market data
- `mt5_data_fetch_failed` - When data fetch fails
- `signal_rejected_low_confidence` - When signal confidence < threshold
- `signal_generated` - When high-confidence signal is created
- `trade_executed` - When trade is placed
- `trade_closed` - When trade is closed
- `portfolio_updated` - When portfolio changes

## Firebase Console URLs

- **Project Overview**: https://console.firebase.google.com/project/YOUR_PROJECT_ID
- **Firestore**: https://console.firebase.google.com/project/YOUR_PROJECT_ID/firestore
- **Analytics**: https://console.firebase.google.com/project/YOUR_PROJECT_ID/analytics
- **Realtime Database**: https://console.firebase.google.com/project/YOUR_PROJECT_ID/database

---

**Next Steps**: After Firebase is set up, your signal generation will automatically log all events for debugging and analytics! 🎉
