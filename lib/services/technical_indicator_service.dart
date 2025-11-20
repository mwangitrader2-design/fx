import 'dart:math';
import '../models/models.dart';

/// Service for calculating technical indicators
class TechnicalIndicatorService {
  /// Calculate Simple Moving Average (SMA)
  double calculateSMA(List<double> prices, int period) {
    if (prices.length < period) return 0;
    
    final relevantPrices = prices.sublist(prices.length - period);
    return relevantPrices.reduce((a, b) => a + b) / period;
  }

  /// Calculate Exponential Moving Average (EMA)
  double calculateEMA(List<double> prices, int period) {
    if (prices.isEmpty) return 0;
    if (prices.length == 1) return prices[0];
    
    final multiplier = 2 / (period + 1);
    double ema = prices[0];
    
    for (int i = 1; i < prices.length; i++) {
      ema = (prices[i] * multiplier) + (ema * (1 - multiplier));
    }
    
    return ema;
  }

  /// Calculate Relative Strength Index (RSI)
  double calculateRSI(List<double> prices, int period) {
    if (prices.length < period + 1) return 50;
    
    List<double> gains = [];
    List<double> losses = [];
    
    for (int i = 1; i < prices.length; i++) {
      final change = prices[i] - prices[i - 1];
      if (change > 0) {
        gains.add(change);
        losses.add(0);
      } else {
        gains.add(0);
        losses.add(change.abs());
      }
    }
    
    final avgGain = gains.sublist(max(0, gains.length - period))
        .reduce((a, b) => a + b) / period;
    final avgLoss = losses.sublist(max(0, losses.length - period))
        .reduce((a, b) => a + b) / period;
    
    if (avgLoss == 0) return 100;
    
    final rs = avgGain / avgLoss;
    return 100 - (100 / (1 + rs));
  }

  /// Calculate MACD (Moving Average Convergence Divergence)
  Map<String, double> calculateMACD(
    List<double> prices, {
    int fastPeriod = 12,
    int slowPeriod = 26,
    int signalPeriod = 9,
  }) {
    final emaFast = calculateEMA(prices, fastPeriod);
    final emaSlow = calculateEMA(prices, slowPeriod);
    final macdLine = emaFast - emaSlow;
    
    // For simplicity, using SMA instead of EMA for signal line
    final macdSignal = macdLine; // Should be EMA of macdLine values
    final histogram = macdLine - macdSignal;
    
    return {
      'macdLine': macdLine,
      'signal': macdSignal,
      'histogram': histogram,
    };
  }

  /// Calculate Bollinger Bands
  Map<String, double> calculateBollingerBands(
    List<double> prices,
    int period,
    double standardDeviations,
  ) {
    if (prices.length < period) {
      return {'upper': 0, 'middle': 0, 'lower': 0};
    }
    
    final sma = calculateSMA(prices, period);
    final relevantPrices = prices.sublist(prices.length - period);
    
    // Calculate standard deviation
    final variance = relevantPrices
        .map((price) => pow(price - sma, 2))
        .reduce((a, b) => a + b) / period;
    final stdDev = sqrt(variance);
    
    return {
      'upper': sma + (stdDev * standardDeviations),
      'middle': sma,
      'lower': sma - (stdDev * standardDeviations),
    };
  }

  /// Calculate Stochastic Oscillator
  Map<String, double> calculateStochastic(
    List<MarketData> candles,
    int period,
  ) {
    if (candles.length < period) {
      return {'k': 50, 'd': 50};
    }
    
    final relevantCandles = candles.sublist(candles.length - period);
    final highestHigh = relevantCandles.map((c) => c.high).reduce(max);
    final lowestLow = relevantCandles.map((c) => c.low).reduce(min);
    final currentClose = candles.last.close;
    
    final k = ((currentClose - lowestLow) / (highestHigh - lowestLow)) * 100;
    final d = k; // Should be SMA of K values
    
    return {'k': k, 'd': d};
  }

  /// Calculate Average True Range (ATR)
  double calculateATR(List<MarketData> candles, int period) {
    if (candles.length < period + 1) return 0;
    
    List<double> trueRanges = [];
    
    for (int i = 1; i < candles.length; i++) {
      final high = candles[i].high;
      final low = candles[i].low;
      final prevClose = candles[i - 1].close;
      
      final tr = max(
        high - low,
        max((high - prevClose).abs(), (low - prevClose).abs()),
      );
      
      trueRanges.add(tr);
    }
    
    final relevantTRs = trueRanges.sublist(max(0, trueRanges.length - period));
    return relevantTRs.reduce((a, b) => a + b) / relevantTRs.length;
  }

  /// Calculate ADX (Average Directional Index)
  double calculateADX(List<MarketData> candles, int period) {
    if (candles.length < period + 1) return 0;
    
    // Simplified ADX calculation
    // In real implementation, this should calculate +DI, -DI, and DX properly
    final atr = calculateATR(candles, period);
    
    // Placeholder calculation - should be properly implemented
    return atr > 0 ? min(100, atr * 10) : 0;
  }

