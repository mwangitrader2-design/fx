import 'package:freezed_annotation/freezed_annotation.dart';
import 'trade.dart';

part 'portfolio.freezed.dart';
part 'portfolio.g.dart';

@freezed
class Portfolio with _$Portfolio {
  const factory Portfolio({
    required String id,
    required double initialBalance,
    required double currentBalance,
    required double totalProfit,
    required double totalLoss,
    required double netProfit,
    required double profitPercentage,
    required int totalTrades,
    required int winningTrades,
    required int losingTrades,
    required double winRate,
    required List<Trade> openTrades,
    required List<Trade> closedTrades,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) double equity,
    @Default(0) double margin,
    @Default(0) double freeMargin,
    @Default(0) double marginLevel,
    @Default(0) double unrealizedPL,
  }) = _Portfolio;

  factory Portfolio.fromJson(Map<String, dynamic> json) =>
      _$PortfolioFromJson(json);
}

@freezed
class PortfolioPerformance with _$PortfolioPerformance {
  const factory PortfolioPerformance({
    required DateTime date,
    required double balance,
    required double equity,
    required double profit,
    required double drawdown,
    required int tradesCount,
  }) = _PortfolioPerformance;

  factory PortfolioPerformance.fromJson(Map<String, dynamic> json) =>
      _$PortfolioPerformanceFromJson(json);
}

@freezed
class PortfolioStats with _$PortfolioStats {
  const factory PortfolioStats({
    required double sharpeRatio,
    required double sortinoRatio,
    required double maxDrawdown,
    required double averageDrawdown,
    required double recoveryFactor,
    required double profitFactor,
    required double expectancy,
    required double averageWin,
    required double averageLoss,
    required double largestWin,
    required double largestLoss,
    required int consecutiveWins,
    required int consecutiveLosses,
    required Duration averageTradeDuration,
  }) = _PortfolioStats;

  factory PortfolioStats.fromJson(Map<String, dynamic> json) =>
      _$PortfolioStatsFromJson(json);
}
