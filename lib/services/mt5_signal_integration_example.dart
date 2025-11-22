import '../models/models.dart';
import 'ai_signal_generator.dart';
import 'mt5_chart_service.dart';
import 'mt5_service.dart';

/// Example service showing how to integrate MT5 chart data with signal generation
class MT5SignalIntegrationExample {
  final AISignalGenerator _signalGenerator;
  final MT5ChartService _chartService;
  final MT5Service _mt5Service;

  MT5SignalIntegrationExample({
    AISignalGenerator? signalGenerator,
    MT5ChartService? chartService,
    MT5Service? mt5Service,
  })  : _signalGenerator = signalGenerator ?? AISignalGenerator(),
        _chartService = chartService ?? MT5ChartService(),
        _mt5Service = mt5Service ?? MT5Service();

  /// Generate signals for multiple currency pairs using live MT5 data
  Future<List<TradingSignal>> generateSignalsForSymbols({
    required List<String> symbols,
    TimeframeType primaryTimeframe = TimeframeType.H1,
  }) async {
    final signals = <TradingSignal>[];

    for (final symbol in symbols) {
      try {
        print('Generating signal for $symbol...');

        // Generate signal using live MT5 chart data
        final signal = await _signalGenerator.generateSignalFromMT5(
          symbol: symbol,
          primaryTimeframe: primaryTimeframe,
        );

        if (signal != null) {
          print('✅ Signal generated for $symbol: '
              '${signal.type} at ${signal.entryPrice.toStringAsFixed(5)} '
              '(Confidence: ${(signal.confidenceScore * 100).toStringAsFixed(1)}%)');
          signals.add(signal);
        } else {
          print(
              '❌ No signal generated for $symbol (confidence too low or no clear trend)');
        }
      } catch (e) {
        print('❌ Error generating signal for $symbol: $e');
      }
    }

    return signals;
  }

  /// Generate a single signal with detailed logging
  Future<TradingSignal?> generateDetailedSignal(String symbol) async {
    try {
      print('\n📊 Fetching MT5 chart data for $symbol...');

      // Fetch multi-timeframe data
      final timeframeData = await _chartService.getMultiTimeframeMarketData(
        symbol: symbol,
        timeframes: ['M15', 'H1', 'H4', 'D1'],
        count: 500,
      );

      print('✅ Retrieved data for ${timeframeData.length} timeframes:');
      for (final entry in timeframeData.entries) {
        print('  - ${entry.key}: ${entry.value.length} candles');
      }

      print('\n🤖 Analyzing market conditions...');

      // Generate signal
      final signal = await _signalGenerator.generateSignal(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: TimeframeType.H1,
      );

      if (signal != null) {
        print('\n✅ HIGH-CONFIDENCE SIGNAL GENERATED!');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('Symbol: ${signal.symbol}');
        print('Type: ${signal.type}');
        print('Strength: ${signal.strength}');
        print(
            'Confidence: ${(signal.confidenceScore * 100).toStringAsFixed(2)}%');
        print('Entry Price: ${signal.entryPrice.toStringAsFixed(5)}');
        print('Stop Loss: ${signal.stopLoss.toStringAsFixed(5)}');
        print('Take Profit: ${signal.takeProfit.toStringAsFixed(5)}');
        print('Timeframe: ${signal.primaryTimeframe}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
      } else {
        print(
            '\n❌ No signal: Conditions do not meet 99% confidence threshold\n');
      }

      return signal;
    } catch (e) {
      print('❌ Error: $e\n');
      return null;
    }
  }

  /// Check if MT5 connection is ready
  Future<bool> checkMT5Connection() async {
    try {
      final accountInfo = await _mt5Service.getAccountInfo();
      return accountInfo['success'] == true;
    } catch (e) {
      print('❌ MT5 not connected: $e');
      return false;
    }
  }

  /// Get current price from MT5
  Future<double?> getCurrentPrice(String symbol) async {
    try {
      return await _chartService.getCurrentPrice(symbol, 'M1');
    } catch (e) {
      print('Error getting current price: $e');
      return null;
    }
  }
}

/// Example usage in your app
/// 
/// ```dart
/// final integration = MT5SignalIntegrationExample();
/// 
/// // Check connection
/// if (await integration.checkMT5Connection()) {
///   // Generate signals for major pairs
///   final signals = await integration.generateSignalsForSymbols(
///     symbols: ['EURUSD', 'GBPUSD', 'USDJPY', 'AUDUSD'],
///     primaryTimeframe: TimeframeType.H1,
///   );
///   
///   print('Generated ${signals.length} high-confidence signals');
/// }
/// ```
