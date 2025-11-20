import 'dart:math';
import '../models/models.dart';

/// Service for AI/ML-based market prediction and analysis
class MLPredictionService {
  final Random _random = Random();

  /// Predict price movement using ML model (simplified implementation)
  /// In production, this would use TensorFlow Lite models
  Future<Map<String, dynamic>> predictPriceMovement(
    String symbol,
    List<MarketData> historicalData,
    TimeframeType timeframe,
  ) async {
    // Simulate ML processing time
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Feature extraction
    final features = _extractFeatures(historicalData);
    
    // Simulate ML model prediction
    // In production, this would use a trained TensorFlow Lite model
    final prediction = _simulateMLPrediction(features);
    
    return {
      'direction': prediction['direction'], // 'up', 'down', or 'sideways'
      'confidence': prediction['confidence'], // 0.0 to 1.0
      'predictedChange': prediction['predictedChange'], // percentage
      'priceTarget': prediction['priceTarget'],
      'timeHorizon': timeframe.minutes,
      'features': features,
    };
  }

  /// Extract features from historical data for ML model
  Map<String, double> _extractFeatures(List<MarketData> data) {
    if (data.isEmpty) return {};
    
    final closePrices = data.map((d) => d.close).toList();
    final volumes = data.map((d) => d.volume).toList();
    
    return {
      'price_momentum': _calculateMomentum(closePrices, 10),
      'volatility': _calculateVolatility(closePrices, 20),
      'volume_trend': _calculateVolumeTrend(volumes, 10),
      'price_velocity': _calculateVelocity(closePrices, 5),
      'acceleration': _calculateAcceleration(closePrices, 5),
      'support_strength': _calculateSupportStrength(data),
      'resistance_strength': _calculateResistanceStrength(data),
      'trend_strength': _calculateTrendStrength(closePrices, 20),
    };
  }

  /// Simulate ML model prediction
  Map<String, dynamic> _simulateMLPrediction(Map<String, double> features) {
    // This is a simplified simulation
    // In production, use actual ML model inference
    
    final momentum = features['price_momentum'] ?? 0;
    final trendStrength = features['trend_strength'] ?? 0;
    final volatility = features['volatility'] ?? 0;
    
    // Calculate direction probability
    final upProbability = (momentum + trendStrength + 1) / 2;
    final downProbability = 1 - upProbability;
    
    String direction;
    double confidence;
    
    if (upProbability > 0.6) {
      direction = 'up';
      confidence = upProbability;
    } else if (downProbability > 0.6) {
      direction = 'down';
      confidence = downProbability;
    } else {
      direction = 'sideways';
      confidence = 0.5;
    }
    
    // Add some randomness for simulation
    confidence = confidence * (0.85 + _random.nextDouble() * 0.15);
    
    final predictedChange = (momentum * 0.5 + trendStrength * 0.3) * volatility;
    final basePrice = features['price_velocity'] ?? 1.0;
    final priceTarget = basePrice * (1 + predictedChange / 100);
    
    return {
      'direction': direction,
      'confidence': confidence.clamp(0.0, 1.0),
      'predictedChange': predictedChange,
      'priceTarget': priceTarget,
    };
  }

  /// Calculate price momentum
  double _calculateMomentum(List<double> prices, int period) {
    if (prices.length < period) return 0;
    
    final recentPrices = prices.sublist(prices.length - period);
    final oldPrice = recentPrices.first;
    final currentPrice = recentPrices.last;
    
    return ((currentPrice - oldPrice) / oldPrice) * 100;
  }

  /// Calculate price volatility
  double _calculateVolatility(List<double> prices, int period) {
    if (prices.length < period) return 0;
    
    final recentPrices = prices.sublist(prices.length - period);
    final mean = recentPrices.reduce((a, b) => a + b) / period;
    
    final variance = recentPrices
        .map((price) => pow(price - mean, 2))
        .reduce((a, b) => a + b) / period;
    
    return sqrt(variance) / mean * 100; // Coefficient of variation
  }

  /// Calculate volume trend
  double _calculateVolumeTrend(List<double> volumes, int period) {
    if (volumes.length < period) return 0;
    
    final recentVolumes = volumes.sublist(volumes.length - period);
    final avgVolume = recentVolumes.reduce((a, b) => a + b) / period;
    final currentVolume = volumes.last;
    
    return ((currentVolume - avgVolume) / avgVolume) * 100;
  }

  /// Calculate price velocity (rate of change)
  double _calculateVelocity(List<double> prices, int period) {
    if (prices.length < period + 1) return 0;
    
    final changes = <double>[];
    for (int i = prices.length - period; i < prices.length; i++) {
      changes.add(prices[i] - prices[i - 1]);
    }
    
    return changes.reduce((a, b) => a + b) / period;
  }

