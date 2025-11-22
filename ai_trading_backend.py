"""
Enhanced AI/ML Trading Backend
Integrates with MetaTrader 5 and Firebase for intelligent trading
"""

import os
from flask import Flask, request, jsonify
from flask_cors import CORS
import MetaTrader5 as mt5
import firebase_admin
from firebase_admin import credentials, db, firestore
from datetime import datetime, timedelta
import numpy as np
import pandas as pd
from typing import Dict, List, Optional, Tuple
import json

# ML/AI imports
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier, GradientBoostingRegressor
import warnings
warnings.filterwarnings('ignore')

app = Flask(__name__)
CORS(app)

# Initialize Firebase
try:
    # Use environment variable or service account key
    if os.path.exists('firebase-service-account.json'):
        cred = credentials.Certificate('firebase-service-account.json')
        firebase_admin.initialize_app(cred, {
            'databaseURL': os.getenv('FIREBASE_DATABASE_URL', 'https://your-project.firebaseio.com')
        })
        print("Firebase initialized successfully")
    else:
        print("Firebase service account not found. Logging will be limited.")
        firebase_initialized = False
except Exception as e:
    print(f"Firebase initialization error: {e}")
    firebase_initialized = False

# ML Models (will be trained over time)
class MLModels:
    def __init__(self):
        self.price_predictor = GradientBoostingRegressor(n_estimators=100, random_state=42)
        self.signal_classifier = RandomForestClassifier(n_estimators=100, random_state=42)
        self.scaler = StandardScaler()
        self.trained = False
    
    def extract_features(self, data: pd.DataFrame) -> np.ndarray:
        """Extract features from market data"""
        features = []
        
        # Price-based features
        features.append(data['close'].pct_change().fillna(0))
        features.append(data['high'] - data['low'])  # Range
        features.append(data['close'] - data['open'])  # Body
        
        # Moving averages
        for period in [5, 10, 20, 50]:
            if len(data) >= period:
                ma = data['close'].rolling(window=period).mean()
                features.append(data['close'] / ma - 1)  # Distance from MA
        
        # RSI
        delta = data['close'].diff()
        gain = (delta.where(delta > 0, 0)).rolling(window=14).mean()
        loss = (-delta.where(delta < 0, 0)).rolling(window=14).mean()
        rs = gain / loss
        rsi = 100 - (100 / (1 + rs))
        features.append(rsi / 100)  # Normalize
        
        # Volatility
        features.append(data['close'].rolling(window=20).std())
        
        # Volume
        if 'tick_volume' in data.columns:
            features.append(data['tick_volume'].pct_change().fillna(0))
        
        return pd.concat(features, axis=1).fillna(0).values
    
    def train(self, historical_data: List[Dict], signals: List[Dict]):
        """Train ML models on historical data"""
        if len(historical_data) < 100:
            return False
        
        try:
            df = pd.DataFrame(historical_data)
            features = self.extract_features(df)
            
            # Train price predictor
            X = features[:-1]
            y = df['close'].pct_change().shift(-1).fillna(0).values[:-1]
            
            X_scaled = self.scaler.fit_transform(X)
            self.price_predictor.fit(X_scaled, y)
            
            # Train signal classifier if we have signal data
            if len(signals) > 0:
                signal_df = pd.DataFrame(signals)
                # This would need proper labeling based on signal outcomes
                self.trained = True
            
            return True
        except Exception as e:
            print(f"Model training error: {e}")
            return False
    
    def predict_price_movement(self, data: pd.DataFrame) -> Dict:
        """Predict future price movement"""
        try:
            features = self.extract_features(data)
            X = features[-1:] if len(features.shape) > 1 else features.reshape(1, -1)
            X_scaled = self.scaler.transform(X)
            
            prediction = self.price_predictor.predict(X_scaled)[0]
            
            # Calculate confidence based on feature importance
            confidence = min(abs(prediction) * 10, 1.0)
            
            return {
                'direction': 'up' if prediction > 0 else 'down',
                'confidence': float(confidence),
                'predicted_change': float(prediction * 100),
                'timestamp': datetime.now().isoformat()
            }
        except Exception as e:
            print(f"Prediction error: {e}")
            return {
                'direction': 'neutral',
                'confidence': 0.0,
                'predicted_change': 0.0,
                'error': str(e)
            }

