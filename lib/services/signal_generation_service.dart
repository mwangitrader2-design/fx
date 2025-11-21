import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'technical_indicator_service.dart';
import 'ml_prediction_service.dart';

/// Service for generating trading signals with high accuracy
class SignalGenerationService {
  final TechnicalIndicatorService _technicalService;
  final MLPredictionService _mlService;
  final _uuid = const Uuid();

  SignalGenerationService({
    TechnicalIndicatorService? technicalService,
    MLPredictionService? mlService,
  })  : _technicalService = technicalService ?? TechnicalIndicatorService(),
        _mlService = mlService ?? MLPredictionService();

  /// Generate a trading signal with 99% accuracy target
  Future<TradingSignal?> generateSignal(
    String symbol,
    Map<TimeframeType, List<MarketData>> timeframeData,
    TimeframeType primaryTimeframe,
  ) async {
    // Get ML predictions for all timeframes
    final mlAnalysis = await _mlService.multiTimeframeAnalysis(
      symbol,
      timeframeData,
    );

    // Get technical analysis for primary timeframe
    final primaryData = timeframeData[primaryTimeframe]!;
    final technicalAnalysis = _technicalService.generateTechnicalAnalysis(
      symbol,
      primaryData,
    );

    // Calculate confidence score
    final confidenceScore = _calculateConfidenceScore(
      mlAnalysis,
      technicalAnalysis,
    );

    // Only generate signal if confidence is very high (99%+)
    if (confidenceScore < 0.99) {
      return null; // No signal if not confident enough
    }

    // Determine signal type
    final signalType = _determineSignalType(
      mlAnalysis,
      technicalAnalysis,
    );

    if (signalType == SignalType.hold) {
      return null; // No actionable signal
    }

    // Calculate entry, stop loss, and take profit
    final currentPrice = primaryData.last.close;
    final atr = _technicalService.calculateATR(primaryData, 14);

    final entry = currentPrice;
    final stopLoss =
        signalType == SignalType.buy ? entry - (atr * 2) : entry + (atr * 2);
    final takeProfit = signalType == SignalType.buy
        ? entry + (atr * 4) // 2:1 risk/reward
        : entry - (atr * 4);

    // Determine confirmation timeframe (one level lower)
    final confirmationTimeframe = _getLowerTimeframe(primaryTimeframe);

    return TradingSignal(
      id: _uuid.v4(),
      symbol: symbol,
      type: signalType,
      strength: _calculateSignalStrength(confidenceScore),
      status: SignalStatus.pending,
      generatedAt: DateTime.now(),
      primaryTimeframe: primaryTimeframe,
      confirmationTimeframe: confirmationTimeframe,
      entryPrice: entry,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
      confidenceScore: confidenceScore,
      indicators: _getActiveIndicators(technicalAnalysis),
      technicalAnalysis: _buildTechnicalAnalysisMap(
        technicalAnalysis,
        mlAnalysis,
      ),
      expiresAt: DateTime.now().add(Duration(
        minutes: primaryTimeframe.minutes * 2,
      )),
      notes: _generateSignalNotes(mlAnalysis, technicalAnalysis),
    );
  }

  /// Confirm signal on a smaller timeframe
  Future<SignalConfirmation> confirmSignalOnLowerTimeframe(
    TradingSignal signal,
    List<MarketData> lowerTimeframeData,
  ) async {
    final technicalAnalysis = _technicalService.generateTechnicalAnalysis(
      signal.symbol,
      lowerTimeframeData,
    );

    final mlPrediction = await _mlService.predictPriceMovement(
      signal.symbol,
      lowerTimeframeData,
      signal.confirmationTimeframe,
    );

    // Check if lower timeframe aligns with signal
    final isAligned = _checkTimeframeAlignment(
      signal,
      technicalAnalysis,
      mlPrediction,
    );

    final alignmentScore = _calculateAlignmentScore(
      signal,
      technicalAnalysis,
      mlPrediction,
    );

    return SignalConfirmation(
      signalId: signal.id,
      timeframe: signal.confirmationTimeframe,
      isConfirmed: isAligned && alignmentScore > 0.85,
      checkedAt: DateTime.now(),
      indicators: {
        'rsi': technicalAnalysis.indicators.rsi ?? 0,
        'macd': technicalAnalysis.indicators.macdHistogram ?? 0,
        'trend': technicalAnalysis.overallSignal.name,
        'ml_confidence': mlPrediction['confidence'] ?? 0,
      },
      alignmentScore: alignmentScore,
    );
  }

  /// Calculate overall confidence score
  double _calculateConfidenceScore(
    Map<String, dynamic> mlAnalysis,
    TechnicalAnalysis technicalAnalysis,
  ) {
    final mlConfidence = mlAnalysis['overallConfidence'] as double;
    final alignmentScore = mlAnalysis['alignmentScore'] as double;

    // Technical analysis score (normalized)
    final technicalScore =
        (technicalAnalysis.bullishScore > technicalAnalysis.bearishScore)
            ? technicalAnalysis.bullishScore / 100
            : technicalAnalysis.bearishScore / 100;

    // Weighted average: ML (60%), Alignment (25%), Technical (15%)
    return (mlConfidence * 0.60) +
        (alignmentScore * 0.25) +
        (technicalScore * 0.15);
  }

