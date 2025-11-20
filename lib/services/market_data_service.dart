import 'dart:async';
import 'dart:math';
import '../models/models.dart';

/// Service for fetching and managing market data
/// In production, this would connect to real forex APIs like OANDA, MetaTrader, etc.
class MarketDataService {
  final _dataStreamController = StreamController<MarketData>.broadcast();
  final Random _random = Random();
  
  // Simulated market data - replace with real API calls
  final Map<String, double> _currentPrices = {
    'EURUSD': 1.0950,
    'GBPUSD': 1.2650,
    'USDJPY': 148.50,
    'AUDUSD': 0.6550,
    'USDCAD': 1.3550,
    'NZDUSD': 0.6150,
    'USDCHF': 0.8950,
  };

  Stream<MarketData> get marketDataStream => _dataStreamController.stream;

  /// Get historical market data for a symbol and timeframe
  Future<List<MarketData>> getHistoricalData({
    required String symbol,
    required TimeframeType timeframe,
    required int bars,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 200));

    final data = <MarketData>[];
    final basePrice = _currentPrices[symbol] ?? 1.0;
    final now = DateTime.now();

    for (int i = bars; i >= 0; i--) {
      final timestamp = now.subtract(
        Duration(minutes: timeframe.minutes * i),
      );

      // Generate realistic OHLC data
      final open = basePrice + (_random.nextDouble() - 0.5) * 0.01;
      final change = (_random.nextDouble() - 0.5) * 0.005;
      final high = open + _random.nextDouble() * 0.003;
      final low = open - _random.nextDouble() * 0.003;
      final close = open + change;
      final volume = 100 + _random.nextDouble() * 500;

      data.add(MarketData(
        symbol: symbol,
        timestamp: timestamp,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
        bid: close - 0.0002,
        ask: close + 0.0002,
        spread: 0.0004,
      ));
    }

    return data;
  }

  /// Get current market price for a symbol
  Future<double> getCurrentPrice(String symbol) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _currentPrices[symbol] ?? 1.0;
  }

  /// Get current prices for multiple symbols
  Future<Map<String, double>> getCurrentPrices(List<String> symbols) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final prices = <String, double>{};
    
    for (final symbol in symbols) {
      prices[symbol] = _currentPrices[symbol] ?? 1.0;
    }
    
    return prices;
  }

  /// Subscribe to real-time price updates
  void subscribeToSymbol(String symbol) {
    // In production, subscribe to websocket/streaming API
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_dataStreamController.isClosed) {
        final basePrice = _currentPrices[symbol] ?? 1.0;
        final newPrice = basePrice + (_random.nextDouble() - 0.5) * 0.0005;
        
        _currentPrices[symbol] = newPrice;
        
        _dataStreamController.add(MarketData(
          symbol: symbol,
          timestamp: DateTime.now(),
          open: newPrice,
          high: newPrice + 0.0001,
          low: newPrice - 0.0001,
          close: newPrice,
          volume: 10 + _random.nextDouble() * 50,
          bid: newPrice - 0.0002,
          ask: newPrice + 0.0002,
          spread: 0.0004,
        ));
      }
    });
  }

  /// Get available trading symbols
  Future<List<MarketSymbol>> getAvailableSymbols() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    return [
      const MarketSymbol(
        symbol: 'EURUSD',
        name: 'Euro vs US Dollar',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'GBPUSD',
        name: 'British Pound vs US Dollar',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'USDJPY',
        name: 'US Dollar vs Japanese Yen',
        category: 'Major',
        pipSize: 0.01,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'AUDUSD',
        name: 'Australian Dollar vs US Dollar',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'USDCAD',
        name: 'US Dollar vs Canadian Dollar',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'NZDUSD',
        name: 'New Zealand Dollar vs US Dollar',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
      const MarketSymbol(
        symbol: 'USDCHF',
        name: 'US Dollar vs Swiss Franc',
        category: 'Major',
        pipSize: 0.0001,
        minLotSize: 0.01,
        maxLotSize: 100,
        lotStep: 0.01,
      ),
    ];
  }

  /// Get multi-timeframe data for a symbol
  Future<Map<TimeframeType, List<MarketData>>> getMultiTimeframeData({
    required String symbol,
    required List<TimeframeType> timeframes,
  }) async {
    final data = <TimeframeType, List<MarketData>>{};
    
    for (final timeframe in timeframes) {
      final historicalData = await getHistoricalData(
        symbol: symbol,
        timeframe: timeframe,
        bars: 100,
      );
      data[timeframe] = historicalData;
    }
    
    return data;
  }

  void dispose() {
    _dataStreamController.close();
  }
}
