# AI-Powered Automated Trading System

## Overview

This system implements a comprehensive AI and Machine Learning powered automated trading solution that:

1. **Analyzes Markets** using advanced technical indicators and ML models
2. **Generates High-Accuracy Signals** targeting 99% confidence
3. **Executes Trades Automatically** only after multi-timeframe confirmation
4. **Implements Advanced Risk Management** with dynamic stop losses
5. **Manages Portfolio Growth** using AI optimization
6. **Recognizes Trading Patterns** using pattern recognition algorithms
7. **Logs Everything to Firebase** for analysis and tracking

## Features

### 1. AI Market Analysis
- **Multi-timeframe analysis** (M15, H1, H4, D1)
- **Technical indicators**: RSI, MACD, Bollinger Bands, EMAs, ATR, ADX, Stochastic
- **ML prediction models** for price movement
- **Pattern recognition** (Head & Shoulders, Double Top/Bottom, Triangles, Flags, Candlestick patterns)
- **Market sentiment analysis**
- **Support/Resistance identification**
- **Volatility analysis**

### 2. Signal Generation (99% Accuracy Target)
- High confidence threshold (99%+) required for signal generation
- Multi-factor confirmation:
  - Technical indicator alignment
  - ML model prediction
  - Pattern recognition
  - Multi-timeframe consensus
- Only generates BUY/SELL signals when conditions are optimal
- Skips trading when confidence is insufficient

### 3. Multi-Timeframe Confirmation
- Primary timeframe generates the signal
- Lower timeframe must confirm before execution
- Checks:
  - Trend alignment
  - RSI levels
  - Momentum direction
  - Entry conditions
- Minimum 98% confirmation confidence required

### 4. Automated Trade Execution
- Executes only confirmed signals
- Risk management validation before each trade
- Optimal position sizing calculation
- Proper entry, stop loss, and take profit placement
- Real-time trade monitoring
- Automatic trailing stops
- Partial profit taking

### 5. Advanced Risk Management
- Maximum 1% risk per trade
- Maximum 3% daily risk
- Maximum 10% total exposure
- Position size calculation based on account balance and stop loss
- Dynamic stop loss calculation using ATR and support/resistance
- Trailing stop loss activation after profit threshold
- Correlation risk analysis
- Early exit triggers for risk protection

### 6. AI Portfolio Management
- Continuous portfolio health monitoring (0-100 score)
- Performance metrics tracking:
  - Win rate
  - Profit factor
  - Sharpe ratio
  - Maximum drawdown
  - Risk-reward ratios
  - Consistency score
- Portfolio diversification analysis
- Position sizing optimization using Kelly Criterion
- Rebalancing recommendations
- Growth targets adjustment based on performance

### 7. Firebase Integration
- Real-time data synchronization
- Comprehensive logging:
  - All market analyses
  - Signal generations
  - Trade executions
  - Risk events
  - Performance metrics
- Historical data storage
- Error tracking
- Analytics and insights

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                  AITradingController                         │
│              (Master Orchestrator)                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│   Firebase   │ │   Market     │ │   MT5        │
│   Service    │ │   Data       │ │   Service    │
└──────────────┘ └──────────────┘ └──────────────┘
        │              │              │
        │              ▼              │
        │      ┌──────────────┐      │
        │      │  AI Market   │      │
        │      │  Analyzer    │      │
        │      └──────────────┘      │
        │              │              │
        │              ▼              │
        │      ┌──────────────┐      │
        │      │  AI Signal   │      │
        │      │  Generator   │      │
        │      └──────────────┘      │
        │              │              │
        │              ▼              │
        │      ┌──────────────┐      │
        │      │  Automated   │◄─────┘
        │      │  Trade       │
        │      │  Executor    │
        │      └──────────────┘
        │              │
        ▼              ▼
┌──────────────┐ ┌──────────────┐
│  Enhanced    │ │  AI Portfolio│
│  Risk        │ │  Manager     │
│  Manager     │ │              │
└──────────────┘ └──────────────┘
```

## Services

### Core Services

1. **FirebaseService** - Data persistence and logging
2. **AIMarketAnalyzer** - Comprehensive market analysis
3. **AISignalGenerator** - High-accuracy signal generation
4. **AutomatedTradeExecutor** - Trade execution and monitoring
5. **EnhancedRiskManager** - Advanced risk management
6. **AIPortfolioManager** - Portfolio optimization
7. **AITradingController** - Master orchestrator

### Supporting Services

- **TechnicalIndicatorService** - Technical analysis calculations
- **MLPredictionService** - Machine learning predictions
- **MarketDataService** - Market data fetching
- **MT5Service** - MetaTrader 5 integration

## Setup

### Prerequisites

1. **Flutter Dependencies**
   ```bash
   flutter pub get
   ```

2. **Python Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Download `firebase-service-account.json`
   - Set up Firestore and Realtime Database
   - Configure authentication

4. **MetaTrader 5**
   - Install MT5 platform
   - Enable Algo Trading
   - Note account credentials

### Configuration

1. **Firebase Configuration**
   ```dart
   await FirebaseService().initialize();
   ```

2. **Start Python Backend**
   ```bash
   python ai_trading_backend.py
   ```

3. **Initialize AI Trading Controller**
   ```dart
   final controller = AITradingController();
   await controller.initialize();
   ```

## Usage

### Starting Automated Trading

```dart
final controller = AITradingController();
await controller.initialize();
await controller.startAutomatedTrading();
```

### Manual Analysis

```dart
final analysis = await controller.analyzeSymbol(
  'EURUSD',
  TimeframeType.H1,
);

