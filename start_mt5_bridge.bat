@echo off
echo ========================================
echo   MT5 Bridge Server Startup
echo ========================================
echo.

echo Checking Python installation...
python --version
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    pause
    exit /b 1
)

echo.
echo Installing/Updating dependencies...
pip install -r requirements.txt

echo.
echo ========================================
echo   Starting MT5 Bridge Server
echo ========================================
echo.
echo IMPORTANT: Make sure MetaTrader 5 is running!
echo.
echo Server will start on http://localhost:5000
echo Press Ctrl+C to stop the server
echo.
pause

python mt5_bridge_server.py
