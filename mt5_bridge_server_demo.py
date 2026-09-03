"""
MT5 Bridge Server for Flutter App - DEMO MODE
This version works without MetaTrader5 installed (Linux/Codespaces compatible)
Use this for development. For production, use mt5_bridge_server.py on Windows/macOS
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime, timedelta
import random
import os

app = Flask(__name__)
CORS(app)

# Store connection state
mt5_connected = False
current_credentials = None


@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({'status': 'ok', 'timestamp': datetime.now().isoformat(), 'mode': 'DEMO'}), 200


@app.route('/mt5/test_connection', methods=['POST'])
def test_connection():
    """Test MT5 connection (DEMO MODE)"""
    try:
        data = request.json
        username = int(data.get('username'))
        server = data.get('server')

        return jsonify({
            'success': True,
            'message': 'Demo Connection successful',
            'account_info': {
                'login': username,
                'server': server,
                'name': 'Demo Account',
                'balance': 10000.0,
                'equity': 10000.0,
                'margin': 0.0,
                'margin_free': 10000.0,
                'currency': 'USD',
                'leverage': 100,
            }
        }), 200

    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/login', methods=['POST'])
def login():
    """Login to MT5 (DEMO MODE)"""
    global mt5_connected, current_credentials
    
    try:
        data = request.json
        username = int(data.get('username'))
        password = data.get('password')
        server = data.get('server')

        mt5_connected = True
        current_credentials = {'username': username, 'password': password, 'server': server}
        
        return jsonify({
            'success': True,
            'message': 'Login successful (DEMO MODE)',
            'account_info': {
                'login': username,
                'server': server,
                'name': 'Demo Trading Account',
                'company': 'MetaQuotes Demo',
                'currency': 'USD',
                'leverage': 100,
            },
            'balance': 10000.0,
            'equity': 9950.0,
            'margin': 500.0,
            'margin_free': 9450.0,
        }), 200

    except Exception as e:
        return jsonify({
            'success': False,
            'message': f'Error: {str(e)}'
        }), 200


@app.route('/mt5/logout', methods=['POST'])
def logout():
    """Logout from MT5"""
    global mt5_connected, current_credentials
    
    try:
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
    """Get current account information (DEMO)"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
            
        return jsonify({
            'success': True,
            'data': {
                'login': 123456,
                'server': 'MetaQuotes-Demo',
                'name': 'Demo Account',
                'company': 'MetaQuotes',
                'balance': 10000.0,
                'equity': 9950.0,
                'margin': 500.0,
                'margin_free': 9450.0,
                'margin_level': 1990.0,
                'currency': 'USD',
                'leverage': 100,
                'profit': -50.0,
            }
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
        'credentials': current_credentials is not None,
        'mode': 'DEMO'
    }), 200


@app.route('/mt5/chart_data/<symbol>', methods=['GET'])
def get_chart_data(symbol):
    """Get historical chart data (DEMO OHLCV)"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
        
        timeframe_str = request.args.get('timeframe', 'H1')
        count = int(request.args.get('count', 500))
        
        # Generate demo candles
        candles = []
        base_price = 1.0850
        current_time = datetime.now()
        
        for i in range(count):
            price = base_price + (i * 0.0001) + random.uniform(-0.0003, 0.0003)
            candle_time = current_time - timedelta(hours=count - i)
            
            candles.append({
                'time': int(candle_time.timestamp()),
                'open': price,
                'high': price + random.uniform(0.0001, 0.0005),
                'low': price - random.uniform(0.0001, 0.0003),
                'close': price + random.uniform(-0.0002, 0.0003),
                'tick_volume': random.randint(500, 2000),
                'spread': 2,
                'real_volume': random.randint(1000, 5000)
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
    """Get chart data for multiple timeframes (DEMO)"""
    global mt5_connected
    
    try:
        if not mt5_connected:
            return jsonify({
                'success': False,
                'message': 'Not connected to MT5'
            }), 200
        
        timeframes_param = request.args.get('timeframes', 'M15,H1,H4,D1')
        timeframes = [tf.strip() for tf in timeframes_param.split(',')]
        count = int(request.args.get('count', 500))
        
        result_data = {}
        base_price = 1.0850
        current_time = datetime.now()
        
        for tf_str in timeframes:
            candles = []
            
            for i in range(count):
                price = base_price + (i * 0.0001) + random.uniform(-0.0003, 0.0003)
                candle_time = current_time - timedelta(hours=count - i)
                
                candles.append({
                    'time': int(candle_time.timestamp()),
                    'open': price,
                    'high': price + random.uniform(0.0001, 0.0005),
                    'low': price - random.uniform(0.0001, 0.0003),
                    'close': price + random.uniform(-0.0002, 0.0003),
                    'tick_volume': random.randint(500, 2000),
                    'spread': 2,
                    'real_volume': random.randint(1000, 5000)
                })
            
            result_data[tf_str] = candles
        
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
    port = int(os.getenv('PORT', 5000))
    print("🚀 Starting MT5 Bridge Server (DEMO MODE)...")
    print(f"📡 Server running on http://0.0.0.0:{port}")
    print("⚠️  For production trading on Windows/macOS, use mt5_bridge_server.py with MetaTrader5")
    app.run(host='0.0.0.0', port=port, debug=True)
