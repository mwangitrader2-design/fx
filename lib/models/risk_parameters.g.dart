// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RiskParametersImpl _$$RiskParametersImplFromJson(Map<String, dynamic> json) =>
    _$RiskParametersImpl(
      riskPercentage: (json['riskPercentage'] as num?)?.toDouble() ?? 2.0,
      riskRewardRatio: (json['riskRewardRatio'] as num?)?.toDouble() ?? 1.5,
      maxDailyLoss: (json['maxDailyLoss'] as num?)?.toDouble() ?? 5.0,
      maxOpenTrades: (json['maxOpenTrades'] as num?)?.toInt() ?? 3,
      maxDrawdownPercentage:
          (json['maxDrawdownPercentage'] as num?)?.toDouble() ?? 10.0,
      minLotSize: (json['minLotSize'] as num?)?.toDouble() ?? 0.01,
      maxLotSize: (json['maxLotSize'] as num?)?.toDouble() ?? 10.0,
      useTrailingStop: json['useTrailingStop'] as bool? ?? true,
      trailingStopDistance:
          (json['trailingStopDistance'] as num?)?.toInt() ?? 50,
      useBreakeven: json['useBreakeven'] as bool? ?? true,
      breakevenDistance: (json['breakevenDistance'] as num?)?.toInt() ?? 20,
      partialTakeProfit: json['partialTakeProfit'] as bool? ?? true,
      takeProfitLevels: (json['takeProfitLevels'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [0.5, 1.0, 2.0],
    );

Map<String, dynamic> _$$RiskParametersImplToJson(
        _$RiskParametersImpl instance) =>
    <String, dynamic>{
      'riskPercentage': instance.riskPercentage,
      'riskRewardRatio': instance.riskRewardRatio,
      'maxDailyLoss': instance.maxDailyLoss,
      'maxOpenTrades': instance.maxOpenTrades,
      'maxDrawdownPercentage': instance.maxDrawdownPercentage,
      'minLotSize': instance.minLotSize,
      'maxLotSize': instance.maxLotSize,
      'useTrailingStop': instance.useTrailingStop,
      'trailingStopDistance': instance.trailingStopDistance,
      'useBreakeven': instance.useBreakeven,
      'breakevenDistance': instance.breakevenDistance,
      'partialTakeProfit': instance.partialTakeProfit,
      'takeProfitLevels': instance.takeProfitLevels,
    };

_$RiskMetricsImpl _$$RiskMetricsImplFromJson(Map<String, dynamic> json) =>
    _$RiskMetricsImpl(
      currentRiskPercentage: (json['currentRiskPercentage'] as num).toDouble(),
      dailyLoss: (json['dailyLoss'] as num).toDouble(),
      currentDrawdown: (json['currentDrawdown'] as num).toDouble(),
      openTradesCount: (json['openTradesCount'] as num).toInt(),
      exposedMargin: (json['exposedMargin'] as num).toDouble(),
      canOpenNewTrade: json['canOpenNewTrade'] as bool,
      riskWarnings: (json['riskWarnings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      calculatedAt: DateTime.parse(json['calculatedAt'] as String),
    );

Map<String, dynamic> _$$RiskMetricsImplToJson(_$RiskMetricsImpl instance) =>
    <String, dynamic>{
      'currentRiskPercentage': instance.currentRiskPercentage,
      'dailyLoss': instance.dailyLoss,
      'currentDrawdown': instance.currentDrawdown,
      'openTradesCount': instance.openTradesCount,
      'exposedMargin': instance.exposedMargin,
      'canOpenNewTrade': instance.canOpenNewTrade,
      'riskWarnings': instance.riskWarnings,
      'calculatedAt': instance.calculatedAt.toIso8601String(),
    };
