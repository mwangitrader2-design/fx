import 'package:freezed_annotation/freezed_annotation.dart';
import 'signal.dart';

part 'trade.freezed.dart';
part 'trade.g.dart';

enum TradeStatus {
  pending,
  open,
  closed,
  cancelled
}

enum TradeResult {
  profit,
  loss,
  breakeven,
  pending
}

@freezed
class Trade with _$Trade {
  const factory Trade({
    required String id,
    required String symbol,
    required SignalType type,
    required TradeStatus status,
    required double entryPrice,
    required double lotSize,
    required double stopLoss,
    required double takeProfit,
    required DateTime openedAt,
    String? signalId,
    double? exitPrice,
    DateTime? closedAt,
    double? profitLoss,
    double? profitLossPercentage,
    TradeResult? result,
    String? closeReason,
    @Default(0) double currentPrice,
    @Default(0) double unrealizedPL,
  }) = _Trade;

  factory Trade.fromJson(Map<String, dynamic> json) => _$TradeFromJson(json);
}

@freezed
class TradeHistory with _$TradeHistory {
  const factory TradeHistory({
    required String id,
    required List<Trade> trades,
    required double totalProfit,
    required double totalLoss,
    required double netProfit,
    required int winningTrades,
    required int losingTrades,
    required double winRate,
    required double averageWin,
    required double averageLoss,
    required double profitFactor,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) = _TradeHistory;

  factory TradeHistory.fromJson(Map<String, dynamic> json) =>
      _$TradeHistoryFromJson(json);
}