ml_models = MLModels()

# MT5 Connection state
mt5_connected = False

def log_to_firebase(collection: str, data: Dict):
    """Log data to Firebase Firestore"""
    try:
        if firebase_initialized:
            db_ref = firestore.client()
            db_ref.collection(collection).add({
                **data,
                'timestamp': firestore.SERVER_TIMESTAMP
            })
    except Exception as e:
        print(f"Firebase logging error: {e}")

def get_market_data(symbol: str, timeframe: int, bars: int = 100) -> Optional[pd.DataFrame]:
    """Fetch market data from MT5"""
    try:
        rates = mt5.copy_rates_from_pos(symbol, timeframe, 0, bars)
        if rates is None:
            return None
        
        df = pd.DataFrame(rates)
        df['time'] = pd.to_datetime(df['time'], unit='s')
        return df
    except Exception as e:
        print(f"Error fetching market data: {e}")
        return None

def calculate_technical_indicators(df: pd.DataFrame) -> Dict:
    """Calculate technical indicators"""
    indicators = {}
    
    try:
        # RSI
        delta = df['close'].diff()
        gain = (delta.where(delta > 0, 0)).rolling(window=14).mean()
        loss = (-delta.where(delta < 0, 0)).rolling(window=14).mean()
        rs = gain / loss
        rsi = 100 - (100 / (1 + rs))
        indicators['rsi'] = float(rsi.iloc[-1])
        
        # MACD
        ema12 = df['close'].ewm(span=12, adjust=False).mean()
        ema26 = df['close'].ewm(span=26, adjust=False).mean()
        macd = ema12 - ema26
        signal = macd.ewm(span=9, adjust=False).mean()
        indicators['macd'] = float(macd.iloc[-1])
        indicators['macd_signal'] = float(signal.iloc[-1])
        indicators['macd_histogram'] = float((macd - signal).iloc[-1])
        
        # Bollinger Bands
        sma20 = df['close'].rolling(window=20).mean()
        std20 = df['close'].rolling(window=20).std()
        indicators['bb_upper'] = float(sma20.iloc[-1] + 2 * std20.iloc[-1])
        indicators['bb_middle'] = float(sma20.iloc[-1])
        indicators['bb_lower'] = float(sma20.iloc[-1] - 2 * std20.iloc[-1])
        
        # EMAs
        indicators['ema20'] = float(df['close'].ewm(span=20, adjust=False).mean().iloc[-1])
        indicators['ema50'] = float(df['close'].ewm(span=50, adjust=False).mean().iloc[-1])
        indicators['ema200'] = float(df['close'].ewm(span=200, adjust=False).mean().iloc[-1] if len(df) >= 200 else 0)
        
        # ATR
        high_low = df['high'] - df['low']
        high_close = np.abs(df['high'] - df['close'].shift())
        low_close = np.abs(df['low'] - df['close'].shift())
        ranges = pd.concat([high_low, high_close, low_close], axis=1)
        true_range = ranges.max(axis=1)
        atr = true_range.rolling(14).mean()
        indicators['atr'] = float(atr.iloc[-1])
        
        # ADX
        # Simplified ADX calculation
        plus_dm = df['high'].diff()
        minus_dm = df['low'].diff()
        plus_dm[plus_dm < 0] = 0
        minus_dm[minus_dm > 0] = 0
        
        tr14 = true_range.rolling(14).sum()
        plus_di = 100 * (plus_dm.rolling(14).sum() / tr14)
        minus_di = 100 * (minus_dm.abs().rolling(14).sum() / tr14)
        
        dx = 100 * (np.abs(plus_di - minus_di) / (plus_di + minus_di))
        adx = dx.rolling(14).mean()
        indicators['adx'] = float(adx.iloc[-1] if not np.isnan(adx.iloc[-1]) else 0)
        
    except Exception as e:
        print(f"Error calculating indicators: {e}")
    
    return indicators

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'ok',
        'mt5_connected': mt5_connected,
        'ml_trained': ml_models.trained,
        'firebase': firebase_initialized,
        'timestamp': datetime.now().isoformat()
    }), 200

