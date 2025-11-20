import 'package:freezed_annotation/freezed_annotation.dart';

part 'risk_parameters.freezed.dart';
part 'risk_parameters.g.dart';

@freezed
class RiskParameters with _$RiskParameters {
  const factory RiskParameters({
    @Default(2.0) double riskPercentage,
    @Default(1.5) double riskRewardRatio,
    @Default(5.0) double maxDailyLoss,
    @Default(3) int maxOpenTrades,
    @Default(10.0) double maxDrawdownPercentage,
    @Default(0.01) double minLotSize,
    @Default(10.0) double maxLotSize,
    @Default(true) bool useTrailingStop,
    @Default(50) int trailingStopDistance,
    @Default(true) bool useBreakeven,
    @Default(20) int breakevenDistance,
    @Default(true) bool partialTakeProfit,
    @Default([0.5, 1.0, 2.0]) List<double> takeProfitLevels,
  }) = _RiskParameters;

  factory RiskParameters.fromJson(Map<String, dynamic> json) =>
      _$RiskParametersFromJson(json);
}

@freezed
class RiskMetrics with _$RiskMetrics {
  const factory RiskMetrics({
    required double currentRiskPercentage,
    required double dailyLoss,
    required double currentDrawdown,
    required int openTradesCount,
    required double exposedMargin,
    required bool canOpenNewTrade,
    required List<String> riskWarnings,
    required DateTime calculatedAt,
  }) = _RiskMetrics;

  factory RiskMetrics.fromJson(Map<String, dynamic> json) =>
      _$RiskMetricsFromJson(json);
}
