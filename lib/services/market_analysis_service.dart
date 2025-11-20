import '../models/models.dart';
import 'technical_indicator_service.dart';
import 'ml_prediction_service.dart';
import 'market_data_service.dart';

/// Service for comprehensive market analysis combining ML and technical indicators
class MarketAnalysisService {
  final TechnicalIndicatorService _technicalService;
  final MLPredictionService _mlService;
  final MarketDataService _marketDataService;

  MarketAnalysisService({
    TechnicalIndicatorService? technicalService,
    MLPredictionService? mlService,
    MarketDataService? marketDataService,
  })  : _technicalService = technicalService ?? TechnicalIndicatorService(),
        _mlService = mlService ?? MLPredictionService(),
        _marketDataService = marketDataService ?? MarketDataService();

  /// Perform comprehensive market analysis
  Future<Map<String, dynamic>> analyzeMarket({
    required String symbol,
    required TimeframeType primaryTimeframe,
    List<TimeframeType>? additionalTimeframes,
  }) async {
    // Define timeframes for multi-timeframe analysis
    final timeframes = additionalTimeframes ?? [
      TimeframeType.M15,
      TimeframeType.H1,
      TimeframeType.H4,
      TimeframeType.D1,
    ];

    // Fetch market data for all timeframes
    final marketData = await _marketDataService.getMultiTimeframeData(
      symbol: symbol,
      timeframes: timeframes,
    );

    // Perform technical analysis on primary timeframe
    final primaryData = marketData[primaryTimeframe]!;
    final technicalAnalysis = _technicalService.generateTechnicalAnalysis(
      symbol,
      primaryData,
    );

    // Perform ML-based prediction across timeframes
    final mlAnalysis = await _mlService.multiTimeframeAnalysis(
      symbol,
      marketData,
    );

    // Calculate market sentiment
    final sentiment = _calculateMarketSentiment(
      technicalAnalysis,
      mlAnalysis,
    );

    // Identify key levels
    final keyLevels = _identifyKeyLevels(primaryData);

    // Calculate market volatility
    final volatility = _calculateVolatility(primaryData);

    // Determine market condition
    final marketCondition = _determineMarketCondition(
      technicalAnalysis,
      volatility,
    );

    return {
      'symbol': symbol,
      'timestamp': DateTime.now(),
      'currentPrice': primaryData.last.close,
      'technicalAnalysis': technicalAnalysis,
      'mlAnalysis': mlAnalysis,
      'sentiment': sentiment,
      'keyLevels': keyLevels,
      'volatility': volatility,
      'marketCondition': marketCondition,
      'recommendation': _generateRecommendation(
        sentiment,
        mlAnalysis,
        technicalAnalysis,
      ),
    };
  }

  /// Analyze multiple symbols simultaneously
  Future<Map<String, Map<String, dynamic>>> analyzeMultipleMarkets({
    required List<String> symbols,
    required TimeframeType timeframe,
  }) async {
    final analyses = <String, Map<String, dynamic>>{};

    for (final symbol in symbols) {
      try {
        final analysis = await analyzeMarket(
          symbol: symbol,
          primaryTimeframe: timeframe,
        );
        analyses[symbol] = analysis;
      } catch (e) {
        // Skip symbols with errors
        continue;
      }
    }

    return analyses;
  }

  /// Calculate market sentiment
  Map<String, dynamic> _calculateMarketSentiment(
    TechnicalAnalysis technical,
    Map<String, dynamic> mlAnalysis,
  ) {
    final technicalSentiment = technical.overallSignal == IndicatorSignal.bullish
        ? 'bullish'
        : technical.overallSignal == IndicatorSignal.bearish
            ? 'bearish'
            : 'neutral';

    final mlSentiment = mlAnalysis['dominantDirection'] as String;
    
    // Combine sentiments
    String overallSentiment;
    if (technicalSentiment == 'bullish' && mlSentiment == 'up') {
      overallSentiment = 'strongly_bullish';
    } else if (technicalSentiment == 'bearish' && mlSentiment == 'down') {
      overallSentiment = 'strongly_bearish';
    } else if (technicalSentiment == 'bullish' || mlSentiment == 'up') {
      overallSentiment = 'moderately_bullish';
    } else if (technicalSentiment == 'bearish' || mlSentiment == 'down') {
      overallSentiment = 'moderately_bearish';
    } else {
      overallSentiment = 'neutral';
    }

    final sentimentScore = _calculateSentimentScore(
      technical.bullishScore,
      technical.bearishScore,
      mlAnalysis['overallConfidence'] as double,
    );

    return {
      'overall': overallSentiment,
      'technical': technicalSentiment,
      'ml': mlSentiment,
      'score': sentimentScore,
      'confidence': mlAnalysis['overallConfidence'],
    };
  }

