"""
MT5 Bridge Server for Flutter App
This Flask server acts as a bridge between Flutter and MetaTrader 5 Python API
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import MetaTrader5 as mt5
from datetime import datetime

app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter app

# Store connection state
mt5_connected = False
current_credentials = None


@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'ok', 'timestamp': datetime.now().isoformat()}), 200


@app.route('/mt5/test_connection', methods=['POST'])
def test_connection():
    """Test MT5 connection without logging in"""
    try:
        data = request.json
        username = int(data.get('username'))
        password = data.get('password')
        server = data.get('server')

        # Initialize MT5
        if not mt5.initialize():
            error_code, error_msg = mt5.last_error()
            troubleshooting = ""
            if error_code == -6:
                troubleshooting = "\n\n🔧 SOLUTION:\n1. Open MT5 → Tools → Options\n2. Go to 'Expert Advisors' tab\n3. Enable 'Allow algorithmic trading'\n4. Restart MT5 and try again"
            return jsonify({
                'success': False,
                'message': f'MT5 initialization failed (Code: {error_code}): {error_msg}{troubleshooting}'
            }), 200

        # Try to login
        authorized = mt5.login(username, password=password, server=server)
        
        if authorized:
            account_info = mt5.account_info()
            account_dict = {
                'login': account_info.login,
                'server': account_info.server,
                'name': account_info.name,
                'balance': account_info.balance,
                'equity': account_info.equity,
                'margin': account_info.margin,
                'margin_free': account_info.margin_free,
                'currency': account_info.currency,
                'leverage': account_info.leverage,
            }
            
            # Logout after test
            mt5.shutdown()
            
            return jsonify({
                'success': True,
                'message': 'Connection successful',
                'account_info': account_dict
            }), 200
        else:
            error_code, error_message = mt5.last_error()
            mt5.shutdown()
            return jsonify({
                'success': False,
                'message': f'Login failed: {error_message} (Code: {error_code})'
            }), 200

    except Exception as e:
        if mt5.initialize():
            mt5.shutdown()
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/login', methods=['POST'])
def login():
    """Login to MT5 and maintain connection"""
    global mt5_connected, current_credentials
    
    try:
        data = request.json
        username = int(data.get('username'))
        password = data.get('password')
        server = data.get('server')

        # Initialize MT5 if not already
        if not mt5.initialize():
            error_code, error_msg = mt5.last_error()
            troubleshooting = ""
            if error_code == -6:
                troubleshooting = "\n\n🔧 SOLUTION:\n1. Open MT5 → Tools → Options\n2. Go to 'Expert Advisors' tab\n3. Enable 'Allow algorithmic trading'\n4. Restart MT5 and try again"
            return jsonify({
                'success': False,
                'message': f'MT5 initialization failed (Code: {error_code}): {error_msg}{troubleshooting}'
            }), 200

        # Login
        authorized = mt5.login(username, password=password, server=server)
        
        if authorized:
            mt5_connected = True
            current_credentials = {'username': username, 'password': password, 'server': server}
            
            account_info = mt5.account_info()
            account_dict = {
                'login': account_info.login,
                'server': account_info.server,
                'name': account_info.name,
                'company': account_info.company,
                'currency': account_info.currency,
                'leverage': account_info.leverage,
            }
            
            return jsonify({
                'success': True,
                'message': 'Login successful',
                'account_info': account_dict,
                'balance': float(account_info.balance),
                'equity': float(account_info.equity),
                'margin': float(account_info.margin),
                'margin_free': float(account_info.margin_free),
            }), 200
        else:
            error_code, error_message = mt5.last_error()
            mt5.shutdown()
            return jsonify({
                'success': False,
                'message': f'Login failed: {error_message} (Code: {error_code})'
            }), 200

    except Exception as e:
        if mt5.initialize():
            mt5.shutdown()
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/logout', methods=['POST'])
def logout():
    """Logout from MT5"""
    global mt5_connected, current_credentials
    
    try:
        if mt5_connected:
            mt5.shutdown()
            mt5_connected = False
            current_credentials = None
            
        return jsonify({
            'success': True,
            'message': 'Logged out successfully'
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/account_info', methods=['GET'])
def get_account_info():
    """Get current account information"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
            
        account_info = mt5.account_info()
        if account_info is None:
            return jsonify({
                'success': False,
                'message': 'Failed to get account info'
            }), 200
            
        account_dict = {
            'login': account_info.login,
            'server': account_info.server,
            'name': account_info.name,
            'company': account_info.company,
            'balance': float(account_info.balance),
            'equity': float(account_info.equity),
            'margin': float(account_info.margin),
            'margin_free': float(account_info.margin_free),
            'margin_level': float(account_info.margin_level) if account_info.margin_level else 0,
            'currency': account_info.currency,
            'leverage': account_info.leverage,
            'profit': float(account_info.profit),
        }
        
        return jsonify({
            'success': True,
            'data': account_dict
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/status', methods=['GET'])
def connection_status():
    """Get connection status"""
    return jsonify({
        'connected': mt5_connected,
        'credentials': current_credentials is not None
    }), 200


@app.route('/mt5/chart_data/<symbol>', methods=['GET'])
def get_chart_data(symbol):
    """Get historical chart data (OHLCV) for a symbol"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
        
        # Get query parameters
        timeframe_str = request.args.get('timeframe', 'H1')  # Default H1
        count = int(request.args.get('count', 500))  # Default 500 candles
        
        # Map timeframe string to MT5 constant
        timeframe_map = {
            'M1': mt5.TIMEFRAME_M1,
            'M5': mt5.TIMEFRAME_M5,
            'M15': mt5.TIMEFRAME_M15,
            'M30': mt5.TIMEFRAME_M30,
            'H1': mt5.TIMEFRAME_H1,
            'H4': mt5.TIMEFRAME_H4,
            'D1': mt5.TIMEFRAME_D1,
            'W1': mt5.TIMEFRAME_W1,
            'MN1': mt5.TIMEFRAME_MN1,
        }
        
        timeframe = timeframe_map.get(timeframe_str, mt5.TIMEFRAME_H1)
        
        # Get rates from current time
        rates = mt5.copy_rates_from_pos(symbol, timeframe, 0, count)
        
        if rates is None or len(rates) == 0:
            return jsonify({
                'success': False,
                'message': f'No data available for {symbol}'
            }), 200
        
        # Convert to list of dictionaries
        candles = []
        for rate in rates:
            candles.append({
                'time': int(rate['time']),
                'open': float(rate['open']),
                'high': float(rate['high']),
                'low': float(rate['low']),
                'close': float(rate['close']),
                'tick_volume': int(rate['tick_volume']),
                'spread': int(rate['spread']),
                'real_volume': int(rate['real_volume'])
            })
        
        return jsonify({
            'success': True,
            'data': {
                'symbol': symbol,
                'timeframe': timeframe_str,
                'count': len(candles),
                'candles': candles
            }
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/chart_data_multi/<symbol>', methods=['GET'])
def get_multi_timeframe_data(symbol):
    """Get chart data for multiple timeframes at once"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
        
        # Get query parameters
        timeframes_param = request.args.get('timeframes', 'M15,H1,H4,D1')
        timeframes = [tf.strip() for tf in timeframes_param.split(',')]
        count = int(request.args.get('count', 500))
        
        # Map timeframe string to MT5 constant
        timeframe_map = {
            'M1': mt5.TIMEFRAME_M1,
            'M5': mt5.TIMEFRAME_M5,
            'M15': mt5.TIMEFRAME_M15,
            'M30': mt5.TIMEFRAME_M30,
            'H1': mt5.TIMEFRAME_H1,
            'H4': mt5.TIMEFRAME_H4,
            'D1': mt5.TIMEFRAME_D1,
            'W1': mt5.TIMEFRAME_W1,
            'MN1': mt5.TIMEFRAME_MN1,
        }
        
        result_data = {}
        
        for tf_str in timeframes:
            timeframe = timeframe_map.get(tf_str)
            if timeframe is None:
                continue
                
            rates = mt5.copy_rates_from_pos(symbol, timeframe, 0, count)
            
            if rates is not None and len(rates) > 0:
                candles = []
                for rate in rates:
                    candles.append({
                        'time': int(rate['time']),
                        'open': float(rate['open']),
                        'high': float(rate['high']),
                        'low': float(rate['low']),
                        'close': float(rate['close']),
                        'tick_volume': int(rate['tick_volume']),
                        'spread': int(rate['spread']),
                        'real_volume': int(rate['real_volume'])
                    })
                
                result_data[tf_str] = candles
        
        if not result_data:
            return jsonify({
                'success': False,
                'message': f'No data available for {symbol}'
            }), 200
        
        return jsonify({
            'success': True,
            'data': {
                'symbol': symbol,
                'timeframes': result_data
            }
        }), 200
        
    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


if __name__ == '__main__':
    print("Starting MT5 Bridge Server...")
    print("Make sure MetaTrader 5 is installed and running")
    app.run(host='0.0.0.0', port=5000, debug=True)
