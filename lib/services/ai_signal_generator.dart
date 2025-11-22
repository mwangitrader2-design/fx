import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'ai_market_analyzer.dart';
import 'technical_indicator_service.dart';
import 'ml_prediction_service.dart';
import 'firebase_service.dart';
import 'mt5_chart_service.dart';

/// Advanced AI-powered signal generation service targeting 99% accuracy
class AISignalGenerator {
  final AIMarketAnalyzer _marketAnalyzer;
  final TechnicalIndicatorService _technicalService;
  final MLPredictionService _mlService;
  final FirebaseService _firebaseService;
  final MT5ChartService _mt5ChartService;
  final _uuid = const Uuid();

  // Minimum confidence threshold for signal generation (99%)
  // Temporarily lowered for testing - change back to 0.99 for production
  static const double MIN_CONFIDENCE_THRESHOLD = 0.85;

  AISignalGenerator({
    AIMarketAnalyzer? marketAnalyzer,
    TechnicalIndicatorService? technicalService,
    MLPredictionService? mlService,
    FirebaseService? firebaseService,
    MT5ChartService? mt5ChartService,
  })  : _marketAnalyzer = marketAnalyzer ?? AIMarketAnalyzer(),
        _technicalService = technicalService ?? TechnicalIndicatorService(),
        _mlService = mlService ?? MLPredictionService(),
        _firebaseService = firebaseService ?? FirebaseService(),
        _mt5ChartService = mt5ChartService ?? MT5ChartService();

