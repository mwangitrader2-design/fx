import 'package:freezed_annotation/freezed_annotation.dart';

part 'technical_indicator.freezed.dart';
part 'technical_indicator.g.dart';

enum IndicatorType {
  sma,      // Simple Moving Average
  ema,      // Exponential Moving Average
  rsi,      // Relative Strength Index
  macd,     // Moving Average Convergence Divergence
  bollinger, // Bollinger Bands
  stochastic, // Stochastic Oscillator
  atr,      // Average True Range
  adx,      // Average Directional Index
  cci,      // Commodity Channel Index
  fibonacci, // Fibonacci Retracement
  ichimoku, // Ichimoku Cloud
  parabolicSar, // Parabolic SAR
}

enum IndicatorSignal {
  bullish,
  bearish,
  neutral,
  overbought,
  oversold
}

@freezed
class TechnicalIndicator with _$TechnicalIndicator {
  const factory TechnicalIndicator({
    required IndicatorType type,
    required String name,
    required double value,
    required IndicatorSignal signal,
    required DateTime calculatedAt,
    Map<String, dynamic>? additionalData,
    String? interpretation,
  }) = _TechnicalIndicator;

  factory TechnicalIndicator.fromJson(Map<String, dynamic> json) =>
      _$TechnicalIndicatorFromJson(json);
}

@freezed
class IndicatorValues with _$IndicatorValues {
  const factory IndicatorValues({
    // Moving Averages
    double? sma20,
    double? sma50,
    double? sma200,
    double? ema9,
    double? ema21,
    double? ema50,
    
    // RSI
    double? rsi,
    
    // MACD
    double? macdLine,
    double? macdSignal,
    double? macdHistogram,
    
    // Bollinger Bands
    double? bollingerUpper,
    double? bollingerMiddle,
    double? bollingerLower,
    
    // Stochastic
    double? stochasticK,
    double? stochasticD,
    
    // Others
    double? atr,
    double? adx,
    double? cci,
    double? parabolicSar,
  }) = _IndicatorValues;

  factory IndicatorValues.fromJson(Map<String, dynamic> json) =>
      _$IndicatorValuesFromJson(json);
}

@freezed
class TechnicalAnalysis with _$TechnicalAnalysis {
  const factory TechnicalAnalysis({
    required String symbol,
    required DateTime analyzedAt,
    required IndicatorValues indicators,
    required List<TechnicalIndicator> signals,
    required IndicatorSignal overallSignal,
    required double bullishScore,
    required double bearishScore,
    required String summary,
  }) = _TechnicalAnalysis;

  factory TechnicalAnalysis.fromJson(Map<String, dynamic> json) =>
      _$TechnicalAnalysisFromJson(json);
}
