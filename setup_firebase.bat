@echo off
echo ========================================
echo Firebase Setup Script for Kimutai FX
echo ========================================
echo.

echo Step 1: Installing FlutterFire CLI...
call dart pub global activate flutterfire_cli
echo.

echo Step 2: Configuring Firebase...
echo This will open your browser to select a Firebase project.
echo If you don't have one, create it at: https://console.firebase.google.com/
echo.
pause

call flutterfire configure

echo.
echo ========================================
echo Firebase Configuration Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Download google-services.json from Firebase Console
echo 2. Place it in: android\app\google-services.json
echo 3. Run: flutter clean
echo 4. Run: flutter pub get
echo 5. Run: flutter run
echo.
echo See FIREBASE_SETUP_GUIDE.md for detailed instructions.
echo.
pause
