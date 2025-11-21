# How to Connect Your Phone to MT5 Bridge Server

## Problem
Your phone cannot connect to `localhost:5000` because that only works on the same device. You need to use your PC's local network IP address.

## Solution

### Step 1: Find Your PC's IP Address

**On Windows:**
1. Open Command Prompt (CMD)
2. Type: `ipconfig`
3. Look for "IPv4 Address" under your active network adapter
4. Example: `192.168.1.100` or `192.168.100.6`

**Quick command:**
```powershell
ipconfig | findstr IPv4
```

### Step 2: Update the Flutter App

Open `lib/services/mt5_service.dart` and change line 10:

```dart
// Change from:
static const String _baseUrl = 'http://localhost:5000';

// To your PC's IP (example):
static const String _baseUrl = 'http://192.168.1.100:5000';
```

### Step 3: Start the Bridge Server

The server needs to be accessible from your local network:

```powershell
python mt5_bridge_server.py
```

The server is already configured to listen on `0.0.0.0:5000` which accepts connections from any device on your network.

### Step 4: Allow Firewall Access

**Windows Firewall:**
1. Open Windows Defender Firewall
2. Click "Allow an app through firewall"
3. Click "Change settings"
4. Find "Python" and check both Private and Public
5. Or create a new rule for port 5000

**Quick PowerShell command (Run as Administrator):**
```powershell
New-NetFirewallRule -DisplayName "MT5 Bridge Server" -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow
```

### Step 5: Make Sure Both Devices Are on Same Network

- Your PC and phone must be connected to the same WiFi network
- Both should be on the same subnet (e.g., 192.168.1.x)

### Step 6: Test the Connection

Before running the Flutter app, test if your phone can reach the server:

**From your phone's browser, open:**
```
http://YOUR_PC_IP:5000/health
```

You should see:
```json
{"status": "ok", "timestamp": "2025-11-21T..."}
```

### Common Issues & Solutions

#### Issue: "Connection refused" or "Network unreachable"
- ✅ Verify PC and phone are on same WiFi
- ✅ Check PC's IP address is correct
- ✅ Ensure firewall allows port 5000
- ✅ Make sure bridge server is running

#### Issue: "Connection timeout"
- ✅ Check if Python server is running
- ✅ Verify IP address in mt5_service.dart
- ✅ Try pinging PC from phone using ping apps
- ✅ Temporarily disable firewall to test

#### Issue: Still shows "MT5 Bridge Server not running"
- ✅ Restart the Python server
- ✅ Restart the Flutter app
- ✅ Try accessing `http://YOUR_PC_IP:5000/health` from phone browser first

### Quick Reference Table

| Device Type | Base URL to Use |
|-------------|-----------------|
| Android Emulator | `http://10.0.2.2:5000` |
| iOS Simulator | `http://localhost:5000` |
| Physical Phone (WiFi) | `http://YOUR_PC_IP:5000` |
| Same PC | `http://localhost:5000` |

### Example Setup

**My PC IP:** `192.168.1.100`

**In mt5_service.dart:**
```dart
static const String _baseUrl = 'http://192.168.1.100:5000';
```

**Test from phone browser:**
```
http://192.168.1.100:5000/health
```

**Everything working?** ✅ Now run your Flutter app!

---

## Alternative: Use ngrok for Easy Access

If you're having trouble with network/firewall:

1. Install ngrok: https://ngrok.com/download
2. Run: `ngrok http 5000`
3. Copy the HTTPS URL (e.g., `https://abc123.ngrok.io`)
4. Update `_baseUrl` in mt5_service.dart

This creates a public tunnel to your local server.
