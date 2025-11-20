import 'package:uuid/uuid.dart';
import '../models/models.dart';
import 'risk_management_service.dart';

/// Service for executing trades automatically
class TradeExecutionService {
  final RiskManagementService _riskService;
  final _uuid = const Uuid();

  TradeExecutionService({RiskManagementService? riskService})
      : _riskService = riskService ?? RiskManagementService();

  /// Execute a trade based on a confirmed signal
  Future<Trade?> executeTrade({
    required TradingSignal signal,
    required Portfolio portfolio,
    required List<Trade> openTrades,
    required double currentPrice,
  }) async {
    // Check risk metrics
    final riskMetrics = await _riskService.evaluateRiskMetrics(
      portfolio: portfolio,
      openTrades: openTrades,
    );

    if (!riskMetrics.canOpenNewTrade) {
      return null; // Cannot open trade due to risk constraints
    }

    // Validate signal is confirmed
    if (signal.status != SignalStatus.confirmed) {
      return null;
    }

    // Validate risk/reward ratio
    if (!_riskService.validateRiskReward(
      entryPrice: signal.entryPrice,
      stopLoss: signal.stopLoss,
      takeProfit: signal.takeProfit,
    )) {
      return null; // Risk/reward not acceptable
    }

    // Calculate position size
    final lotSize = _riskService.calculatePositionSize(
      accountBalance: portfolio.currentBalance,
      entryPrice: signal.entryPrice,
      stopLoss: signal.stopLoss,
      symbol: signal.symbol,
    );

    // Create trade
    final trade = Trade(
      id: _uuid.v4(),
      symbol: signal.symbol,
      type: signal.type,
      status: TradeStatus.open,
      entryPrice: currentPrice,
      lotSize: lotSize,
      stopLoss: signal.stopLoss,
      takeProfit: signal.takeProfit,
      openedAt: DateTime.now(),
      signalId: signal.id,
      currentPrice: currentPrice,
    );

    return trade;
  }

  /// Monitor and manage open trades
  Future<List<Trade>> monitorTrades({
    required List<Trade> openTrades,
    required Map<String, double> currentPrices,
    required Map<String, double> atrValues,
  }) async {
    final updatedTrades = <Trade>[];

    for (final trade in openTrades) {
      final currentPrice = currentPrices[trade.symbol];
      final atr = atrValues[trade.symbol];
      
      if (currentPrice == null || atr == null) {
        updatedTrades.add(trade);
        continue;
      }

      // Update current price and unrealized P&L
      final unrealizedPL = _calculateUnrealizedPL(trade, currentPrice);
      var updatedTrade = trade.copyWith(
        currentPrice: currentPrice,
        unrealizedPL: unrealizedPL,
      );

      // Check for stop loss hit
      if (_isStopLossHit(trade, currentPrice)) {
        updatedTrade = _closeTrade(
          updatedTrade,
          currentPrice,
          'Stop loss hit',
        );
        updatedTrades.add(updatedTrade);
        continue;
      }

      // Check for take profit hit
      if (_isTakeProfitHit(trade, currentPrice)) {
        updatedTrade = _closeTrade(
          updatedTrade,
          currentPrice,
          'Take profit reached',
        );
        updatedTrades.add(updatedTrade);
        continue;
      }

      // Update trailing stop
      final newStopLoss = _riskService.calculateTrailingStop(
        trade: trade,
        currentPrice: currentPrice,
        atr: atr,
      );
      
      if (newStopLoss != trade.stopLoss) {
        updatedTrade = updatedTrade.copyWith(stopLoss: newStopLoss);
      }

      // Check for breakeven
      final breakevenLevel = _riskService.calculateBreakevenLevel(trade, atr);
      if (breakevenLevel != null && _shouldMoveToBreakeven(
        trade,
        currentPrice,
        breakevenLevel,
      )) {
        updatedTrade = updatedTrade.copyWith(stopLoss: trade.entryPrice);
      }

      updatedTrades.add(updatedTrade);
    }

    return updatedTrades;
  }

  /// Close a trade manually
  Trade closeTrade(Trade trade, double exitPrice, String reason) {
    return _closeTrade(trade, exitPrice, reason);
  }

  /// Calculate unrealized profit/loss
  double _calculateUnrealizedPL(Trade trade, double currentPrice) {
    final priceDiff = trade.type == SignalType.buy
        ? currentPrice - trade.entryPrice
        : trade.entryPrice - currentPrice;
    
    return priceDiff * trade.lotSize;
  }

  /// Check if stop loss is hit
  bool _isStopLossHit(Trade trade, double currentPrice) {
    if (trade.type == SignalType.buy) {
      return currentPrice <= trade.stopLoss;
    } else {
      return currentPrice >= trade.stopLoss;
    }
  }

  /// Check if take profit is hit
  bool _isTakeProfitHit(Trade trade, double currentPrice) {
    if (trade.type == SignalType.buy) {
      return currentPrice >= trade.takeProfit;
    } else {
      return currentPrice <= trade.takeProfit;
    }
  }

  /// Check if should move to breakeven
  bool _shouldMoveToBreakeven(
    Trade trade,
    double currentPrice,
    double breakevenLevel,
  ) {
    // Check if current stop loss is still at risk
    if (trade.stopLoss == trade.entryPrice) {
      return false; // Already at breakeven
    }

    if (trade.type == SignalType.buy) {
      return currentPrice >= breakevenLevel;
    } else {
      return currentPrice <= breakevenLevel;
    }
  }

  /// Close a trade and calculate final P&L
  Trade _closeTrade(Trade trade, double exitPrice, String reason) {
    final profitLoss = _calculateUnrealizedPL(trade, exitPrice);
    final profitLossPercentage = 
        (profitLoss / (trade.entryPrice * trade.lotSize)) * 100;
    
    TradeResult result;
    if (profitLoss > 0) {
      result = TradeResult.profit;
    } else if (profitLoss < 0) {
      result = TradeResult.loss;
    } else {
      result = TradeResult.breakeven;
    }

    return trade.copyWith(
      status: TradeStatus.closed,
      exitPrice: exitPrice,
      closedAt: DateTime.now(),
      profitLoss: profitLoss,
      profitLossPercentage: profitLossPercentage,
      result: result,
      closeReason: reason,
    );
  }
}
