# 🚀 Quick Firebase Setup (5 Minutes)

## Option 1: Automated Setup (Recommended)

1. **Run the setup script:**
   ```bash
   setup_firebase.bat
   ```

2. **Select or create Firebase project** when prompted

3. **Download `google-services.json`:**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Select your project
   - Click ⚙️ (Project Settings)
   - Scroll to "Your apps" → Android app
   - Click "Download google-services.json"
   - Place in: `android/app/google-services.json`

4. **Run the app:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## Option 2: Manual Setup

### Step 1: Create Firebase Project

1. Go to https://console.firebase.google.com/
2. Click "Add project"
3. Name it: `kimutai-fx`
4. Create project

### Step 2: Add Android App

1. In Firebase Console, click Android icon
2. Package name: `com.example.kimutai_fx` (from your build.gradle)
3. Download `google-services.json`
4. Place in: `android/app/google-services.json`

### Step 3: Update firebase_options.dart

Open `lib/firebase_options.dart` and replace placeholders with values from your `google-services.json`:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSy...',  // From: client[0].api_key[0].current_key
  appId: '1:123...',     // From: client[0].client_info.mobilesdk_app_id
  messagingSenderId: '123456789',  // From: project_number
  projectId: 'kimutai-fx',  // From: project_id
  storageBucket: 'kimutai-fx.appspot.com',  // From: storage_bucket
);
```

### Step 4: Enable Firestore

1. In Firebase Console → Firestore Database
2. Click "Create database"
3. Start in **test mode**
4. Choose location
5. Enable

### Step 5: Run App

```bash
flutter clean
flutter pub get
flutter run
```

## ✅ Verify Setup

When you open the Signals page and pull to refresh, you should see:

1. **Console Output:**
   ```
   🔍 Analyzing EURUSD...
   ✅ Signal generated for EURUSD: BUY (87.5%)
   ```

2. **Firebase Console → Firestore → `logs` collection:**
   - See `fetching_mt5_chart_data` events
   - See `signal_generated` events

3. **No more Firebase errors** in console

## 🐛 Troubleshooting

### "No Firebase App '[DEFAULT]' has been created"
✅ Make sure `firebase_options.dart` has correct values
✅ Run `flutter clean && flutter pub get`

### "google-services.json not found"
✅ File must be at: `android/app/google-services.json`
✅ Not in `android/` root!

### Build error: "Could not find com.google.gms:google-services"
✅ Check `android/build.gradle` has:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

### App crashes on startup
✅ Check `firebase_options.dart` values match your project
✅ Verify `google-services.json` is for the correct project

## 📝 What's Been Done

✅ `main.dart` - Added Firebase initialization
✅ `firebase_options.dart` - Created configuration file (needs your values)
✅ `android/build.gradle` - Added Google Services plugin
✅ `android/app/build.gradle` - Applied Google Services plugin

## 🎯 What You Need To Do

1. ⏳ Create Firebase project (if you don't have one)
2. ⏳ Download `google-services.json` → place in `android/app/`
3. ⏳ Update `firebase_options.dart` with your project values
4. ⏳ Run `flutter clean && flutter pub get && flutter run`

## 📚 Need More Help?

See **`FIREBASE_SETUP_GUIDE.md`** for detailed step-by-step instructions with screenshots.

---

**After setup, your app will automatically log:**
- Market data fetching
- Signal generation events
- Trade executions
- Portfolio updates
- Error events

All viewable in Firebase Console! 🎉