  /// Calculate sentiment score (-1 to 1)
  double _calculateSentimentScore(
    double bullishScore,
    double bearishScore,
    double mlConfidence,
  ) {
    final technicalScore = (bullishScore - bearishScore) / 100;
    return technicalScore * mlConfidence;
  }

  /// Identify key support and resistance levels
  Map<String, List<double>> _identifyKeyLevels(List<MarketData> data) {
    final supports = <double>[];
    final resistances = <double>[];

    // Simple pivot point calculation
    if (data.length >= 3) {
      for (int i = 1; i < data.length - 1; i++) {
        final current = data[i];
        final prev = data[i - 1];
        final next = data[i + 1];

        // Check for swing low (support)
        if (current.low < prev.low && current.low < next.low) {
          supports.add(current.low);
        }

        // Check for swing high (resistance)
        if (current.high > prev.high && current.high > next.high) {
          resistances.add(current.high);
        }
      }
    }

    // Sort and get most significant levels
    supports.sort();
    resistances.sort((a, b) => b.compareTo(a));

    return {
      'supports': supports.take(3).toList(),
      'resistances': resistances.take(3).toList(),
    };
  }

  /// Calculate market volatility
  Map<String, dynamic> _calculateVolatility(List<MarketData> data) {
    if (data.isEmpty) {
      return {
        'level': 'unknown',
        'atr': 0.0,
        'percentageChange': 0.0,
      };
    }

    final closes = data.map((d) => d.close).toList();
    final atr = _technicalService.calculateATR(data, 14);
    
    // Calculate percentage change over period
    final percentageChange = closes.length >= 2
        ? ((closes.last - closes.first) / closes.first).abs() * 100
        : 0.0;

    String level;
    if (atr > closes.last * 0.01) {
      level = 'high';
    } else if (atr > closes.last * 0.005) {
      level = 'moderate';
    } else {
      level = 'low';
    }

    return {
      'level': level,
      'atr': atr,
      'percentageChange': percentageChange,
    };
  }

  /// Determine market condition (trending, ranging, etc.)
  String _determineMarketCondition(
    TechnicalAnalysis technical,
    Map<String, dynamic> volatility,
  ) {
    final adx = technical.indicators.adx ?? 0;
    final volatilityLevel = volatility['level'] as String;

    if (adx > 25 && volatilityLevel == 'high') {
      return 'strong_trend';
    } else if (adx > 20) {
      return 'trending';
    } else if (volatilityLevel == 'low') {
      return 'ranging';
    } else {
      return 'choppy';
    }
  }

  /// Generate trading recommendation
  Map<String, dynamic> _generateRecommendation(
    Map<String, dynamic> sentiment,
    Map<String, dynamic> mlAnalysis,
    TechnicalAnalysis technical,
  ) {
    final overallSentiment = sentiment['overall'] as String;
    final confidence = sentiment['confidence'] as double;
    final isAligned = mlAnalysis['isAligned'] as bool;

    String action;
    String reasoning;

    if (confidence > 0.95 && isAligned) {
      if (overallSentiment.contains('bullish')) {
        action = 'strong_buy';
        reasoning = 'High confidence bullish signal with timeframe alignment';
      } else if (overallSentiment.contains('bearish')) {
        action = 'strong_sell';
        reasoning = 'High confidence bearish signal with timeframe alignment';
      } else {
        action = 'hold';
        reasoning = 'Market is neutral, wait for clearer signal';
      }
    } else if (confidence > 0.85) {
      if (overallSentiment.contains('bullish')) {
        action = 'buy';
        reasoning = 'Moderate bullish signal detected';
      } else if (overallSentiment.contains('bearish')) {
        action = 'sell';
        reasoning = 'Moderate bearish signal detected';
      } else {
        action = 'hold';
        reasoning = 'Mixed signals, wait for confirmation';
      }
    } else {
      action = 'hold';
      reasoning = 'Insufficient confidence, wait for better setup';
    }

    return {
      'action': action,
      'reasoning': reasoning,
      'confidence': confidence,
      'isAligned': isAligned,
    };
  }
}
