// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_indicator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TechnicalIndicatorImpl _$$TechnicalIndicatorImplFromJson(
        Map<String, dynamic> json) =>
    _$TechnicalIndicatorImpl(
      type: $enumDecode(_$IndicatorTypeEnumMap, json['type']),
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      signal: $enumDecode(_$IndicatorSignalEnumMap, json['signal']),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
      additionalData: json['additionalData'] as Map<String, dynamic>?,
      interpretation: json['interpretation'] as String?,
    );

Map<String, dynamic> _$$TechnicalIndicatorImplToJson(
        _$TechnicalIndicatorImpl instance) =>
    <String, dynamic>{
      'type': _$IndicatorTypeEnumMap[instance.type]!,
      'name': instance.name,
      'value': instance.value,
      'signal': _$IndicatorSignalEnumMap[instance.signal]!,
      'calculatedAt': instance.calculatedAt.toIso8601String(),
      'additionalData': instance.additionalData,
      'interpretation': instance.interpretation,
    };

const _$IndicatorTypeEnumMap = {
  IndicatorType.sma: 'sma',
  IndicatorType.ema: 'ema',
  IndicatorType.rsi: 'rsi',
  IndicatorType.macd: 'macd',
  IndicatorType.bollinger: 'bollinger',
  IndicatorType.stochastic: 'stochastic',
  IndicatorType.atr: 'atr',
  IndicatorType.adx: 'adx',
  IndicatorType.cci: 'cci',
  IndicatorType.fibonacci: 'fibonacci',
  IndicatorType.ichimoku: 'ichimoku',
  IndicatorType.parabolicSar: 'parabolicSar',
};

const _$IndicatorSignalEnumMap = {
  IndicatorSignal.bullish: 'bullish',
  IndicatorSignal.bearish: 'bearish',
  IndicatorSignal.neutral: 'neutral',
  IndicatorSignal.overbought: 'overbought',
  IndicatorSignal.oversold: 'oversold',
};

_$IndicatorValuesImpl _$$IndicatorValuesImplFromJson(
        Map<String, dynamic> json) =>
    _$IndicatorValuesImpl(
      sma20: (json['sma20'] as num?)?.toDouble(),
      sma50: (json['sma50'] as num?)?.toDouble(),
      sma200: (json['sma200'] as num?)?.toDouble(),
      ema9: (json['ema9'] as num?)?.toDouble(),
      ema21: (json['ema21'] as num?)?.toDouble(),
      ema50: (json['ema50'] as num?)?.toDouble(),
      rsi: (json['rsi'] as num?)?.toDouble(),
      macdLine: (json['macdLine'] as num?)?.toDouble(),
      macdSignal: (json['macdSignal'] as num?)?.toDouble(),
      macdHistogram: (json['macdHistogram'] as num?)?.toDouble(),
      bollingerUpper: (json['bollingerUpper'] as num?)?.toDouble(),
      bollingerMiddle: (json['bollingerMiddle'] as num?)?.toDouble(),
      bollingerLower: (json['bollingerLower'] as num?)?.toDouble(),
      stochasticK: (json['stochasticK'] as num?)?.toDouble(),
      stochasticD: (json['stochasticD'] as num?)?.toDouble(),
      atr: (json['atr'] as num?)?.toDouble(),
      adx: (json['adx'] as num?)?.toDouble(),
      cci: (json['cci'] as num?)?.toDouble(),
      parabolicSar: (json['parabolicSar'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$IndicatorValuesImplToJson(
        _$IndicatorValuesImpl instance) =>
    <String, dynamic>{
      'sma20': instance.sma20,
      'sma50': instance.sma50,
      'sma200': instance.sma200,
      'ema9': instance.ema9,
      'ema21': instance.ema21,
      'ema50': instance.ema50,
      'rsi': instance.rsi,
      'macdLine': instance.macdLine,
      'macdSignal': instance.macdSignal,
      'macdHistogram': instance.macdHistogram,
      'bollingerUpper': instance.bollingerUpper,
      'bollingerMiddle': instance.bollingerMiddle,
      'bollingerLower': instance.bollingerLower,
      'stochasticK': instance.stochasticK,
      'stochasticD': instance.stochasticD,
      'atr': instance.atr,
      'adx': instance.adx,
      'cci': instance.cci,
      'parabolicSar': instance.parabolicSar,
    };

_$TechnicalAnalysisImpl _$$TechnicalAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$TechnicalAnalysisImpl(
      symbol: json['symbol'] as String,
      analyzedAt: DateTime.parse(json['analyzedAt'] as String),
      indicators:
          IndicatorValues.fromJson(json['indicators'] as Map<String, dynamic>),
      signals: (json['signals'] as List<dynamic>)
          .map((e) => TechnicalIndicator.fromJson(e as Map<String, dynamic>))
          .toList(),
      overallSignal:
          $enumDecode(_$IndicatorSignalEnumMap, json['overallSignal']),
      bullishScore: (json['bullishScore'] as num).toDouble(),
      bearishScore: (json['bearishScore'] as num).toDouble(),
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$$TechnicalAnalysisImplToJson(
        _$TechnicalAnalysisImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'analyzedAt': instance.analyzedAt.toIso8601String(),
      'indicators': instance.indicators,
      'signals': instance.signals,
      'overallSignal': _$IndicatorSignalEnumMap[instance.overallSignal]!,
      'bullishScore': instance.bullishScore,
      'bearishScore': instance.bearishScore,
      'summary': instance.summary,
    };
