# MT5 Integration Setup

This guide explains how to set up MetaTrader 5 integration with your Flutter trading app.

## Prerequisites

1. **MetaTrader 5 installed** on your Windows PC
2. **Python 3.8+** installed
3. **Valid MT5 trading account** with credentials

## Step 1: Install Python Dependencies

Open PowerShell/Command Prompt in the project folder and run:

```powershell
pip install -r requirements.txt
```

This installs:
- `MetaTrader5` - MT5 Python API
- `Flask` - Web server for bridge
- `flask-cors` - CORS support for Flutter app

## Step 2: Start the MT5 Bridge Server

1. **Open MetaTrader 5 application** (must be running)

2. **Start the bridge server:**
```powershell
python mt5_bridge_server.py
```

You should see:
```
Starting MT5 Bridge Server...
Make sure MetaTrader 5 is installed and running
 * Running on http://0.0.0.0:5000
```

Keep this terminal open while using the app.

## Step 3: Use the Flutter App

1. Run the Flutter app:
```powershell
flutter run
```

2. Navigate to **Settings → Broker Connection**

3. Your credentials are pre-filled:
   - **Account ID:** 130798
   - **Password:** Mare-Dewy-09
   - **Server:** EGMSecurities-Demo

4. Click **Test** to verify connection

5. Click **Login** to connect to MT5

## How It Works

```
Flutter App (Dart) → HTTP Request → Python Bridge Server → MetaTrader5 API → MT5 Terminal
```

1. **Flutter app** sends HTTP requests to the Python bridge server
2. **Python bridge** (Flask) communicates with MT5 using the official MetaTrader5 Python package
3. **MT5 terminal** must be running for the connection to work
4. **Credentials** are stored locally in SharedPreferences for convenience

## API Endpoints

The bridge server provides these endpoints:

- `GET /health` - Check if server is running
- `POST /mt5/test_connection` - Test MT5 login credentials
- `POST /mt5/login` - Login and maintain connection
- `POST /mt5/logout` - Logout from MT5
- `GET /mt5/account_info` - Get current account information
- `GET /mt5/status` - Check connection status

## Troubleshooting

### "MT5 Bridge Server is not running"
- Make sure you started the Python server: `python mt5_bridge_server.py`
- Check if port 5000 is not blocked by firewall

### "MT5 initialization failed"
- Ensure MetaTrader 5 application is installed and running
- Close and reopen MT5 terminal
- Restart the bridge server

### "Login failed"
- Verify your credentials are correct
- Check if the server name matches your broker
- Ensure your MT5 account is active

### Connection timeout
- Check if Python server is running
- Verify Flutter app can reach `http://localhost:5000`
- For Android emulator, use `http://10.0.2.2:5000` instead

## Security Notes

⚠️ **Important:**
- Never commit your real credentials to Git
- The bridge server runs on localhost only (not exposed to internet)
- Credentials are stored locally with SharedPreferences
- For production, add proper authentication and encryption

## Next Steps

Once connected, you can:
- View real-time account balance and equity
- Execute trades through the app
- Monitor open positions
- Receive trading signals

## Support

For issues specific to:
- **MT5 API:** Check [MetaTrader5 Python documentation](https://www.mql5.com/en/docs/python_metatrader5)
- **Flutter app:** Check the app logs
- **Bridge server:** Check the Python server terminal output