@app.route('/mt5/login', methods=['POST'])
def mt5_login():
    """Login to MT5"""
    global mt5_connected
    
    try:
        data = request.json
        username = int(data.get('username'))
        password = data.get('password')
        server = data.get('server')
        
        if not mt5.initialize():
            return jsonify({'success': False, 'message': 'MT5 initialization failed'}), 200
        
        authorized = mt5.login(username, password=password, server=server)
        
        if authorized:
            mt5_connected = True
            account_info = mt5.account_info()
            
            log_to_firebase('auth_logs', {
                'event': 'mt5_login_success',
                'username': username,
                'server': server
            })
            
            return jsonify({
                'success': True,
                'account_info': {
                    'login': account_info.login,
                    'balance': account_info.balance,
                    'equity': account_info.equity,
                    'margin': account_info.margin,
                    'margin_free': account_info.margin_free,
                    'currency': account_info.currency,
                }
            }), 200
        else:
            return jsonify({'success': False, 'message': 'Login failed'}), 200
            
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@app.route('/ai/analyze_market', methods=['POST'])
def ai_analyze_market():
    """Comprehensive AI market analysis"""
    try:
        data = request.json
        symbol = data.get('symbol')
        timeframe = data.get('timeframe', mt5.TIMEFRAME_H1)
        
        # Get market data
        df = get_market_data(symbol, timeframe, bars=200)
        if df is None:
            return jsonify({'success': False, 'message': 'Failed to fetch market data'}), 200
        
        # Calculate technical indicators
        indicators = calculate_technical_indicators(df)
        
        # ML prediction
        ml_prediction = ml_models.predict_price_movement(df)
        
        # Determine overall sentiment
        sentiment_score = 0
        
        # RSI analysis
        if indicators.get('rsi', 50) < 30:
            sentiment_score += 1
        elif indicators.get('rsi', 50) > 70:
            sentiment_score -= 1
        
        # MACD analysis
        if indicators.get('macd', 0) > indicators.get('macd_signal', 0):
            sentiment_score += 1
        else:
            sentiment_score -= 1
        
        # EMA analysis
        current_price = float(df['close'].iloc[-1])
        if current_price > indicators.get('ema20', 0) > indicators.get('ema50', 0):
            sentiment_score += 1
        elif current_price < indicators.get('ema20', 0) < indicators.get('ema50', 0):
            sentiment_score -= 1
        
        # ML prediction
        if ml_prediction['direction'] == 'up':
            sentiment_score += ml_prediction['confidence'] * 2
        elif ml_prediction['direction'] == 'down':
            sentiment_score -= ml_prediction['confidence'] * 2
        
        # Normalize sentiment
        sentiment = sentiment_score / 5  # Range: -1 to 1
        
        result = {
            'success': True,
            'symbol': symbol,
            'current_price': current_price,
            'indicators': indicators,
            'ml_prediction': ml_prediction,
            'sentiment': float(sentiment),
            'market_condition': 'trending' if indicators.get('adx', 0) > 25 else 'ranging',
            'timestamp': datetime.now().isoformat()
        }
        
        # Log analysis
        log_to_firebase('market_analysis', result)
        
        return jsonify(result), 200
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@app.route('/ai/generate_signal', methods=['POST'])
def ai_generate_signal():
    """Generate AI-powered trading signal"""
    try:
        data = request.json
        symbol = data.get('symbol')
        timeframe = data.get('timeframe', mt5.TIMEFRAME_H1)
        
        # Get market data for multiple timeframes
        primary_df = get_market_data(symbol, timeframe, bars=200)
        higher_tf = timeframe * 4
        higher_df = get_market_data(symbol, higher_tf, bars=100)
        
        if primary_df is None:
            return jsonify({'success': False, 'message': 'Failed to fetch market data'}), 200
        
        # Analyze both timeframes
        primary_indicators = calculate_technical_indicators(primary_df)
        primary_prediction = ml_models.predict_price_movement(primary_df)
        
        higher_indicators = calculate_technical_indicators(higher_df) if higher_df is not None else {}
        
        # Calculate confidence score
        confidence = 0.0
        signal_type = 'HOLD'
        
        # Technical alignment check
        technical_signals = []
        
        # RSI
        rsi = primary_indicators.get('rsi', 50)
        if rsi < 30:
            technical_signals.append('buy')
            confidence += 0.15
        elif rsi > 70:
            technical_signals.append('sell')
            confidence += 0.15
        
        # MACD
        if primary_indicators.get('macd', 0) > primary_indicators.get('macd_signal', 0):
            technical_signals.append('buy')
            confidence += 0.15
        else:
            technical_signals.append('sell')
            confidence += 0.15
        
        # EMA trend
        current_price = float(primary_df['close'].iloc[-1])
        ema20 = primary_indicators.get('ema20', 0)
        ema50 = primary_indicators.get('ema50', 0)
        
        if current_price > ema20 > ema50:
            technical_signals.append('buy')
            confidence += 0.20
        elif current_price < ema20 < ema50:
            technical_signals.append('sell')
            confidence += 0.20
        
        # ML prediction
        if primary_prediction['confidence'] > 0.7:
            technical_signals.append(primary_prediction['direction'])
            confidence += primary_prediction['confidence'] * 0.30
        
        # Higher timeframe confirmation
        if higher_df is not None:
            higher_price = float(higher_df['close'].iloc[-1])
            higher_ema20 = higher_indicators.get('ema20', 0)
            if higher_price > higher_ema20 and 'buy' in technical_signals:
                confidence += 0.20
            elif higher_price < higher_ema20 and 'sell' in technical_signals:
                confidence += 0.20
        
        # Determine signal type
        buy_count = technical_signals.count('buy')
        sell_count = technical_signals.count('sell')
        
        if buy_count > sell_count:
            signal_type = 'BUY'
        elif sell_count > buy_count:
            signal_type = 'SELL'
        
        # Only generate signal if confidence is high
        if confidence < 0.99:
            signal_type = 'HOLD'
        
        # Calculate entry, stop loss, and take profit
        atr = primary_indicators.get('atr', 0)
        entry_price = current_price
        
        if signal_type == 'BUY':
            stop_loss = entry_price - (atr * 2)
            take_profit = entry_price + (atr * 4)
        elif signal_type == 'SELL':
            stop_loss = entry_price + (atr * 2)
            take_profit = entry_price - (atr * 4)
        else:
            stop_loss = 0
            take_profit = 0
        
        result = {
            'success': True,
            'signal_type': signal_type,
            'symbol': symbol,
            'confidence': float(confidence),
            'entry_price': float(entry_price),
            'stop_loss': float(stop_loss),
            'take_profit': float(take_profit),
            'indicators': primary_indicators,
            'ml_prediction': primary_prediction,
            'reasons': technical_signals,
            'timestamp': datetime.now().isoformat()
        }
        
        # Log signal
        log_to_firebase('signals', result)
        
        return jsonify(result), 200
        
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