  /// Calculate price acceleration
  double _calculateAcceleration(List<double> prices, int period) {
    if (prices.length < period + 2) return 0;
    
    final velocity1 = _calculateVelocity(
      prices.sublist(0, prices.length - period ~/ 2),
      period ~/ 2,
    );
    final velocity2 = _calculateVelocity(prices, period ~/ 2);
    
    return velocity2 - velocity1;
  }

  /// Calculate support level strength
  double _calculateSupportStrength(List<MarketData> data) {
    if (data.length < 20) return 0;
    
    final lows = data.map((d) => d.low).toList();
    final recentLows = lows.sublist(lows.length - 20);
    final minLow = recentLows.reduce(min);
    
    // Count how many times price touched near support
    int touches = 0;
    for (final low in recentLows) {
      if ((low - minLow).abs() / minLow < 0.002) {
        touches++;
      }
    }
    
    return touches / 20; // Normalized strength
  }

  /// Calculate resistance level strength
  double _calculateResistanceStrength(List<MarketData> data) {
    if (data.length < 20) return 0;
    
    final highs = data.map((d) => d.high).toList();
    final recentHighs = highs.sublist(highs.length - 20);
    final maxHigh = recentHighs.reduce(max);
    
    // Count how many times price touched near resistance
    int touches = 0;
    for (final high in recentHighs) {
      if ((maxHigh - high).abs() / maxHigh < 0.002) {
        touches++;
      }
    }
    
    return touches / 20; // Normalized strength
  }

  /// Calculate trend strength
  double _calculateTrendStrength(List<double> prices, int period) {
    if (prices.length < period) return 0;
    
    final recentPrices = prices.sublist(prices.length - period);
    
    // Simple linear regression to determine trend
    double sumX = 0, sumY = 0, sumXY = 0, sumXX = 0;
    
    for (int i = 0; i < recentPrices.length; i++) {
      sumX += i;
      sumY += recentPrices[i];
      sumXY += i * recentPrices[i];
      sumXX += i * i;
    }
    
    final n = recentPrices.length;
    final slope = (n * sumXY - sumX * sumY) / (n * sumXX - sumX * sumX);
    final avgPrice = sumY / n;
    
    return (slope / avgPrice) * 100; // Normalized trend strength
  }

  /// Perform multi-timeframe analysis
  Future<Map<String, dynamic>> multiTimeframeAnalysis(
    String symbol,
    Map<TimeframeType, List<MarketData>> timeframeData,
  ) async {
    final predictions = <TimeframeType, Map<String, dynamic>>{};
    
    for (final entry in timeframeData.entries) {
      final prediction = await predictPriceMovement(
        symbol,
        entry.value,
        entry.key,
      );
      predictions[entry.key] = prediction;
    }
    
    // Calculate alignment across timeframes
    final alignmentScore = _calculateTimeframeAlignment(predictions);
    
    return {
      'predictions': predictions,
      'alignmentScore': alignmentScore,
      'isAligned': alignmentScore > 0.7,
      'dominantDirection': _getDominantDirection(predictions),
      'overallConfidence': _calculateOverallConfidence(predictions),
    };
  }

  /// Calculate how well timeframes align
  double _calculateTimeframeAlignment(
    Map<TimeframeType, Map<String, dynamic>> predictions,
  ) {
    if (predictions.isEmpty) return 0;
    
    final directions = predictions.values.map((p) => p['direction']).toList();
    final mostCommon = _findMostCommon(directions);
    final alignedCount = directions.where((d) => d == mostCommon).length;
    
    return alignedCount / directions.length;
  }

  /// Get dominant direction across timeframes
  String _getDominantDirection(
    Map<TimeframeType, Map<String, dynamic>> predictions,
  ) {
    final directions = predictions.values.map((p) => p['direction']).toList();
    return _findMostCommon(directions);
  }

  /// Calculate overall confidence from multiple predictions
  double _calculateOverallConfidence(
    Map<TimeframeType, Map<String, dynamic>> predictions,
  ) {
    if (predictions.isEmpty) return 0;
    
    final confidences = predictions.values
        .map((p) => (p['confidence'] as double))
        .toList();
    
    return confidences.reduce((a, b) => a + b) / confidences.length;
  }

  /// Find most common element in list
  T _findMostCommon<T>(List<T> items) {
    final counts = <T, int>{};
    for (final item in items) {
      counts[item] = (counts[item] ?? 0) + 1;
    }
    
    return counts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}
