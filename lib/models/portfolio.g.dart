// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioImpl _$$PortfolioImplFromJson(Map<String, dynamic> json) =>
    _$PortfolioImpl(
      id: json['id'] as String,
      initialBalance: (json['initialBalance'] as num).toDouble(),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      totalProfit: (json['totalProfit'] as num).toDouble(),
      totalLoss: (json['totalLoss'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
      profitPercentage: (json['profitPercentage'] as num).toDouble(),
      totalTrades: (json['totalTrades'] as num).toInt(),
      winningTrades: (json['winningTrades'] as num).toInt(),
      losingTrades: (json['losingTrades'] as num).toInt(),
      winRate: (json['winRate'] as num).toDouble(),
      openTrades: (json['openTrades'] as List<dynamic>)
          .map((e) => Trade.fromJson(e as Map<String, dynamic>))
          .toList(),
      closedTrades: (json['closedTrades'] as List<dynamic>)
          .map((e) => Trade.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      equity: (json['equity'] as num?)?.toDouble() ?? 0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0,
      freeMargin: (json['freeMargin'] as num?)?.toDouble() ?? 0,
      marginLevel: (json['marginLevel'] as num?)?.toDouble() ?? 0,
      unrealizedPL: (json['unrealizedPL'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$PortfolioImplToJson(_$PortfolioImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'initialBalance': instance.initialBalance,
      'currentBalance': instance.currentBalance,
      'totalProfit': instance.totalProfit,
      'totalLoss': instance.totalLoss,
      'netProfit': instance.netProfit,
      'profitPercentage': instance.profitPercentage,
      'totalTrades': instance.totalTrades,
      'winningTrades': instance.winningTrades,
      'losingTrades': instance.losingTrades,
      'winRate': instance.winRate,
      'openTrades': instance.openTrades,
      'closedTrades': instance.closedTrades,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'equity': instance.equity,
      'margin': instance.margin,
      'freeMargin': instance.freeMargin,
      'marginLevel': instance.marginLevel,
      'unrealizedPL': instance.unrealizedPL,
    };

_$PortfolioPerformanceImpl _$$PortfolioPerformanceImplFromJson(
        Map<String, dynamic> json) =>
    _$PortfolioPerformanceImpl(
      date: DateTime.parse(json['date'] as String),
      balance: (json['balance'] as num).toDouble(),
      equity: (json['equity'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      drawdown: (json['drawdown'] as num).toDouble(),
      tradesCount: (json['tradesCount'] as num).toInt(),
    );

Map<String, dynamic> _$$PortfolioPerformanceImplToJson(
        _$PortfolioPerformanceImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'balance': instance.balance,
      'equity': instance.equity,
      'profit': instance.profit,
      'drawdown': instance.drawdown,
      'tradesCount': instance.tradesCount,
    };

_$PortfolioStatsImpl _$$PortfolioStatsImplFromJson(Map<String, dynamic> json) =>
    _$PortfolioStatsImpl(
      sharpeRatio: (json['sharpeRatio'] as num).toDouble(),
      sortinoRatio: (json['sortinoRatio'] as num).toDouble(),
      maxDrawdown: (json['maxDrawdown'] as num).toDouble(),
      averageDrawdown: (json['averageDrawdown'] as num).toDouble(),
      recoveryFactor: (json['recoveryFactor'] as num).toDouble(),
      profitFactor: (json['profitFactor'] as num).toDouble(),
      expectancy: (json['expectancy'] as num).toDouble(),
      averageWin: (json['averageWin'] as num).toDouble(),
      averageLoss: (json['averageLoss'] as num).toDouble(),
      largestWin: (json['largestWin'] as num).toDouble(),
      largestLoss: (json['largestLoss'] as num).toDouble(),
      consecutiveWins: (json['consecutiveWins'] as num).toInt(),
      consecutiveLosses: (json['consecutiveLosses'] as num).toInt(),
      averageTradeDuration:
          Duration(microseconds: (json['averageTradeDuration'] as num).toInt()),
    );

Map<String, dynamic> _$$PortfolioStatsImplToJson(
        _$PortfolioStatsImpl instance) =>
    <String, dynamic>{
      'sharpeRatio': instance.sharpeRatio,
      'sortinoRatio': instance.sortinoRatio,
      'maxDrawdown': instance.maxDrawdown,
      'averageDrawdown': instance.averageDrawdown,
      'recoveryFactor': instance.recoveryFactor,
      'profitFactor': instance.profitFactor,
      'expectancy': instance.expectancy,
      'averageWin': instance.averageWin,
      'averageLoss': instance.averageLoss,
      'largestWin': instance.largestWin,
      'largestLoss': instance.largestLoss,
      'consecutiveWins': instance.consecutiveWins,
      'consecutiveLosses': instance.consecutiveLosses,
      'averageTradeDuration': instance.averageTradeDuration.inMicroseconds,
    };