@app.route('/ai/train_models', methods=['POST'])
def train_models():
    """Train ML models on historical data"""
    try:
        data = request.json
        symbol = data.get('symbol', 'EURUSD')
        
        # Fetch large amount of historical data
        df = get_market_data(symbol, mt5.TIMEFRAME_H1, bars=1000)
        
        if df is None:
            return jsonify({'success': False, 'message': 'Failed to fetch training data'}), 200
        
        # Convert to list of dicts for training
        historical_data = df.to_dict('records')
        
        # Train models
        success = ml_models.train(historical_data, [])
        
        if success:
            log_to_firebase('model_training', {
                'event': 'models_trained',
                'symbol': symbol,
                'data_points': len(historical_data)
            })
            
            return jsonify({
                'success': True,
                'message': 'Models trained successfully',
                'data_points': len(historical_data)
            }), 200
        else:
            return jsonify({'success': False, 'message': 'Training failed'}), 200
            
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)}), 500

if __name__ == '__main__':
    print("Starting Enhanced AI Trading Backend...")
    print(f"MT5 Version: {mt5.__version__ if hasattr(mt5, '__version__') else 'Unknown'}")
    print(f"Firebase: {'Initialized' if firebase_initialized else 'Not initialized'}")
    app.run(host='0.0.0.0', port=5000, debug=True)
