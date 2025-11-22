"""
Direct MT5 Connection Test
This script tests MT5 connection directly without the Flask server
"""

import MetaTrader5 as mt5
import sys

print("=" * 60)
print("MT5 Direct Connection Test")
print("=" * 60)

# Your credentials
username = 130798
password = "Mare-Dewy-09"
server = "EGMSecurities-Demo"

print(f"\n1. Testing MT5 initialization...")
if not mt5.initialize():
    error_code, error_msg = mt5.last_error()
    print(f"   ❌ FAILED: {error_msg} (Code: {error_code})")
    
    if error_code == -6:
        print("\n" + "=" * 60)
        print("ERROR CODE -6: Algo Trading is DISABLED")
        print("=" * 60)
        print("\n🔧 FIX THIS NOW:")
        print("   1. Open MetaTrader 5")
        print("   2. Click Tools → Options (or press Ctrl+O)")
        print("   3. Go to 'Expert Advisors' tab")
        print("   4. CHECK these boxes:")
        print("      ✓ Allow algorithmic trading")
        print("      ✓ Allow DLL imports")
        print("   5. Click OK")
        print("   6. Close and reopen MT5")
        print("   7. Run this script again")
        print("=" * 60)
    
    sys.exit(1)

print(f"   ✅ SUCCESS: MT5 initialized")
print(f"   MT5 Version: {mt5.version()}")
print(f"   MT5 Terminal Info: {mt5.terminal_info()}")

print(f"\n2. Testing login with your credentials...")
print(f"   Username: {username}")
print(f"   Server: {server}")
print(f"   Password: {'*' * len(password)}")

authorized = mt5.login(username, password=password, server=server)

if not authorized:
    error_code, error_msg = mt5.last_error()
    print(f"   ❌ LOGIN FAILED: {error_msg} (Code: {error_code})")
    
    print("\n" + "=" * 60)
    print("LOGIN ERROR TROUBLESHOOTING")
    print("=" * 60)
    
    if "invalid account" in error_msg.lower() or error_code == 10014:
        print("\n❌ INVALID ACCOUNT ERROR")
        print("\nYour credentials are incorrect or account expired:")
        print("   • Demo accounts expire after 30-90 days")
        print("   • Double-check: Account ID, Password, Server name")
        print("\n🔧 SOLUTIONS:")
        print("   1. Verify login directly in MT5:")
        print("      File → Login to Trade Account")
        print("   2. If it fails, create new demo account:")
        print("      File → Open an Account → Demo")
        print("   3. Update credentials in your app")
    else:
        print(f"\n🔧 GENERAL SOLUTIONS:")
        print("   1. Make sure MT5 is running")
        print("   2. Try logging in manually in MT5 first")
        print("   3. Check your internet connection")
        print("   4. Verify server name is exactly correct")
        print("   5. Contact broker if issue persists")
    
    print("=" * 60)
    mt5.shutdown()
    sys.exit(1)

print(f"   ✅ SUCCESS: Logged in!")

print(f"\n3. Getting account information...")
account_info = mt5.account_info()

if account_info is None:
    print(f"   ❌ Failed to get account info")
else:
    print(f"   ✅ Account Info Retrieved:")
    print(f"      Login: {account_info.login}")
    print(f"      Server: {account_info.server}")
    print(f"      Name: {account_info.name}")
    print(f"      Company: {account_info.company}")
    print(f"      Currency: {account_info.currency}")
    print(f"      Balance: ${account_info.balance:.2f}")
    print(f"      Equity: ${account_info.equity:.2f}")
    print(f"      Leverage: 1:{account_info.leverage}")
    print(f"      Margin Free: ${account_info.margin_free:.2f}")

print(f"\n4. Cleaning up...")
mt5.shutdown()
print(f"   ✅ Disconnected")

print("\n" + "=" * 60)
print("✅ ALL TESTS PASSED!")
print("=" * 60)
print("\nYour MT5 connection is working correctly.")
print("You can now use the Flutter app to connect.")
print("\nNext steps:")
print("   1. Start the bridge server: python mt5_bridge_server.py")
print("   2. Run your Flutter app")
print("   3. Try logging in from the app")
print("=" * 60)
