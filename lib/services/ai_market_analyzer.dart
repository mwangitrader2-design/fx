import 'dart:math';
import '../models/models.dart';
import 'technical_indicator_service.dart';
import 'ml_prediction_service.dart';
import 'firebase_service.dart';

/// Advanced AI-powered market analysis service
class AIMarketAnalyzer {
  final TechnicalIndicatorService _technicalService;
  final MLPredictionService _mlService;
  final FirebaseService _firebaseService;

  AIMarketAnalyzer({
    TechnicalIndicatorService? technicalService,
    MLPredictionService? mlService,
    FirebaseService? firebaseService,
  })  : _technicalService = technicalService ?? TechnicalIndicatorService(),
        _mlService = mlService ?? MLPredictionService(),
        _firebaseService = firebaseService ?? FirebaseService();

  /// Comprehensive AI market analysis
  Future<MarketAnalysisResult> analyzeMarket({
    required String symbol,
    required Map<TimeframeType, List<MarketData>> timeframeData,
    required TimeframeType primaryTimeframe,
  }) async {
    try {
      final startTime = DateTime.now();

      // 1. Technical Analysis
      final technicalAnalysis = await _performTechnicalAnalysis(
        symbol,
        timeframeData[primaryTimeframe]!,
      );

      // 2. Multi-timeframe Analysis
      final multiTimeframeAnalysis = await _performMultiTimeframeAnalysis(
        symbol,
        timeframeData,
      );

      // 3. ML Prediction
      final mlPrediction = await _performMLPrediction(
        symbol,
        timeframeData,
        primaryTimeframe,
      );

      // 4. Pattern Recognition
      final patterns = await _recognizePatterns(
        symbol,
        timeframeData[primaryTimeframe]!,
      );

      // 5. Market Sentiment Analysis
      final sentiment = _calculateMarketSentiment(
        technicalAnalysis,
        multiTimeframeAnalysis,
        mlPrediction,
      );

      // 6. Support and Resistance Levels
      final keyLevels = _identifyKeyLevels(
        timeframeData[primaryTimeframe]!,
      );

      // 7. Volatility Analysis
      final volatility = _analyzeVolatility(
        timeframeData[primaryTimeframe]!,
      );

      // 8. Market Condition
      final marketCondition = _determineMarketCondition(
        technicalAnalysis,
        volatility,
        sentiment,
      );

      // 9. Generate Trading Recommendation
      final recommendation = _generateRecommendation(
        technicalAnalysis,
        mlPrediction,
        sentiment,
        patterns,
        marketCondition,
      );

      // Calculate analysis confidence
      final confidence = _calculateAnalysisConfidence(
        technicalAnalysis,
        mlPrediction,
        multiTimeframeAnalysis,
        patterns,
      );

      final result = MarketAnalysisResult(
        symbol: symbol,
        timestamp: DateTime.now(),
        primaryTimeframe: primaryTimeframe,
        currentPrice: timeframeData[primaryTimeframe]!.last.close,
        technicalAnalysis: technicalAnalysis,
        multiTimeframeAnalysis: multiTimeframeAnalysis,
        mlPrediction: mlPrediction,
        patterns: patterns,
        sentiment: sentiment,
        keyLevels: keyLevels,
        volatility: volatility,
        marketCondition: marketCondition,
        recommendation: recommendation,
        confidence: confidence,
        processingTime: DateTime.now().difference(startTime),
      );

      // Store analysis in Firebase
      await _firebaseService.storeTechnicalAnalysis(symbol, result.toJson());
      await _firebaseService.logEvent('market_analyzed', {
        'symbol': symbol,
        'confidence': confidence,
        'recommendation': recommendation['action'],
      });

      return result;
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Market analysis error', stackTrace, context: {
        'symbol': symbol,
        'error': e.toString(),
      });
      rethrow;
    }
  }

  /// Perform technical analysis
  Future<Map<String, dynamic>> _performTechnicalAnalysis(
    String symbol,
    List<MarketData> data,
  ) async {
    // Calculate technical indicators
    final closes = data.map((d) => d.close).toList();
    final rsi = _technicalService.calculateRSI(closes, 14);
    final macd = _technicalService.calculateMACD(closes);
    final bollinger = _technicalService.calculateBollingerBands(closes, 20, 2);
    final ema20 = _technicalService.calculateEMA(closes, 20);
    final ema50 = _technicalService.calculateEMA(closes, 50);
    final ema200 = _technicalService.calculateEMA(closes, 200);
    final atr = _technicalService.calculateATR(data, 14);
    final adx = _technicalService.calculateADX(data, 14);
    final stochastic = _technicalService.calculateStochastic(data, 14);

    return {
      'indicators': {
        'rsi': rsi,
        'rsi_signal': _getRSISignal(rsi),
        'macd': macd,
        'macd_signal': _getMACDSignal(macd),
        'bollinger': bollinger,
        'bollinger_signal': _getBollingerSignal(data.last.close, bollinger),
        'ema20': ema20,
        'ema50': ema50,
        'ema200': ema200,
        'ema_signal': _getEMASignal(ema20, ema50, ema200, data.last.close),
        'atr': atr,
        'adx': adx,
        'trend_strength': _getTrendStrength(adx),
        'stochastic': stochastic,
        'stochastic_signal': _getStochasticSignal(stochastic),
      },
    };
  }

  /// Perform multi-timeframe analysis
  Future<Map<String, dynamic>> _performMultiTimeframeAnalysis(
    String symbol,
    Map<TimeframeType, List<MarketData>> timeframeData,
  ) async {
    final timeframeAnalysis = <String, Map<String, dynamic>>{};

    for (final entry in timeframeData.entries) {
      final timeframe = entry.key;
      final data = entry.value;

      // Calculate trend for each timeframe
      final closes = data.map((d) => d.close).toList();
      final ema20 = _technicalService.calculateEMA(closes, 20);
      final ema50 = _technicalService.calculateEMA(closes, 50);
      final rsi = _technicalService.calculateRSI(closes, 14);
      final adx = _technicalService.calculateADX(data, 14);

      final trend = _determineTrend(ema20, ema50, data.last.close);
      final strength = _getTrendStrength(adx);

      timeframeAnalysis[timeframe.toString()] = {
        'timeframe': timeframe.toString(),
        'trend': trend,
        'strength': strength,
        'rsi': rsi,
        'ema20': ema20,
        'ema50': ema50,
        'currentPrice': data.last.close,
      };
    }

    // Calculate timeframe alignment score
    final alignmentScore = _calculateTimeframeAlignment(timeframeAnalysis);

    return {
      'timeframes': timeframeAnalysis,
      'alignment': alignmentScore,
      'consensus': _getTimeframeConsensus(timeframeAnalysis),
    };
  }

  /// Perform ML prediction
  Future<Map<String, dynamic>> _performMLPrediction(
    String symbol,
    Map<TimeframeType, List<MarketData>> timeframeData,
    TimeframeType primaryTimeframe,
  ) async {
    final prediction = await _mlService.predictPriceMovement(
      symbol,
      timeframeData[primaryTimeframe]!,
      primaryTimeframe,
    );

    // Store prediction in Firebase
    await _firebaseService.storePrediction(symbol, prediction);

    return prediction;
  }

  /// Recognize chart patterns
  Future<List<String>> _recognizePatterns(
      String symbol, List<MarketData> data) async {
    final patterns = <String>[];

    // Head and Shoulders pattern
    if (_detectHeadAndShoulders(data)) {
      patterns.add('Head and Shoulders');
    }

    // Double Top/Bottom
    if (_detectDoubleTop(data)) {
      patterns.add('Double Top');
    }
    if (_detectDoubleBottom(data)) {
      patterns.add('Double Bottom');
    }

    // Triangle patterns
    if (_detectAscendingTriangle(data)) {
      patterns.add('Ascending Triangle');
    }
    if (_detectDescendingTriangle(data)) {
      patterns.add('Descending Triangle');
    }

    // Flag and Pennant
    if (_detectBullFlag(data)) {
      patterns.add('Bull Flag');
    }
    if (_detectBearFlag(data)) {
      patterns.add('Bear Flag');
    }

    // Candlestick patterns
    if (_detectHammer(data)) {
      patterns.add('Hammer');
    }
    if (_detectShootingStar(data)) {
      patterns.add('Shooting Star');
    }
    if (_detectEngulfing(data)) {
      patterns.add('Engulfing Pattern');
    }
    if (_detectDoji(data)) {
      patterns.add('Doji');
    }

    // Store patterns in Firebase
    if (patterns.isNotEmpty) {
      await _firebaseService.storePatternRecognition(symbol, patterns);
    }

    return patterns;
  }

  /// Calculate market sentiment
  double _calculateMarketSentiment(
    Map<String, dynamic> technicalAnalysis,
    Map<String, dynamic> multiTimeframeAnalysis,
    Map<String, dynamic> mlPrediction,
  ) {
    double sentiment = 0.0;
    int factors = 0;

    // Technical indicators sentiment
    final indicators = technicalAnalysis['indicators'] as Map<String, dynamic>;

    if (indicators['rsi_signal'] == 'buy') {
      sentiment += 1;
    } else if (indicators['rsi_signal'] == 'sell') {
      sentiment -= 1;
    }
    factors++;

    if (indicators['macd_signal'] == 'buy') {
      sentiment += 1;
    } else if (indicators['macd_signal'] == 'sell') {
      sentiment -= 1;
    }
    factors++;

    if (indicators['ema_signal'] == 'buy') {
      sentiment += 1;
    } else if (indicators['ema_signal'] == 'sell') {
      sentiment -= 1;
    }
    factors++;

    // Multi-timeframe consensus
    final consensus = multiTimeframeAnalysis['consensus'];
    if (consensus == 'bullish') {
      sentiment += 2;
    } else if (consensus == 'bearish') {
      sentiment -= 2;
    }
    factors += 2;

    // ML prediction
    final mlDirection = mlPrediction['direction'];
    final mlConfidence = mlPrediction['confidence'] as double;
    if (mlDirection == 'up') {
      sentiment += mlConfidence * 2;
    } else if (mlDirection == 'down') {
      sentiment -= mlConfidence * 2;
    }
    factors += 2;

    return sentiment / factors;
  }

  /// Identify key support and resistance levels
  Map<String, List<double>> _identifyKeyLevels(List<MarketData> data) {
    final supports = <double>[];
    final resistances = <double>[];

    // Use pivot points
    final pivots = _calculatePivotPoints(data);
    supports.addAll([pivots['S1']!, pivots['S2']!, pivots['S3']!]);
    resistances.addAll([pivots['R1']!, pivots['R2']!, pivots['R3']!]);

    // Identify local highs and lows
    for (int i = 10; i < data.length - 10; i++) {
      bool isLocalHigh = true;
      bool isLocalLow = true;

      for (int j = i - 10; j <= i + 10; j++) {
        if (j == i) continue;
        if (data[j].high > data[i].high) isLocalHigh = false;
        if (data[j].low < data[i].low) isLocalLow = false;
      }

      if (isLocalHigh) resistances.add(data[i].high);
      if (isLocalLow) supports.add(data[i].low);
    }

    // Sort and remove duplicates
    supports.sort();
    resistances.sort();

    return {
      'support': supports.take(5).toList(),
      'resistance': resistances.reversed.take(5).toList(),
    };
  }

  /// Analyze market volatility
  Map<String, dynamic> _analyzeVolatility(List<MarketData> data) {
    final atr = _technicalService.calculateATR(data, 14);
    final returns = <double>[];

    for (int i = 1; i < data.length; i++) {
      final ret = (data[i].close - data[i - 1].close) / data[i - 1].close;
      returns.add(ret);
    }

    final avgReturn = returns.reduce((a, b) => a + b) / returns.length;
    final variance =
        returns.map((r) => pow(r - avgReturn, 2)).reduce((a, b) => a + b) /
            returns.length;
    final stdDev = sqrt(variance);

    return {
      'atr': atr,
      'standardDeviation': stdDev,
      'volatilityLevel': _getVolatilityLevel(stdDev),
      'annualizedVolatility':
          stdDev * sqrt(252) * 100, // Assuming 252 trading days
    };
  }

  /// Determine market condition
  String _determineMarketCondition(
    Map<String, dynamic> technicalAnalysis,
    Map<String, dynamic> volatility,
    double sentiment,
  ) {
    final indicators = technicalAnalysis['indicators'] as Map<String, dynamic>;
    final adx = indicators['adx'] as double;
    final volatilityLevel = volatility['volatilityLevel'];

    if (adx > 25) {
      if (sentiment > 0.3) {
        return 'Strong Uptrend';
      } else if (sentiment < -0.3) {
        return 'Strong Downtrend';
      } else {
        return 'Trending';
      }
    } else if (volatilityLevel == 'high') {
      return 'Volatile Range';
    } else {
      return 'Ranging';
    }
  }

  /// Generate trading recommendation
  Map<String, dynamic> _generateRecommendation(
    Map<String, dynamic> technicalAnalysis,
    Map<String, dynamic> mlPrediction,
    double sentiment,
    List<String> patterns,
    String marketCondition,
  ) {
    String action = 'HOLD';
    double confidence = 0.0;
    final reasons = <String>[];

    // Determine action based on sentiment
    if (sentiment > 0.5) {
      action = 'BUY';
      confidence = sentiment;
      reasons.add('Strong bullish sentiment');
    } else if (sentiment < -0.5) {
      action = 'SELL';
      confidence = sentiment.abs();
      reasons.add('Strong bearish sentiment');
    }

    // ML prediction
    final mlDirection = mlPrediction['direction'];
    final mlConfidence = mlPrediction['confidence'] as double;

    if (mlConfidence > 0.8) {
      if (mlDirection == 'up' && action != 'SELL') {
        action = 'BUY';
        confidence = max(confidence, mlConfidence);
        reasons
            .add('High-confidence ML prediction: ${mlDirection.toUpperCase()}');
      } else if (mlDirection == 'down' && action != 'BUY') {
        action = 'SELL';
        confidence = max(confidence, mlConfidence);
        reasons
            .add('High-confidence ML prediction: ${mlDirection.toUpperCase()}');
      }
    }

    // Pattern confirmation
    if (patterns.isNotEmpty) {
      reasons.add('Patterns detected: ${patterns.join(", ")}');
      confidence = min(confidence + 0.1, 1.0);
    }

    // Market condition
    if (marketCondition.contains('Strong')) {
      reasons.add('Market condition: $marketCondition');
      confidence = min(confidence + 0.05, 1.0);
    }

    return {
      'action': action,
      'confidence': confidence,
      'reasons': reasons,
      'marketCondition': marketCondition,
    };
  }

  /// Calculate analysis confidence
  double _calculateAnalysisConfidence(
    Map<String, dynamic> technicalAnalysis,
    Map<String, dynamic> mlPrediction,
    Map<String, dynamic> multiTimeframeAnalysis,
    List<String> patterns,
  ) {
    double confidence = 0.0;
    int factors = 0;

    // ML prediction confidence
    confidence += mlPrediction['confidence'] as double;
    factors++;

    // Timeframe alignment
    final alignment = multiTimeframeAnalysis['alignment'] as double;
    confidence += alignment;
    factors++;

    // Pattern confirmation
    if (patterns.isNotEmpty) {
      confidence += 0.1 * patterns.length;
      factors++;
    }

    // Technical indicator agreement
    final indicators = technicalAnalysis['indicators'] as Map<String, dynamic>;
    int bullishSignals = 0;
    int bearishSignals = 0;
    int totalSignals = 0;

    if (indicators['rsi_signal'] == 'buy') bullishSignals++;
    if (indicators['rsi_signal'] == 'sell') bearishSignals++;
    totalSignals++;

    if (indicators['macd_signal'] == 'buy') bullishSignals++;
    if (indicators['macd_signal'] == 'sell') bearishSignals++;
    totalSignals++;

    if (indicators['ema_signal'] == 'buy') bullishSignals++;
    if (indicators['ema_signal'] == 'sell') bearishSignals++;
    totalSignals++;

    final signalAgreement = max(bullishSignals, bearishSignals) / totalSignals;
    confidence += signalAgreement;
    factors++;

    return (confidence / factors).clamp(0.0, 1.0);
  }

  // ==================== HELPER METHODS ====================

  String _getRSISignal(double rsi) {
    if (rsi < 30) return 'buy';
    if (rsi > 70) return 'sell';
    return 'neutral';
  }

  String _getMACDSignal(Map<String, double> macd) {
    final macdLine = macd['macdLine'] ?? 0;
    final signalLine = macd['signal'] ?? 0;

    if (macdLine > signalLine) return 'buy';
    if (macdLine < signalLine) return 'sell';
    return 'neutral';
  }

  String _getBollingerSignal(double price, Map<String, double> bollinger) {
    final upper = bollinger['upper'] ?? 0;
    final lower = bollinger['lower'] ?? 0;

    if (price < lower) return 'buy';
    if (price > upper) return 'sell';
    return 'neutral';
  }

  String _getEMASignal(
      double ema20, double ema50, double ema200, double price) {
    if (price > ema20 && ema20 > ema50 && ema50 > ema200) return 'buy';
    if (price < ema20 && ema20 < ema50 && ema50 < ema200) return 'sell';
    return 'neutral';
  }

  String _getTrendStrength(double adx) {
    if (adx < 20) return 'weak';
    if (adx < 40) return 'moderate';
    return 'strong';
  }

  String _getStochasticSignal(Map<String, double> stochastic) {
    final k = stochastic['k'] ?? 50;
    final d = stochastic['d'] ?? 50;

    if (k < 20 && k > d) return 'buy';
    if (k > 80 && k < d) return 'sell';
    return 'neutral';
  }

  String _determineTrend(double ema20, double ema50, double price) {
    if (price > ema20 && ema20 > ema50) return 'uptrend';
    if (price < ema20 && ema20 < ema50) return 'downtrend';
    return 'sideways';
  }

  double _calculateTimeframeAlignment(
      Map<String, Map<String, dynamic>> timeframeAnalysis) {
    int bullish = 0;
    int bearish = 0;

    for (final analysis in timeframeAnalysis.values) {
      if (analysis['trend'] == 'uptrend') bullish++;
      if (analysis['trend'] == 'downtrend') bearish++;
    }

    final alignment = max(bullish, bearish) / timeframeAnalysis.length;
    return alignment;
  }

  String _getTimeframeConsensus(
      Map<String, Map<String, dynamic>> timeframeAnalysis) {
    int bullish = 0;
    int bearish = 0;

    for (final analysis in timeframeAnalysis.values) {
      if (analysis['trend'] == 'uptrend') bullish++;
      if (analysis['trend'] == 'downtrend') bearish++;
    }

    if (bullish > bearish) return 'bullish';
    if (bearish > bullish) return 'bearish';
    return 'neutral';
  }

  String _getVolatilityLevel(double stdDev) {
    if (stdDev < 0.01) return 'low';
    if (stdDev < 0.02) return 'moderate';
    return 'high';
  }

  Map<String, double> _calculatePivotPoints(List<MarketData> data) {
    final lastBar = data.last;
    final pivot = (lastBar.high + lastBar.low + lastBar.close) / 3;

    return {
      'P': pivot,
      'R1': 2 * pivot - lastBar.low,
      'R2': pivot + (lastBar.high - lastBar.low),
      'R3': lastBar.high + 2 * (pivot - lastBar.low),
      'S1': 2 * pivot - lastBar.high,
      'S2': pivot - (lastBar.high - lastBar.low),
      'S3': lastBar.low - 2 * (lastBar.high - pivot),
    };
  }

  // Pattern detection methods (simplified implementations)
  bool _detectHeadAndShoulders(List<MarketData> data) {
    // Simplified implementation
    if (data.length < 50) return false;
    // Complex pattern detection logic would go here
    return false;
  }

  bool _detectDoubleTop(List<MarketData> data) {
    if (data.length < 30) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectDoubleBottom(List<MarketData> data) {
    if (data.length < 30) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectAscendingTriangle(List<MarketData> data) {
    if (data.length < 20) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectDescendingTriangle(List<MarketData> data) {
    if (data.length < 20) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectBullFlag(List<MarketData> data) {
    if (data.length < 15) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectBearFlag(List<MarketData> data) {
    if (data.length < 15) return false;
    // Pattern detection logic
    return false;
  }

  bool _detectHammer(List<MarketData> data) {
    if (data.isEmpty) return false;
    final lastCandle = data.last;
    final body = (lastCandle.close - lastCandle.open).abs();
    final lowerWick = min(lastCandle.open, lastCandle.close) - lastCandle.low;
    final upperWick = lastCandle.high - max(lastCandle.open, lastCandle.close);

    return lowerWick > body * 2 && upperWick < body * 0.3;
  }

  bool _detectShootingStar(List<MarketData> data) {
    if (data.isEmpty) return false;
    final lastCandle = data.last;
    final body = (lastCandle.close - lastCandle.open).abs();
    final lowerWick = min(lastCandle.open, lastCandle.close) - lastCandle.low;
    final upperWick = lastCandle.high - max(lastCandle.open, lastCandle.close);

    return upperWick > body * 2 && lowerWick < body * 0.3;
  }

  bool _detectEngulfing(List<MarketData> data) {
    if (data.length < 2) return false;
    final current = data.last;
    final previous = data[data.length - 2];

    // Bullish engulfing
    if (previous.close < previous.open && current.close > current.open) {
      return current.open < previous.close && current.close > previous.open;
    }

    // Bearish engulfing
    if (previous.close > previous.open && current.close < current.open) {
      return current.open > previous.close && current.close < previous.open;
    }

    return false;
  }

  bool _detectDoji(List<MarketData> data) {
    if (data.isEmpty) return false;
    final lastCandle = data.last;
    final body = (lastCandle.close - lastCandle.open).abs();
    final range = lastCandle.high - lastCandle.low;

    return body < range * 0.1;
  }
}

/// Result of market analysis
class MarketAnalysisResult {
  final String symbol;
  final DateTime timestamp;
  final TimeframeType primaryTimeframe;
  final double currentPrice;
  final Map<String, dynamic> technicalAnalysis;
  final Map<String, dynamic> multiTimeframeAnalysis;
  final Map<String, dynamic> mlPrediction;
  final List<String> patterns;
  final double sentiment;
  final Map<String, List<double>> keyLevels;
  final Map<String, dynamic> volatility;
  final String marketCondition;
  final Map<String, dynamic> recommendation;
  final double confidence;
  final Duration processingTime;

  MarketAnalysisResult({
    required this.symbol,
    required this.timestamp,
    required this.primaryTimeframe,
    required this.currentPrice,
    required this.technicalAnalysis,
    required this.multiTimeframeAnalysis,
    required this.mlPrediction,
    required this.patterns,
    required this.sentiment,
    required this.keyLevels,
    required this.volatility,
    required this.marketCondition,
    required this.recommendation,
    required this.confidence,
    required this.processingTime,
  });

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'timestamp': timestamp.toIso8601String(),
        'primaryTimeframe': primaryTimeframe.toString(),
        'currentPrice': currentPrice,
        'technicalAnalysis': technicalAnalysis,
        'multiTimeframeAnalysis': multiTimeframeAnalysis,
        'mlPrediction': mlPrediction,
        'patterns': patterns,
        'sentiment': sentiment,
        'keyLevels': keyLevels,
        'volatility': volatility,
        'marketCondition': marketCondition,
        'recommendation': recommendation,
        'confidence': confidence,
        'processingTimeMs': processingTime.inMilliseconds,
      };
}
