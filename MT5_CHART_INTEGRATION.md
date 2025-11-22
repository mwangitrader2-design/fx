# MT5 Chart Data Integration for Signal Generation

This integration allows your AI trading signals to use **real-time and historical chart data from your MetaTrader 5 account** instead of mock/simulated data.

## 🎯 What's New

### Backend (Python - MT5 Bridge Server)

**New Endpoints Added:**

1. **GET `/mt5/chart_data/<symbol>`** - Get historical chart data for a single timeframe
   - Query params: `timeframe` (M1, M5, M15, M30, H1, H4, D1, W1, MN1), `count` (number of candles)
   - Returns: OHLCV data (Open, High, Low, Close, Volume) with timestamps

2. **GET `/mt5/chart_data_multi/<symbol>`** - Get chart data for multiple timeframes at once
   - Query params: `timeframes` (comma-separated list), `count`
   - Returns: Dictionary of timeframe data
   - More efficient for multi-timeframe analysis

### Frontend (Flutter/Dart)

**New Services:**

1. **`MT5ChartService`** - Handles fetching and converting MT5 chart data
   - `getMarketData()` - Fetch single timeframe data
   - `getMultiTimeframeMarketData()` - Fetch multiple timeframes
   - `getCurrentPrice()` - Get latest price
   - Converts MT5 format to app's `MarketData` model

2. **`AISignalGenerator.generateSignalFromMT5()`** - New method to generate signals using live MT5 data
   - Automatically fetches chart data from MT5
   - Analyzes multiple timeframes
   - Returns high-confidence signals (99%+)

3. **`MT5SignalIntegrationExample`** - Example service showing usage patterns

## 🚀 Quick Start

### 1. Start MT5 Bridge Server

```bash
# Make sure MT5 is running and you're logged in
python mt5_bridge_server.py
```

The server will be available at `http://192.168.100.4:5000`

### 2. Use in Your Flutter App

```dart
import 'package:kimutai_fx/services/services.dart';

// Initialize services
final signalGenerator = AISignalGenerator();

// Generate signal using live MT5 data
final signal = await signalGenerator.generateSignalFromMT5(
  symbol: 'EURUSD',
  primaryTimeframe: TimeframeType.H1,
);

if (signal != null) {
  print('Signal: ${signal.type} at ${signal.entryPrice}');
  print('Confidence: ${(signal.confidenceScore * 100).toStringAsFixed(1)}%');
  print('Stop Loss: ${signal.stopLoss}');
  print('Take Profit: ${signal.takeProfit}');
}
```

## 📊 Multi-Timeframe Analysis

The system automatically analyzes multiple timeframes for better accuracy:

```dart
final signal = await signalGenerator.generateSignalFromMT5(
  symbol: 'GBPUSD',
  primaryTimeframe: TimeframeType.H4,
  additionalTimeframes: [
    TimeframeType.M15,  // Lower TF for confirmation
    TimeframeType.H1,
    TimeframeType.H4,   // Primary
    TimeframeType.D1,   // Higher TF for trend
  ],
);
```

## 🔧 Direct Chart Data Access

If you need raw chart data for custom analysis:

```dart
final chartService = MT5ChartService();

// Single timeframe
final h1Data = await chartService.getMarketData(
  symbol: 'EURUSD',
  timeframe: 'H1',
  count: 500,
);

// Multiple timeframes
final multiData = await chartService.getMultiTimeframeMarketData(
  symbol: 'EURUSD',
  timeframes: ['M15', 'H1', 'H4', 'D1'],
  count: 500,
);

// Each candle contains:
// - timestamp (DateTime)
// - open, high, low, close (double)
// - volume (double)
// - spread (double)
```

## 📈 Example: Generate Signals for Multiple Pairs

```dart
final integration = MT5SignalIntegrationExample();

// Check MT5 connection
if (await integration.checkMT5Connection()) {
  // Generate signals for major pairs
  final signals = await integration.generateSignalsForSymbols(
    symbols: ['EURUSD', 'GBPUSD', 'USDJPY', 'AUDUSD'],
    primaryTimeframe: TimeframeType.H1,
  );
  
  print('Generated ${signals.length} high-confidence signals');
  
  for (final signal in signals) {
    print('${signal.symbol}: ${signal.type} (${signal.strength})');
  }
}
```

## ⚠️ Requirements

1. **MetaTrader 5** must be installed and running
2. **Algorithmic Trading** must be enabled:
   - Tools → Options → Expert Advisors
   - Check "Allow algorithmic trading"
3. **MT5 Bridge Server** must be running (`python mt5_bridge_server.py`)
4. Must be **logged in** to your MT5 account
5. Symbol must be available in your MT5 (in Market Watch)

## 🎛️ Supported Timeframes

- M1 (1 minute)
- M5 (5 minutes)
- M15 (15 minutes)
- M30 (30 minutes)
- H1 (1 hour)
- H4 (4 hours)
- D1 (1 day)
- W1 (1 week)
- MN1 (1 month)

## 🔍 Data Structure

Each candle from MT5 includes:

```dart
{
  'time': 1700000000,           // Unix timestamp
  'open': 1.09250,              // Opening price
  'high': 1.09350,              // Highest price
  'low': 1.09200,               // Lowest price
  'close': 1.09300,             // Closing price
  'tick_volume': 1234,          // Number of ticks
  'spread': 12,                 // Spread in points
  'real_volume': 5678           // Real volume (if available)
}
```

## 🚨 Error Handling

All methods include proper error handling:

```dart
try {
  final signal = await signalGenerator.generateSignalFromMT5(
    symbol: 'EURUSD',
  );
  
  if (signal == null) {
    print('No signal: Confidence below 99% threshold');
  }
} catch (e) {
  print('Error: $e');
  // Check:
  // 1. Is MT5 running?
  // 2. Is bridge server running?
  // 3. Are you logged in?
  // 4. Is symbol available?
}
```

## 📝 Notes

- **500 candles** are fetched by default (adjustable)
- Signals require **99%+ confidence** to be generated
- Multi-timeframe analysis improves accuracy
- Chart data is fetched in real-time from MT5
- Old mock data is no longer used

## 🎯 Next Steps

Now that chart data comes from MT5:

1. **Update Signals Page** - Display live signals from MT5 data
2. **Auto-refresh** - Periodically check for new signals
3. **Real-time Updates** - Use WebSocket for live price updates
4. **Backtesting** - Test strategies using historical MT5 data
5. **Auto-trading** - Execute signals directly on MT5 account

## 🔗 Related Files

- `mt5_bridge_server.py` - Python bridge with new endpoints
- `lib/services/mt5_service.dart` - MT5 communication
- `lib/services/mt5_chart_service.dart` - Chart data handling
- `lib/services/ai_signal_generator.dart` - Signal generation with MT5 data
- `lib/services/mt5_signal_integration_example.dart` - Usage examples
