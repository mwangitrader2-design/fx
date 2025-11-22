# Firebase Setup Guide

## Overview

This guide walks you through setting up Firebase for the AI Trading System to enable:
- Real-time data synchronization
- Comprehensive logging and analytics
- Historical data storage
- Error tracking
- Performance monitoring

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name: `kimutai-fx-trading` (or your preferred name)
4. Disable Google Analytics (optional for this use case)
5. Click "Create Project"

## Step 2: Add Flutter App to Firebase

### For Android

1. In Firebase Console, click "Add app" → Android icon
2. Enter your Android package name (from `android/app/build.gradle`):
   ```
   com.example.kimutai_fx
   ```
3. Download `google-services.json`
4. Place it in `android/app/` directory
5. Follow the Firebase setup instructions to add dependencies

### For iOS

1. In Firebase Console, click "Add app" → iOS icon
2. Enter your iOS bundle ID (from `ios/Runner.xcodeproj`)
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory
5. Follow the Firebase setup instructions

### For Web

1. In Firebase Console, click "Add app" → Web icon
2. Register app and copy the configuration
3. Add Firebase SDK to `web/index.html`

## Step 3: Enable Required Services

### 1. Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in production mode"
4. Select a region close to you
5. Click "Enable"

#### Set up Security Rules

Go to "Rules" tab and update:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow authenticated users to read/write their data
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
    
    // Public read for market data (optional)
    match /market_data/{document=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

#### Create Indexes

Create composite indexes for better query performance:

1. Collection: `trades`
   - Fields: `symbol` (Ascending), `timestamp` (Descending)
   
2. Collection: `signals`
   - Fields: `symbol` (Ascending), `generatedAt` (Descending)
   
3. Collection: `logs`
   - Fields: `event` (Ascending), `timestamp` (Descending)

### 2. Realtime Database

1. In Firebase Console, go to "Realtime Database"
2. Click "Create Database"
3. Choose your region
4. Start in "locked mode"
5. Click "Enable"

#### Set up Security Rules

Go to "Rules" tab:

```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null",
    "market_data": {
      ".read": true,
      "$symbol": {
        ".write": "auth != null",
        ".indexOn": ["timestamp"]
      }
    }
  }
}
```

### 3. Firebase Authentication (Optional but Recommended)

1. Go to "Authentication"
2. Click "Get started"
3. Enable "Email/Password" sign-in method
4. Create a user for your trading system

## Step 4: Set up Firebase Admin SDK (Python Backend)

1. In Firebase Console, go to Project Settings → Service Accounts
2. Click "Generate new private key"
3. Save the JSON file as `firebase-service-account.json`
4. Place it in your project root directory
5. **Important**: Add to `.gitignore` to keep it secret:
   ```
   firebase-service-account.json
   ```

## Step 5: Flutter Configuration

### Install Firebase Packages

Your `pubspec.yaml` already has the packages. Run:

```bash
flutter pub get
```

### Initialize Firebase in Flutter

In your `main.dart`, add:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize your Firebase service
  final firebaseService = FirebaseService();
  await firebaseService.initialize();
  
  runApp(MyApp());
}
```

## Step 6: Python Backend Configuration

### Set Environment Variables

Create a `.env` file in your project root:

```bash
FIREBASE_DATABASE_URL=https://your-project-id.firebaseio.com
```

### Update Python Script

The `ai_trading_backend.py` already includes Firebase initialization. Just ensure:

1. `firebase-service-account.json` is in the project root
2. The database URL is correct

## Step 7: Test Firebase Connection

### Test from Flutter

```dart
final firebaseService = FirebaseService();
await firebaseService.initialize();

// Test logging
await firebaseService.logEvent('test_event', {
  'message': 'Firebase is working!',
  'timestamp': DateTime.now().toIso8601String(),
});