print('Confidence: ${analysis.confidence}');
print('Recommendation: ${analysis.recommendation}');
print('Patterns: ${analysis.patterns}');
```

### Generate Signal Manually

```dart
final signal = await controller.generateSignal(
  'GBPUSD',
  TimeframeType.H1,
);

if (signal != null && signal.confidenceScore >= 0.99) {
  print('High confidence signal generated!');
  print('Type: ${signal.type}');
  print('Entry: ${signal.entryPrice}');
  print('Stop Loss: ${signal.stopLoss}');
  print('Take Profit: ${signal.takeProfit}');
}
```

### Get Portfolio Report

```dart
final report = await controller.getPortfolioReport();

print('Health Score: ${report.healthScore}/100');
print('Win Rate: ${report.performance['winRate'] * 100}%');
print('Profit Factor: ${report.performance['profitFactor']}');
print('Opportunities: ${report.opportunities}');
```

### Stop Trading

```dart
await controller.stopAutomatedTrading();
```

## Configuration Options

### Trading Parameters

```dart
// In AISignalGenerator
static const double MIN_CONFIDENCE_THRESHOLD = 0.99; // 99% minimum

// In EnhancedRiskManager
static const double DEFAULT_RISK_PER_TRADE = 1.0; // 1%
static const double MAX_DAILY_RISK = 3.0; // 3%
static const double MAX_TOTAL_RISK = 10.0; // 10%
static const int MAX_OPEN_TRADES = 5;
static const double MIN_RISK_REWARD = 2.0; // 2:1

// In AIPortfolioManager
static const double TARGET_MONTHLY_GROWTH = 5.0; // 5%
static const double MAX_MONTHLY_DRAWDOWN = 10.0; // 10%
static const double IDEAL_WIN_RATE = 0.65; // 65%
```

### Monitored Symbols

```dart
final controller = AITradingController();

// Add custom symbols
controller.addSymbol('AUDJPY');
controller.addSymbol('XAUUSD'); // Gold

// Remove symbols
controller.removeSymbol('EURUSD');

// Get current symbols
print(controller.monitoredSymbols);
```

## Monitoring & Logs

### Firebase Collections

- **logs** - System events and analytics
- **errors** - Error tracking with stack traces
- **trades** - All executed trades
- **signals** - Generated signals
- **market_data** - Historical market data
- **predictions** - ML model predictions
- **technical_analysis** - Analysis results
- **patterns** - Detected patterns
- **portfolio_history** - Portfolio snapshots
- **performance_metrics** - Performance tracking
- **risk_events** - Risk management events

### Real-time Monitoring

```dart
// Watch signals
_firebaseService.watchSignals(symbol: 'EURUSD').listen((signals) {
  print('New signals: ${signals.length}');
});

// Watch trades
_firebaseService.watchTrades().listen((trades) {
  print('Active trades: ${trades.length}');
});
```

## Performance Targets

- **Win Rate**: 65%+ target
- **Profit Factor**: 1.5+ minimum
- **Risk-Reward**: 2:1 minimum per trade
- **Monthly Growth**: 5% target
- **Max Drawdown**: 10% limit
- **Signal Confidence**: 99%+ required
- **Confirmation Confidence**: 98%+ required

## Best Practices

1. **Start with Demo Account** - Test thoroughly before live trading
2. **Monitor Regularly** - Check Firebase logs and performance metrics
3. **Adjust Parameters** - Fine-tune based on performance
4. **Diversify** - Trade multiple uncorrelated pairs
5. **Risk Management** - Never exceed risk limits
6. **Keep Updated** - Retrain ML models with new data
7. **Backup Data** - Regularly backup Firebase data

## Troubleshooting

### Low Signal Generation
- Market conditions may not meet 99% confidence threshold
- This is normal - quality over quantity
- Consider slightly lower threshold for testing (95%+)

### Trades Not Executing
- Check risk management limits
- Verify MT5 connection
- Check margin availability
- Review Firebase logs for rejection reasons

### Poor Performance
- Review portfolio optimization report
- Check win rate and profit factor
- Analyze rejected signals
- Consider retraining ML models

## Future Enhancements

1. **Deep Learning Models** - LSTM/Transformer models for price prediction
2. **Sentiment Analysis** - News and social media sentiment
3. **Advanced Pattern Recognition** - Computer vision for chart patterns
4. **Multi-Asset Support** - Stocks, crypto, commodities
5. **Backtesting Framework** - Historical strategy testing
6. **Strategy Optimizer** - Genetic algorithm optimization
7. **Risk Parity** - Advanced portfolio allocation

## License

Private Use Only

## Support

For issues and questions, check Firebase error logs and system events.
