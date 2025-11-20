// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeImpl _$$TradeImplFromJson(Map<String, dynamic> json) => _$TradeImpl(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      type: $enumDecode(_$SignalTypeEnumMap, json['type']),
      status: $enumDecode(_$TradeStatusEnumMap, json['status']),
      entryPrice: (json['entryPrice'] as num).toDouble(),
      lotSize: (json['lotSize'] as num).toDouble(),
      stopLoss: (json['stopLoss'] as num).toDouble(),
      takeProfit: (json['takeProfit'] as num).toDouble(),
      openedAt: DateTime.parse(json['openedAt'] as String),
      signalId: json['signalId'] as String?,
      exitPrice: (json['exitPrice'] as num?)?.toDouble(),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      profitLoss: (json['profitLoss'] as num?)?.toDouble(),
      profitLossPercentage: (json['profitLossPercentage'] as num?)?.toDouble(),
      result: $enumDecodeNullable(_$TradeResultEnumMap, json['result']),
      closeReason: json['closeReason'] as String?,
      currentPrice: (json['currentPrice'] as num?)?.toDouble() ?? 0,
      unrealizedPL: (json['unrealizedPL'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$TradeImplToJson(_$TradeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'type': _$SignalTypeEnumMap[instance.type]!,
      'status': _$TradeStatusEnumMap[instance.status]!,
      'entryPrice': instance.entryPrice,
      'lotSize': instance.lotSize,
      'stopLoss': instance.stopLoss,
      'takeProfit': instance.takeProfit,
      'openedAt': instance.openedAt.toIso8601String(),
      'signalId': instance.signalId,
      'exitPrice': instance.exitPrice,
      'closedAt': instance.closedAt?.toIso8601String(),
      'profitLoss': instance.profitLoss,
      'profitLossPercentage': instance.profitLossPercentage,
      'result': _$TradeResultEnumMap[instance.result],
      'closeReason': instance.closeReason,
      'currentPrice': instance.currentPrice,
      'unrealizedPL': instance.unrealizedPL,
    };

const _$SignalTypeEnumMap = {
  SignalType.buy: 'buy',
  SignalType.sell: 'sell',
  SignalType.hold: 'hold',
};

const _$TradeStatusEnumMap = {
  TradeStatus.pending: 'pending',
  TradeStatus.open: 'open',
  TradeStatus.closed: 'closed',
  TradeStatus.cancelled: 'cancelled',
};

const _$TradeResultEnumMap = {
  TradeResult.profit: 'profit',
  TradeResult.loss: 'loss',
  TradeResult.breakeven: 'breakeven',
  TradeResult.pending: 'pending',
};

_$TradeHistoryImpl _$$TradeHistoryImplFromJson(Map<String, dynamic> json) =>
    _$TradeHistoryImpl(
      id: json['id'] as String,
      trades: (json['trades'] as List<dynamic>)
          .map((e) => Trade.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalProfit: (json['totalProfit'] as num).toDouble(),
      totalLoss: (json['totalLoss'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
      winningTrades: (json['winningTrades'] as num).toInt(),
      losingTrades: (json['losingTrades'] as num).toInt(),
      winRate: (json['winRate'] as num).toDouble(),
      averageWin: (json['averageWin'] as num).toDouble(),
      averageLoss: (json['averageLoss'] as num).toDouble(),
      profitFactor: (json['profitFactor'] as num).toDouble(),
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
    );

Map<String, dynamic> _$$TradeHistoryImplToJson(_$TradeHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trades': instance.trades,
      'totalProfit': instance.totalProfit,
      'totalLoss': instance.totalLoss,
      'netProfit': instance.netProfit,
      'winningTrades': instance.winningTrades,
      'losingTrades': instance.losingTrades,
      'winRate': instance.winRate,
      'averageWin': instance.averageWin,
      'averageLoss': instance.averageLoss,
      'profitFactor': instance.profitFactor,
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
    };