  /// Calculate CCI (Commodity Channel Index)
  double calculateCCI(List<MarketData> candles, int period) {
    if (candles.length < period) return 0;
    
    final relevantCandles = candles.sublist(candles.length - period);
    final typicalPrices = relevantCandles
        .map((c) => (c.high + c.low + c.close) / 3)
        .toList();
    
    final sma = typicalPrices.reduce((a, b) => a + b) / period;
    final meanDeviation = typicalPrices
        .map((tp) => (tp - sma).abs())
        .reduce((a, b) => a + b) / period;
    
    final currentTypicalPrice = 
        (candles.last.high + candles.last.low + candles.last.close) / 3;
    
    return meanDeviation != 0 
        ? (currentTypicalPrice - sma) / (0.015 * meanDeviation)
        : 0;
  }

  /// Generate comprehensive technical analysis
  TechnicalAnalysis generateTechnicalAnalysis(
    String symbol,
    List<MarketData> candles,
  ) {
    final closePrices = candles.map((c) => c.close).toList();
    
    // Calculate all indicators
    final sma20 = calculateSMA(closePrices, 20);
    final sma50 = calculateSMA(closePrices, 50);
    final sma200 = calculateSMA(closePrices, 200);
    final ema9 = calculateEMA(closePrices, 9);
    final ema21 = calculateEMA(closePrices, 21);
    final rsi = calculateRSI(closePrices, 14);
    final macd = calculateMACD(closePrices);
    final bollinger = calculateBollingerBands(closePrices, 20, 2);
    final stochastic = calculateStochastic(candles, 14);
    final atr = calculateATR(candles, 14);
    final adx = calculateADX(candles, 14);
    final cci = calculateCCI(candles, 20);
    
    final indicators = IndicatorValues(
      sma20: sma20,
      sma50: sma50,
      sma200: sma200,
      ema9: ema9,
      ema21: ema21,
      rsi: rsi,
      macdLine: macd['macdLine'],
      macdSignal: macd['signal'],
      macdHistogram: macd['histogram'],
      bollingerUpper: bollinger['upper'],
      bollingerMiddle: bollinger['middle'],
      bollingerLower: bollinger['lower'],
      stochasticK: stochastic['k'],
      stochasticD: stochastic['d'],
      atr: atr,
      adx: adx,
      cci: cci,
    );
    
    // Generate individual indicator signals
    final signals = <TechnicalIndicator>[];
    double bullishScore = 0;
    double bearishScore = 0;
    
    // RSI Signal
    if (rsi < 30) {
      signals.add(TechnicalIndicator(
        type: IndicatorType.rsi,
        name: 'RSI',
        value: rsi,
        signal: IndicatorSignal.oversold,
        calculatedAt: DateTime.now(),
        interpretation: 'Oversold - potential buying opportunity',
      ));
      bullishScore += 20;
    } else if (rsi > 70) {
      signals.add(TechnicalIndicator(
        type: IndicatorType.rsi,
        name: 'RSI',
        value: rsi,
        signal: IndicatorSignal.overbought,
        calculatedAt: DateTime.now(),
        interpretation: 'Overbought - potential selling opportunity',
      ));
      bearishScore += 20;
    }
    
    // Moving Average Signal
    final currentPrice = closePrices.last;
    if (currentPrice > sma20 && currentPrice > sma50) {
      bullishScore += 15;
    } else if (currentPrice < sma20 && currentPrice < sma50) {
      bearishScore += 15;
    }
    
    // MACD Signal
    if (macd['histogram']! > 0) {
      bullishScore += 15;
    } else {
      bearishScore += 15;
    }
    
    // Stochastic Signal
    if (stochastic['k']! < 20) {
      bullishScore += 10;
    } else if (stochastic['k']! > 80) {
      bearishScore += 10;
    }
    
    // Determine overall signal
    final totalScore = bullishScore + bearishScore;
    final bullishPercentage = totalScore > 0 ? bullishScore / totalScore : 0.5;
    
    IndicatorSignal overallSignal;
    String summary;
    
    if (bullishPercentage > 0.65) {
      overallSignal = IndicatorSignal.bullish;
      summary = 'Strong bullish signals detected. Multiple indicators suggest upward momentum.';
    } else if (bullishPercentage < 0.35) {
      overallSignal = IndicatorSignal.bearish;
      summary = 'Strong bearish signals detected. Multiple indicators suggest downward pressure.';
    } else {
      overallSignal = IndicatorSignal.neutral;
      summary = 'Mixed signals. Market is consolidating or showing indecision.';
    }
    
    return TechnicalAnalysis(
      symbol: symbol,
      analyzedAt: DateTime.now(),
      indicators: indicators,
      signals: signals,
      overallSignal: overallSignal,
      bullishScore: bullishScore,
      bearishScore: bearishScore,
      summary: summary,
    );
  }
}