print('✅ Firebase Flutter integration working!');
```

### Test from Python

```python
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate('firebase-service-account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()
db.collection('test').add({
    'message': 'Firebase Python integration working!',
    'timestamp': firestore.SERVER_TIMESTAMP
})

print('✅ Firebase Python integration working!')
```

## Step 8: Set up Firebase Storage (Optional)

For storing ML models, charts, or other files:

1. Go to "Storage" in Firebase Console
2. Click "Get started"
3. Set up security rules:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /models/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    match /charts/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

## Data Structure

### Firestore Collections

```
firestore
├── logs                    # System logs and events
│   ├── event
│   ├── parameters
│   └── timestamp
├── errors                  # Error logs
│   ├── error
│   ├── stackTrace
│   ├── context
│   └── timestamp
├── trades                  # Trade executions
│   ├── id
│   ├── symbol
│   ├── type
│   ├── status
│   ├── entryPrice
│   ├── exitPrice
│   ├── profit
│   └── timestamp
├── signals                 # Generated signals
│   ├── id
│   ├── symbol
│   ├── type
│   ├── confidence
│   ├── entryPrice
│   ├── stopLoss
│   └── takeProfit
├── predictions             # ML predictions
│   ├── symbol
│   ├── direction
│   ├── confidence
│   └── timestamp
├── technical_analysis      # Analysis results
│   ├── symbol
│   ├── indicators
│   ├── sentiment
│   └── timestamp
├── patterns                # Pattern detections
│   ├── symbol
│   ├── patterns
│   └── timestamp
├── portfolio_history       # Portfolio snapshots
│   ├── balance
│   ├── equity
│   ├── profit
│   └── timestamp
├── performance_metrics     # Performance tracking
│   ├── winRate
│   ├── profitFactor
│   ├── sharpeRatio
│   └── timestamp
└── risk_events            # Risk management events
    ├── type
    ├── details
    └── timestamp
```

### Realtime Database Structure

```
realtime-database
└── market_data
    └── {symbol}
        └── {timestamp}
            ├── open
            ├── high
            ├── low
            ├── close
            └── volume
```

## Monitoring & Analytics

### Firebase Console Dashboards

1. **Firestore** - View all stored documents
2. **Realtime Database** - Monitor live market data
3. **Analytics** - Track events and user behavior (if enabled)
4. **Performance** - Monitor app performance metrics

### Query Examples

#### Get Recent Trades

```dart
final trades = await FirebaseFirestore.instance
    .collection('trades')
    .where('symbol', isEqualTo: 'EURUSD')
    .orderBy('timestamp', descending: true)
    .limit(10)
    .get();
```

#### Get Winning Trades

```dart
final winningTrades = await FirebaseFirestore.instance
    .collection('trades')
    .where('profit', isGreaterThan: 0)
    .where('status', isEqualTo: 'closed')
    .get();
```

#### Get High Confidence Signals

```dart
final signals = await FirebaseFirestore.instance
    .collection('signals')
    .where('confidence', isGreaterThan: 0.95)
    .orderBy('confidence', descending: true)
    .get();
```

## Security Best Practices

1. **Never commit service account keys** - Add to `.gitignore`
2. **Use environment variables** - For sensitive configuration
3. **Enable authentication** - Require auth for write operations
4. **Set up proper security rules** - Restrict access appropriately
5. **Monitor usage** - Check Firebase console regularly
6. **Set up billing alerts** - Avoid unexpected costs
7. **Regular backups** - Export important data periodically

## Cost Management

### Firebase Free Tier (Spark Plan)

- Firestore: 1GB storage, 50K reads/day, 20K writes/day
- Realtime Database: 1GB storage, 10GB/month bandwidth
- Storage: 5GB total

### Optimize Costs

1. **Use Realtime Database for market data** (cheaper for frequent updates)
2. **Use Firestore for structured data** (trades, signals, analysis)
3. **Implement data cleanup** (delete old data periodically)
4. **Use batched writes** when possible
5. **Cache frequently accessed data** on client side

## Troubleshooting

### Common Issues

1. **Permission Denied**
   - Check security rules
   - Verify authentication is working
   - Ensure service account has correct permissions

2. **Quota Exceeded**
   - Monitor Firebase usage dashboard
   - Implement rate limiting
   - Consider upgrading to Blaze plan

3. **Slow Queries**
   - Create composite indexes
   - Limit query results
   - Use pagination

4. **Connection Issues**
   - Check internet connectivity
   - Verify Firebase configuration
   - Check for service outages

## Next Steps

After Firebase is set up:

1. Run the Flutter app and verify logs appear in Firestore
2. Start the Python backend and check it can write to Firebase
3. Execute a test trade and verify it's logged
4. Review the Firebase Console to see your data

## Support

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firebase Admin Python](https://firebase.google.com/docs/admin/setup)