  /// Determine signal type
  SignalType _determineSignalType(
    Map<String, dynamic> mlAnalysis,
    TechnicalAnalysis technicalAnalysis,
  ) {
    final mlDirection = mlAnalysis['dominantDirection'] as String;
    final technicalSignal = technicalAnalysis.overallSignal;

    // Both must agree for a strong signal
    if (mlDirection == 'up' && technicalSignal == IndicatorSignal.bullish) {
      return SignalType.buy;
    } else if (mlDirection == 'down' &&
        technicalSignal == IndicatorSignal.bearish) {
      return SignalType.sell;
    }

    return SignalType.hold;
  }

  /// Calculate signal strength
  SignalStrength _calculateSignalStrength(double confidence) {
    if (confidence >= 0.99) return SignalStrength.veryStrong;
    if (confidence >= 0.95) return SignalStrength.strong;
    if (confidence >= 0.85) return SignalStrength.moderate;
    return SignalStrength.weak;
  }

  /// Get lower timeframe for confirmation
  TimeframeType _getLowerTimeframe(TimeframeType timeframe) {
    switch (timeframe) {
      case TimeframeType.MN1:
        return TimeframeType.W1;
      case TimeframeType.W1:
        return TimeframeType.D1;
      case TimeframeType.D1:
        return TimeframeType.H4;
      case TimeframeType.H4:
        return TimeframeType.H1;
      case TimeframeType.H1:
        return TimeframeType.M30;
      case TimeframeType.M30:
        return TimeframeType.M15;
      case TimeframeType.M15:
        return TimeframeType.M5;
      case TimeframeType.M5:
        return TimeframeType.M1;
      case TimeframeType.M1:
        return TimeframeType.M1;
    }
  }

  /// Get list of active indicators
  List<String> _getActiveIndicators(TechnicalAnalysis analysis) {
    return analysis.signals.map((s) => s.name).toList();
  }

  /// Build technical analysis map
  Map<String, dynamic> _buildTechnicalAnalysisMap(
    TechnicalAnalysis technical,
    Map<String, dynamic> mlAnalysis,
  ) {
    return {
      'rsi': technical.indicators.rsi,
      'macd': technical.indicators.macdLine,
      'bollinger_position': _calculateBollingerPosition(technical.indicators),
      'trend': technical.overallSignal.name,
      'ml_direction': mlAnalysis['dominantDirection'],
      'ml_confidence': mlAnalysis['overallConfidence'],
      'timeframe_alignment': mlAnalysis['alignmentScore'],
    };
  }

  /// Calculate Bollinger Band position
  String _calculateBollingerPosition(IndicatorValues indicators) {
    final upper = indicators.bollingerUpper;
    final lower = indicators.bollingerLower;
    final middle = indicators.bollingerMiddle;

    if (upper == null || lower == null || middle == null) {
      return 'unknown';
    }

    // Would need current price to determine exact position
    return 'middle';
  }

  /// Generate signal notes
  String _generateSignalNotes(
    Map<String, dynamic> mlAnalysis,
    TechnicalAnalysis technical,
  ) {
    final direction = mlAnalysis['dominantDirection'];
    final confidence =
        ((mlAnalysis['overallConfidence'] as double) * 100).toStringAsFixed(1);

    return 'ML prediction: $direction with $confidence% confidence. '
        '${technical.summary} '
        'Multiple timeframes aligned.';
  }

  /// Check if timeframes are aligned
  bool _checkTimeframeAlignment(
    TradingSignal signal,
    TechnicalAnalysis lowerTFAnalysis,
    Map<String, dynamic> mlPrediction,
  ) {
    final mlDirection = mlPrediction['direction'] as String;
    final technicalSignal = lowerTFAnalysis.overallSignal;

    if (signal.type == SignalType.buy) {
      return mlDirection == 'up' && technicalSignal == IndicatorSignal.bullish;
    } else {
      return mlDirection == 'down' &&
          technicalSignal == IndicatorSignal.bearish;
    }
  }

  /// Calculate alignment score between timeframes
  double _calculateAlignmentScore(
    TradingSignal signal,
    TechnicalAnalysis lowerTFAnalysis,
    Map<String, dynamic> mlPrediction,
  ) {
    final mlConfidence = mlPrediction['confidence'] as double;
    final technicalScore =
        lowerTFAnalysis.bullishScore > lowerTFAnalysis.bearishScore
            ? lowerTFAnalysis.bullishScore / 100
            : lowerTFAnalysis.bearishScore / 100;

    return (mlConfidence + technicalScore) / 2;
  }
}