  /// Generate signal using live MT5 chart data
  Future<TradingSignal?> generateSignalFromMT5({
    required String symbol,
    TimeframeType primaryTimeframe = TimeframeType.H1,
    List<TimeframeType>? additionalTimeframes,
  }) async {
    try {
      // Define timeframes to analyze (primary + higher/lower for confirmation)
      final timeframesToFetch = additionalTimeframes ??
          [
            TimeframeType.M15,
            TimeframeType.H1,
            TimeframeType.H4,
            TimeframeType.D1,
          ];

      // Convert to MT5 timeframe strings
      final timeframeStrings = timeframesToFetch
          .map((tf) => _mt5ChartService.timeframeTypeToString(tf))
          .toList();

      // Fetch multi-timeframe data from MT5
      await _firebaseService.logEvent('fetching_mt5_chart_data', {
        'symbol': symbol,
        'timeframes': timeframeStrings.join(','),
      });

      final timeframeData = await _mt5ChartService.getMultiTimeframeMarketData(
        symbol: symbol,
        timeframes: timeframeStrings,
        count: 500,
      );

      if (timeframeData.isEmpty) {
        await _firebaseService.logEvent('mt5_data_fetch_failed', {
          'symbol': symbol,
          'reason': 'No data returned',
        });
        return null;
      }

      // Generate signal using the fetched MT5 data
      return await generateSignal(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: primaryTimeframe,
      );
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('MT5 signal generation error', stackTrace, context: {
        'symbol': symbol,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Generate high-accuracy trading signal (99%+ target)
  Future<TradingSignal?> generateSignal({
    required String symbol,
    required Map<TimeframeType, List<MarketData>> timeframeData,
    required TimeframeType primaryTimeframe,
  }) async {
    try {
      // 1. Comprehensive market analysis
      final marketAnalysis = await _marketAnalyzer.analyzeMarket(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: primaryTimeframe,
      );

      // 2. Check if confidence meets minimum threshold
      if (marketAnalysis.confidence < MIN_CONFIDENCE_THRESHOLD) {
        await _firebaseService.logEvent('signal_rejected_low_confidence', {
          'symbol': symbol,
          'confidence': marketAnalysis.confidence,
          'threshold': MIN_CONFIDENCE_THRESHOLD,
        });
        return null; // Not confident enough
      }

      // 3. Verify recommendation is actionable
      final recommendation = marketAnalysis.recommendation;
      if (recommendation['action'] == 'HOLD') {
        return null; // No actionable signal
      }

      // 4. Calculate signal parameters
      final currentPrice = marketAnalysis.currentPrice;
      final atr = marketAnalysis.volatility['atr'] as double;
      final keyLevels = marketAnalysis.keyLevels;

      final signalType =
          recommendation['action'] == 'BUY' ? SignalType.buy : SignalType.sell;

      // 5. Calculate entry, stop loss, and take profit with risk management
      final signalParams = _calculateSignalParameters(
        signalType: signalType,
        currentPrice: currentPrice,
        atr: atr,
        keyLevels: keyLevels,
        volatility: marketAnalysis.volatility,
      );

      // 6. Determine confirmation timeframe
      final confirmationTimeframe = _getLowerTimeframe(primaryTimeframe);

      // 7. Calculate signal strength
      final signalStrength = _calculateSignalStrength(
        marketAnalysis.confidence,
        marketAnalysis.sentiment,
        marketAnalysis.patterns.length,
      );

      // 8. Create the signal
      final signal = TradingSignal(
        id: _uuid.v4(),
        symbol: symbol,
        type: signalType,
        strength: signalStrength,
        status: SignalStatus.pending,
        generatedAt: DateTime.now(),
        primaryTimeframe: primaryTimeframe,
        confirmationTimeframe: confirmationTimeframe,
        entryPrice: signalParams['entry']!,
        stopLoss: signalParams['stopLoss']!,
        takeProfit: signalParams['takeProfit']!,
        confidenceScore: marketAnalysis.confidence,
        indicators: _extractActiveIndicators(marketAnalysis),
        technicalAnalysis: marketAnalysis.technicalAnalysis,
        expiresAt: DateTime.now().add(Duration(
          minutes: primaryTimeframe.minutes * 3,
        )),
        notes: _generateSignalNotes(marketAnalysis).join('; '),
      );

      // 9. Log signal generation
      await _firebaseService.logSignal(signal);
      await _firebaseService.logEvent('high_confidence_signal_generated', {
        'symbol': symbol,
        'type': signalType.toString(),
        'confidence': marketAnalysis.confidence,
        'strength': signalStrength.toString(),
      });

      return signal;
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Signal generation error', stackTrace, context: {
        'symbol': symbol,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Confirm signal on lower timeframe before execution
  Future<SignalConfirmation> confirmSignalOnLowerTimeframe(
    TradingSignal signal,
    List<MarketData> lowerTimeframeData,
  ) async {
    try {
      // 1. Perform quick analysis on lower timeframe
      final lowerTimeframeAnalysis = await _analyzeConfirmationTimeframe(
        signal.symbol,
        lowerTimeframeData,
        signal.type,
      );

      // 2. Check alignment with signal direction
      final isAligned = _checkDirectionAlignment(
        signal.type,
        lowerTimeframeAnalysis,
      );

      // 3. Verify entry conditions
      final entryConditionsMet = _verifyEntryConditions(
        signal,
        lowerTimeframeData,
        lowerTimeframeAnalysis,
      );

      // 4. Calculate confirmation confidence
      final confirmationConfidence = _calculateConfirmationConfidence(
        isAligned,
        entryConditionsMet,
        lowerTimeframeAnalysis,
      );

      // 5. Check if confirmation threshold is met (98%+)
      final isConfirmed =
          confirmationConfidence >= 0.98 && isAligned && entryConditionsMet;

      // 6. Log confirmation attempt
      await _firebaseService.logEvent('signal_confirmation', {
        'signalId': signal.id,
        'symbol': signal.symbol,
        'confirmed': isConfirmed,
        'confidence': confirmationConfidence,
      });

      return SignalConfirmation(
        signalId: signal.id,
        timeframe: signal.confirmationTimeframe,
        isConfirmed: isConfirmed,
        checkedAt: DateTime.now(),
        indicators: {
          'confidence': confirmationConfidence,
          'price': lowerTimeframeData.last.close,
        },
        alignmentScore: confirmationConfidence,
      );
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Signal confirmation error', stackTrace, context: {
        'signalId': signal.id,
        'symbol': signal.symbol,
      });

      return SignalConfirmation(
        signalId: signal.id,
        timeframe: signal.confirmationTimeframe,
        isConfirmed: false,
        checkedAt: DateTime.now(),
        indicators: {
          'error': e.toString(),
          'price': lowerTimeframeData.last.close,
        },
        alignmentScore: 0.0,
      );
    }
  }

  /// Analyze confirmation timeframe
  Future<Map<String, dynamic>> _analyzeConfirmationTimeframe(
    String symbol,
    List<MarketData> data,
    SignalType expectedDirection,
  ) async {
    // Extract closing prices for technical analysis
    final closePrices = data.map((d) => d.close).toList();

    // Quick technical analysis
    final rsi = _technicalService.calculateRSI(closePrices, 14);
    final macd = _technicalService.calculateMACD(closePrices);
    final ema20 = _technicalService.calculateEMA(closePrices, 20);
    final ema50 = _technicalService.calculateEMA(closePrices, 50);
    final adx = _technicalService.calculateADX(data, 14);

    // Determine trend
    final currentPrice = data.last.close;
    final trend = _determineTrend(currentPrice, ema20, ema50);

    // Check momentum
    final momentum = _calculateMomentum(data);

    return {
      'rsi': rsi,
      'macd': macd,
      'ema20': ema20,
      'ema50': ema50,
      'adx': adx,
      'trend': trend,
      'momentum': momentum,
      'currentPrice': currentPrice,
    };
  }

  /// Check if lower timeframe aligns with signal direction
  bool _checkDirectionAlignment(
    SignalType signalType,
    Map<String, dynamic> analysis,
  ) {
    final trend = analysis['trend'];
    final rsi = analysis['rsi'] as double;
    final momentum = analysis['momentum'] as double;

    if (signalType == SignalType.buy) {
      return trend == 'uptrend' && rsi < 70 && momentum > 0;
    } else if (signalType == SignalType.sell) {
      return trend == 'downtrend' && rsi > 30 && momentum < 0;
    }

    return false;
  }

  /// Verify entry conditions are met
  bool _verifyEntryConditions(
    TradingSignal signal,
    List<MarketData> data,
    Map<String, dynamic> analysis,
  ) {
    final currentPrice = data.last.close;
    final entryPrice = signal.entryPrice;
    final rsi = analysis['rsi'] as double;
    final adx = analysis['adx'] as double;

    // Price should be near entry point
    final priceDifference = (currentPrice - entryPrice).abs() / entryPrice;
    if (priceDifference > 0.003) return false; // More than 0.3% difference

    // RSI should be in favorable range
    if (signal.type == SignalType.buy && rsi > 70) return false;
    if (signal.type == SignalType.sell && rsi < 30) return false;

    // ADX should show trend strength
    if (adx < 20) return false;

    return true;
  }

  /// Calculate confirmation confidence
  double _calculateConfirmationConfidence(
    bool isAligned,
    bool entryConditionsMet,
    Map<String, dynamic> analysis,
  ) {
    double confidence = 0.0;

    // Direction alignment (40% weight)
    if (isAligned) confidence += 0.40;

    // Entry conditions (30% weight)
    if (entryConditionsMet) confidence += 0.30;

    // Trend strength (15% weight)
    final adx = analysis['adx'] as double;
    confidence += (adx / 100) * 0.15;

    // Momentum (15% weight)
    final momentum = analysis['momentum'] as double;
    confidence += (momentum.abs() / 10).clamp(0.0, 0.15);

    return confidence.clamp(0.0, 1.0);
  }

  /// Calculate signal parameters (entry, stop loss, take profit)
  Map<String, double> _calculateSignalParameters({
    required SignalType signalType,
    required double currentPrice,
    required double atr,
    required Map<String, List<double>> keyLevels,
    required Map<String, dynamic> volatility,
  }) {
    final entry = currentPrice;

    // Calculate stop loss based on ATR and key levels
    double stopLoss;
    if (signalType == SignalType.buy) {
      // Place stop loss below nearest support
      final supports = keyLevels['support'] ?? [];
      final nearestSupport = supports.isEmpty
          ? entry - (atr * 2)
          : supports.lastWhere((s) => s < entry,
              orElse: () => entry - (atr * 2));
      stopLoss = nearestSupport - (atr * 0.5); // Buffer below support
    } else {
      // Place stop loss above nearest resistance
      final resistances = keyLevels['resistance'] ?? [];
      final nearestResistance = resistances.isEmpty
          ? entry + (atr * 2)
          : resistances.firstWhere((r) => r > entry,
              orElse: () => entry + (atr * 2));
      stopLoss = nearestResistance + (atr * 0.5); // Buffer above resistance
    }

    // Calculate take profit with favorable risk-reward ratio (minimum 3:1)
    final riskDistance = (entry - stopLoss).abs();
    final takeProfit = signalType == SignalType.buy
        ? entry + (riskDistance * 3) // 3:1 risk-reward
        : entry - (riskDistance * 3);

    return {
      'entry': entry,
      'stopLoss': stopLoss,
      'takeProfit': takeProfit,
      'riskReward': 3.0,
    };
  }

  /// Calculate signal strength
  SignalStrength _calculateSignalStrength(
    double confidence,
    double sentiment,
    int patternCount,
  ) {
    double strengthScore = confidence;
    strengthScore += sentiment.abs() * 0.1;
    strengthScore += (patternCount * 0.05).clamp(0.0, 0.15);

    if (strengthScore >= 0.95) return SignalStrength.veryStrong;
    if (strengthScore >= 0.85) return SignalStrength.strong;
    if (strengthScore >= 0.75) return SignalStrength.moderate;
    return SignalStrength.weak;
  }

  /// Extract active indicators from analysis
  List<String> _extractActiveIndicators(MarketAnalysisResult analysis) {
    final indicators = <String>[];
    final tech =
        analysis.technicalAnalysis['indicators'] as Map<String, dynamic>;

    if (tech['rsi_signal'] != 'neutral') {
      indicators.add('RSI: ${tech['rsi_signal']}');
    }
    if (tech['macd_signal'] != 'neutral') {
      indicators.add('MACD: ${tech['macd_signal']}');
    }
    if (tech['ema_signal'] != 'neutral') {
      indicators.add('EMA: ${tech['ema_signal']}');
    }
    if (tech['bollinger_signal'] != 'neutral') {
      indicators.add('Bollinger: ${tech['bollinger_signal']}');
    }

    indicators.add('ADX: ${tech['trend_strength']}');

    if (analysis.patterns.isNotEmpty) {
      indicators.addAll(analysis.patterns);
    }

    return indicators;
  }

  /// Generate signal notes
  List<String> _generateSignalNotes(MarketAnalysisResult analysis) {
    final notes = <String>[];

    notes.add('Confidence: ${(analysis.confidence * 100).toStringAsFixed(1)}%');
    notes.add('Market: ${analysis.marketCondition}');
    notes.add('Sentiment: ${_getSentimentLabel(analysis.sentiment)}');

    if (analysis.patterns.isNotEmpty) {
      notes.add('Patterns: ${analysis.patterns.join(", ")}');
    }

    final recommendation = analysis.recommendation;
    if (recommendation['reasons'] != null) {
      notes.addAll(List<String>.from(recommendation['reasons']));
    }

    return notes;
  }

  String _getSentimentLabel(double sentiment) {
    if (sentiment > 0.5) return 'Very Bullish';
    if (sentiment > 0.2) return 'Bullish';
    if (sentiment > -0.2) return 'Neutral';
    if (sentiment > -0.5) return 'Bearish';
    return 'Very Bearish';
  }

  String _determineTrend(double price, double ema20, double ema50) {
    if (price > ema20 && ema20 > ema50) return 'uptrend';
    if (price < ema20 && ema20 < ema50) return 'downtrend';
    return 'sideways';
  }

  double _calculateMomentum(List<MarketData> data) {
    if (data.length < 10) return 0.0;

    final recent = data.sublist(data.length - 10);
    final oldPrice = recent.first.close;
    final newPrice = recent.last.close;

    return (newPrice - oldPrice) / oldPrice * 100;
  }

  TimeframeType _getLowerTimeframe(TimeframeType timeframe) {
    switch (timeframe) {
      case TimeframeType.D1:
        return TimeframeType.H4;
      case TimeframeType.H4:
        return TimeframeType.H1;
      case TimeframeType.H1:
        return TimeframeType.M15;
      case TimeframeType.M15:
        return TimeframeType.M5;
      case TimeframeType.M5:
        return TimeframeType.M1;
      default:
        return TimeframeType.M15;
    }
  }
}
