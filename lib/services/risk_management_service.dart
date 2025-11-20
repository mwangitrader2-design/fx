import '../models/models.dart';

/// Service for managing risk parameters and calculations
class RiskManagementService {
  final RiskParameters _parameters;

  RiskManagementService({RiskParameters? parameters})
      : _parameters = parameters ?? const RiskParameters();

  /// Calculate position size based on risk parameters
  double calculatePositionSize({
    required double accountBalance,
    required double entryPrice,
    required double stopLoss,
    required String symbol,
  }) {
    final riskAmount = accountBalance * (_parameters.riskPercentage / 100);
    final stopLossDistance = (entryPrice - stopLoss).abs();
    
    if (stopLossDistance == 0) return _parameters.minLotSize;
    
    // Calculate lot size based on risk
    final lotSize = riskAmount / stopLossDistance;
    
    // Clamp to min/max lot size
    return lotSize.clamp(_parameters.minLotSize, _parameters.maxLotSize);
  }

  /// Check if a new trade can be opened based on risk rules
  Future<RiskMetrics> evaluateRiskMetrics({
    required Portfolio portfolio,
    required List<Trade> openTrades,
    double? proposedLotSize,
  }) async {
    final warnings = <String>[];
    
    // Calculate current drawdown
    final currentDrawdown = _calculateDrawdown(portfolio);
    
    // Calculate daily loss
    final dailyLoss = _calculateDailyLoss(portfolio);
    
    // Calculate exposed margin
    final exposedMargin = _calculateExposedMargin(openTrades);
    
    // Check if can open new trade
    bool canOpenNewTrade = true;
    
    // Check max open trades
    if (openTrades.length >= _parameters.maxOpenTrades) {
      canOpenNewTrade = false;
      warnings.add('Maximum open trades limit reached');
    }
    
    // Check max daily loss
    if (dailyLoss >= _parameters.maxDailyLoss) {
      canOpenNewTrade = false;
      warnings.add('Maximum daily loss limit reached');
    }
    
    // Check max drawdown
    if (currentDrawdown >= _parameters.maxDrawdownPercentage) {
      canOpenNewTrade = false;
      warnings.add('Maximum drawdown limit exceeded');
    }
    
    // Check margin level
    final marginLevel = _calculateMarginLevel(portfolio);
    if (marginLevel < 100) {
      canOpenNewTrade = false;
      warnings.add('Insufficient margin');
    }
    
    return RiskMetrics(
      currentRiskPercentage: _calculateCurrentRisk(portfolio, openTrades),
      dailyLoss: dailyLoss,
      currentDrawdown: currentDrawdown,
      openTradesCount: openTrades.length,
      exposedMargin: exposedMargin,
      canOpenNewTrade: canOpenNewTrade,
      riskWarnings: warnings,
      calculatedAt: DateTime.now(),
    );
  }

  /// Calculate dynamic stop loss with trailing
  double calculateTrailingStop({
    required Trade trade,
    required double currentPrice,
    required double atr,
  }) {
    if (!_parameters.useTrailingStop) {
      return trade.stopLoss;
    }

    final trailingDistance = atr * (_parameters.trailingStopDistance / 100);
    
    if (trade.type == SignalType.buy) {
      final newStopLoss = currentPrice - trailingDistance;
      // Only move stop loss up, never down
      return newStopLoss > trade.stopLoss ? newStopLoss : trade.stopLoss;
    } else {
      final newStopLoss = currentPrice + trailingDistance;
      // Only move stop loss down, never up
      return newStopLoss < trade.stopLoss ? newStopLoss : trade.stopLoss;
    }
  }

  /// Calculate breakeven level
  double? calculateBreakevenLevel(Trade trade, double atr) {
    if (!_parameters.useBreakeven) return null;

    final breakevenDistance = atr * (_parameters.breakevenDistance / 100);
    
    if (trade.type == SignalType.buy) {
      return trade.entryPrice + breakevenDistance;
    } else {
      return trade.entryPrice - breakevenDistance;
    }
  }

  /// Calculate partial take profit levels
  List<Map<String, double>> calculatePartialTakeProfits({
    required Trade trade,
    required double atr,
  }) {
    if (!_parameters.partialTakeProfit) return [];

    final levels = <Map<String, double>>[];
    
    for (final multiplier in _parameters.takeProfitLevels) {
      final distance = atr * multiplier;
      final price = trade.type == SignalType.buy
          ? trade.entryPrice + distance
          : trade.entryPrice - distance;
      
      levels.add({
        'price': price,
        'percentage': 1 / _parameters.takeProfitLevels.length, // Equal splits
      });
    }
    
    return levels;
  }

  /// Calculate risk/reward ratio for a trade
  double calculateRiskRewardRatio({
    required double entryPrice,
    required double stopLoss,
    required double takeProfit,
  }) {
    final risk = (entryPrice - stopLoss).abs();
    final reward = (takeProfit - entryPrice).abs();
    
    if (risk == 0) return 0;
    return reward / risk;
  }

  /// Validate if trade meets risk/reward criteria
  bool validateRiskReward({
    required double entryPrice,
    required double stopLoss,
    required double takeProfit,
  }) {
    final ratio = calculateRiskRewardRatio(
      entryPrice: entryPrice,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
    );
    
    return ratio >= _parameters.riskRewardRatio;
  }

  // Private helper methods

  double _calculateDrawdown(Portfolio portfolio) {
    if (portfolio.initialBalance == 0) return 0;
    
    final peak = portfolio.initialBalance + portfolio.totalProfit;
    final current = portfolio.currentBalance;
    
    if (current >= peak) return 0;
    
    return ((peak - current) / peak) * 100;
  }

  double _calculateDailyLoss(Portfolio portfolio) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);
    
    final todayTrades = portfolio.closedTrades.where((trade) {
      return trade.closedAt != null && 
             trade.closedAt!.isAfter(todayStart) &&
             trade.result == TradeResult.loss;
    });
    
    final totalLoss = todayTrades.fold<double>(
      0,
      (sum, trade) => sum + (trade.profitLoss?.abs() ?? 0),
    );
    
    return (totalLoss / portfolio.currentBalance) * 100;
  }

  double _calculateExposedMargin(List<Trade> openTrades) {
    return openTrades.fold<double>(
      0,
      (sum, trade) => sum + (trade.lotSize * trade.entryPrice),
    );
  }

  double _calculateMarginLevel(Portfolio portfolio) {
    if (portfolio.margin == 0) return 0;
    return (portfolio.equity / portfolio.margin) * 100;
  }

  double _calculateCurrentRisk(Portfolio portfolio, List<Trade> openTrades) {
    if (portfolio.currentBalance == 0) return 0;
    
    final totalRisk = openTrades.fold<double>(
      0,
      (sum, trade) {
        final risk = (trade.entryPrice - trade.stopLoss).abs() * trade.lotSize;
        return sum + risk;
      },
    );
    
    return (totalRisk / portfolio.currentBalance) * 100;
  }

  RiskParameters get parameters => _parameters;
}
