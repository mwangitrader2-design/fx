import '../models/models.dart';
import 'mt5_service.dart';

/// Service to fetch and convert MT5 chart data for signal generation
class MT5ChartService {
  final MT5Service _mt5Service;

  MT5ChartService({MT5Service? mt5Service})
      : _mt5Service = mt5Service ?? MT5Service();

  /// Fetch chart data from MT5 for a single timeframe
  Future<List<MarketData>> getMarketData({
    required String symbol,
    required String timeframe,
    int count = 500,
  }) async {
    try {
      final response = await _mt5Service.getChartData(
        symbol: symbol,
        timeframe: timeframe,
        count: count,
      );

      if (response['success'] != true) {
        throw Exception(response['message'] ?? 'Failed to get chart data');
      }

      final data = response['data'];
      final candles = data['candles'] as List<dynamic>;

      return candles.map((candle) {
        return MarketData(
          symbol: symbol,
          timestamp: DateTime.fromMillisecondsSinceEpoch(
            (candle['time'] as int) * 1000,
          ),
          open: (candle['open'] as num).toDouble(),
          high: (candle['high'] as num).toDouble(),
          low: (candle['low'] as num).toDouble(),
          close: (candle['close'] as num).toDouble(),
          volume: (candle['tick_volume'] as num).toDouble(),
          spread: (candle['spread'] as num).toDouble(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error fetching market data: $e');
    }
  }

  /// Fetch chart data for multiple timeframes at once
  Future<Map<TimeframeType, List<MarketData>>> getMultiTimeframeMarketData({
    required String symbol,
    List<String>? timeframes,
    int count = 500,
  }) async {
    try {
      // Default timeframes for signal generation
      final tfs = timeframes ?? ['M15', 'H1', 'H4', 'D1'];

      final response = await _mt5Service.getMultiTimeframeData(
        symbol: symbol,
        timeframes: tfs,
        count: count,
      );

      if (response['success'] != true) {
        throw Exception(
            response['message'] ?? 'Failed to get multi-timeframe data');
      }

      final data = response['data'];
      final timeframesData = data['timeframes'] as Map<String, dynamic>;

      final result = <TimeframeType, List<MarketData>>{};

      for (final entry in timeframesData.entries) {
        final tfString = entry.key;
        final candles = entry.value as List<dynamic>;

        final timeframeType = _mapTimeframeStringToType(tfString);
        if (timeframeType == null) continue;

        result[timeframeType] = candles.map((candle) {
          return MarketData(
            symbol: symbol,
            timestamp: DateTime.fromMillisecondsSinceEpoch(
              (candle['time'] as int) * 1000,
            ),
            open: (candle['open'] as num).toDouble(),
            high: (candle['high'] as num).toDouble(),
            low: (candle['low'] as num).toDouble(),
            close: (candle['close'] as num).toDouble(),
            volume: (candle['tick_volume'] as num).toDouble(),
            spread: (candle['spread'] as num).toDouble(),
          );
        }).toList();
      }

      return result;
    } catch (e) {
      throw Exception('Error fetching multi-timeframe data: $e');
    }
  }

  /// Map MT5 timeframe string to TimeframeType enum
  TimeframeType? _mapTimeframeStringToType(String timeframe) {
    switch (timeframe) {
      case 'M1':
        return TimeframeType.M1;
      case 'M5':
        return TimeframeType.M5;
      case 'M15':
        return TimeframeType.M15;
      case 'M30':
        return TimeframeType.M30;
      case 'H1':
        return TimeframeType.H1;
      case 'H4':
        return TimeframeType.H4;
      case 'D1':
        return TimeframeType.D1;
      case 'W1':
        return TimeframeType.W1;
      case 'MN1':
        return TimeframeType.MN1;
      default:
        return null;
    }
  }

  /// Convert TimeframeType to MT5 timeframe string
  String timeframeTypeToString(TimeframeType timeframe) {
    switch (timeframe) {
      case TimeframeType.M1:
        return 'M1';
      case TimeframeType.M5:
        return 'M5';
      case TimeframeType.M15:
        return 'M15';
      case TimeframeType.M30:
        return 'M30';
      case TimeframeType.H1:
        return 'H1';
      case TimeframeType.H4:
        return 'H4';
      case TimeframeType.D1:
        return 'D1';
      case TimeframeType.W1:
        return 'W1';
      case TimeframeType.MN1:
        return 'MN1';
    }
  }

  /// Get current price from latest candle
  Future<double?> getCurrentPrice(String symbol, String timeframe) async {
    try {
      final marketData = await getMarketData(
        symbol: symbol,
        timeframe: timeframe,
        count: 1,
      );

      if (marketData.isEmpty) return null;

      return marketData.last.close;
    } catch (e) {
      return null;
    }
  }
}
