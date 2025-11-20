import 'package:uuid/uuid.dart';
import '../models/models.dart';

/// Service for managing portfolio and calculating performance
class PortfolioService {
  final _uuid = const Uuid();

  /// Create a new portfolio
  Portfolio createPortfolio(double initialBalance) {
    final now = DateTime.now();
    return Portfolio(
      id: _uuid.v4(),
      initialBalance: initialBalance,
      currentBalance: initialBalance,
      totalProfit: 0,
      totalLoss: 0,
      netProfit: 0,
      profitPercentage: 0,
      totalTrades: 0,
      winningTrades: 0,
      losingTrades: 0,
      winRate: 0,
      openTrades: [],
      closedTrades: [],
      createdAt: now,
      updatedAt: now,
      equity: initialBalance,
      freeMargin: initialBalance,
    );
  }

  /// Update portfolio with new trade
  Portfolio updateWithNewTrade(Portfolio portfolio, Trade trade) {
    if (trade.status != TradeStatus.open) {
      return portfolio;
    }

    final updatedOpenTrades = [...portfolio.openTrades, trade];
    final exposedMargin = _calculateExposedMargin(updatedOpenTrades);
    final equity = portfolio.currentBalance + 
                   _calculateTotalUnrealizedPL(updatedOpenTrades);

    return portfolio.copyWith(
      openTrades: updatedOpenTrades,
      margin: exposedMargin,
      equity: equity,
      freeMargin: equity - exposedMargin,
      marginLevel: exposedMargin > 0 ? (equity / exposedMargin) * 100 : 0,
      updatedAt: DateTime.now(),
    );
  }

  /// Update portfolio with closed trade
  Portfolio updateWithClosedTrade(Portfolio portfolio, Trade trade) {
    if (trade.status != TradeStatus.closed || trade.profitLoss == null) {
      return portfolio;
    }

    // Remove from open trades
    final updatedOpenTrades = portfolio.openTrades
        .where((t) => t.id != trade.id)
        .toList();

    // Add to closed trades
    final updatedClosedTrades = [...portfolio.closedTrades, trade];

    // Update balance
    final newBalance = portfolio.currentBalance + trade.profitLoss!;

    // Update statistics
    final isWin = trade.result == TradeResult.profit;
    final isLoss = trade.result == TradeResult.loss;

    final newTotalProfit = portfolio.totalProfit + 
                          (isWin ? trade.profitLoss! : 0);
    final newTotalLoss = portfolio.totalLoss + 
                        (isLoss ? trade.profitLoss!.abs() : 0);
    final newNetProfit = newTotalProfit - newTotalLoss;
    final newWinningTrades = portfolio.winningTrades + (isWin ? 1 : 0);
    final newLosingTrades = portfolio.losingTrades + (isLoss ? 1 : 0);
    final newTotalTrades = portfolio.totalTrades + 1;
    final newWinRate = newTotalTrades > 0 
        ? (newWinningTrades / newTotalTrades) * 100 
        : 0;

    final profitPercentage = 
        ((newBalance - portfolio.initialBalance) / portfolio.initialBalance) * 100;

    final exposedMargin = _calculateExposedMargin(updatedOpenTrades);
    final unrealizedPL = _calculateTotalUnrealizedPL(updatedOpenTrades);
    final equity = newBalance + unrealizedPL;

    return portfolio.copyWith(
      currentBalance: newBalance,
      totalProfit: newTotalProfit,
      totalLoss: newTotalLoss,
      netProfit: newNetProfit,
      profitPercentage: profitPercentage,
      totalTrades: newTotalTrades,
      winningTrades: newWinningTrades,
      losingTrades: newLosingTrades,
      winRate: newWinRate,
      openTrades: updatedOpenTrades,
      closedTrades: updatedClosedTrades,
      equity: equity,
      margin: exposedMargin,
      freeMargin: equity - exposedMargin,
      marginLevel: exposedMargin > 0 ? (equity / exposedMargin) * 100 : 0,
      unrealizedPL: unrealizedPL,
      updatedAt: DateTime.now(),
    );
  }

  /// Update portfolio with current market prices
  Portfolio updateWithMarketPrices(
    Portfolio portfolio,
    Map<String, double> currentPrices,
  ) {
    final updatedOpenTrades = portfolio.openTrades.map((trade) {
      final currentPrice = currentPrices[trade.symbol];
      if (currentPrice == null) return trade;

      final unrealizedPL = _calculateUnrealizedPL(trade, currentPrice);
      return trade.copyWith(
        currentPrice: currentPrice,
        unrealizedPL: unrealizedPL,
      );
    }).toList();

    final totalUnrealizedPL = _calculateTotalUnrealizedPL(updatedOpenTrades);
    final equity = portfolio.currentBalance + totalUnrealizedPL;
    final exposedMargin = _calculateExposedMargin(updatedOpenTrades);

    return portfolio.copyWith(
      openTrades: updatedOpenTrades,
      equity: equity,
      unrealizedPL: totalUnrealizedPL,
      freeMargin: equity - exposedMargin,
      marginLevel: exposedMargin > 0 ? (equity / exposedMargin) * 100 : 0,
      updatedAt: DateTime.now(),
    );
  }

  /// Calculate portfolio statistics
  PortfolioStats calculateStats(Portfolio portfolio) {
    if (portfolio.closedTrades.isEmpty) {
      return PortfolioStats(
        sharpeRatio: 0,
        sortinoRatio: 0,
        maxDrawdown: 0,
        averageDrawdown: 0,
        recoveryFactor: 0,
        profitFactor: 0,
        expectancy: 0,
        averageWin: 0,
        averageLoss: 0,
        largestWin: 0,
        largestLoss: 0,
        consecutiveWins: 0,
        consecutiveLosses: 0,
        averageTradeDuration: Duration.zero,
      );
    }

    final winningTrades = portfolio.closedTrades
        .where((t) => t.result == TradeResult.profit)
        .toList();
    final losingTrades = portfolio.closedTrades
        .where((t) => t.result == TradeResult.loss)
        .toList();

    final averageWin = winningTrades.isNotEmpty
        ? winningTrades.map((t) => t.profitLoss!).reduce((a, b) => a + b) / 
          winningTrades.length
        : 0.0;

    final averageLoss = losingTrades.isNotEmpty
        ? losingTrades.map((t) => t.profitLoss!.abs()).reduce((a, b) => a + b) / 
          losingTrades.length
        : 0.0;

    final largestWin = winningTrades.isNotEmpty
        ? winningTrades.map((t) => t.profitLoss!).reduce((a, b) => a > b ? a : b)
        : 0.0;

    final largestLoss = losingTrades.isNotEmpty
        ? losingTrades.map((t) => t.profitLoss!.abs()).reduce((a, b) => a > b ? a : b)
        : 0.0;

    final profitFactor = averageLoss > 0 
        ? portfolio.totalProfit / portfolio.totalLoss 
        : 0.0;

    final expectancy = portfolio.totalTrades > 0
        ? portfolio.netProfit / portfolio.totalTrades
        : 0.0;

    final durations = portfolio.closedTrades
        .where((t) => t.closedAt != null)
        .map((t) => t.closedAt!.difference(t.openedAt))
        .toList();
    
    final averageDuration = durations.isNotEmpty
        ? Duration(
            milliseconds: durations
                .map((d) => d.inMilliseconds)
                .reduce((a, b) => a + b) ~/
                durations.length,
          )
        : Duration.zero;

    final consecutiveWins = _calculateMaxConsecutive(
      portfolio.closedTrades,
      TradeResult.profit,
    );
    
    final consecutiveLosses = _calculateMaxConsecutive(
      portfolio.closedTrades,
      TradeResult.loss,
    );

    return PortfolioStats(
      sharpeRatio: _calculateSharpeRatio(portfolio),
      sortinoRatio: _calculateSortinoRatio(portfolio),
      maxDrawdown: _calculateMaxDrawdown(portfolio),
      averageDrawdown: 0, // Would need historical data
      recoveryFactor: 0,  // Would need historical data
      profitFactor: profitFactor,
      expectancy: expectancy,
      averageWin: averageWin,
      averageLoss: averageLoss,
      largestWin: largestWin,
      largestLoss: largestLoss,
      consecutiveWins: consecutiveWins,
      consecutiveLosses: consecutiveLosses,
      averageTradeDuration: averageDuration,
    );
  }

  // Private helper methods

  double _calculateExposedMargin(List<Trade> openTrades) {
    return openTrades.fold<double>(
      0,
      (sum, trade) => sum + (trade.lotSize * trade.entryPrice * 0.01), // 1% margin
    );
  }

  double _calculateTotalUnrealizedPL(List<Trade> openTrades) {
    return openTrades.fold<double>(
      0,
      (sum, trade) => sum + trade.unrealizedPL,
    );
  }

  double _calculateUnrealizedPL(Trade trade, double currentPrice) {
    final priceDiff = trade.type == SignalType.buy
        ? currentPrice - trade.entryPrice
        : trade.entryPrice - currentPrice;
    
    return priceDiff * trade.lotSize;
  }

  double _calculateSharpeRatio(Portfolio portfolio) {
    if (portfolio.closedTrades.isEmpty) return 0;
    
    final returns = portfolio.closedTrades
        .map((t) => t.profitLossPercentage ?? 0)
        .toList();
    
    final avgReturn = returns.reduce((a, b) => a + b) / returns.length;
    // Simplified calculation - would need risk-free rate and proper std dev
    return avgReturn / 10; // Placeholder
  }

  double _calculateSortinoRatio(Portfolio portfolio) {
    // Similar to Sharpe but only considers downside deviation
    return _calculateSharpeRatio(portfolio) * 1.2; // Placeholder
  }

  double _calculateMaxDrawdown(Portfolio portfolio) {
    if (portfolio.closedTrades.isEmpty) return 0;
    
    double peak = portfolio.initialBalance;
    double maxDrawdown = 0;
    double current = portfolio.initialBalance;
    
    for (final trade in portfolio.closedTrades) {
      current += trade.profitLoss ?? 0;
      if (current > peak) {
        peak = current;
      }
      final drawdown = ((peak - current) / peak) * 100;
      if (drawdown > maxDrawdown) {
        maxDrawdown = drawdown;
      }
    }
    
    return maxDrawdown;
  }

  int _calculateMaxConsecutive(List<Trade> trades, TradeResult result) {
    int maxConsecutive = 0;
    int currentConsecutive = 0;
    
    for (final trade in trades) {
      if (trade.result == result) {
        currentConsecutive++;
        if (currentConsecutive > maxConsecutive) {
          maxConsecutive = currentConsecutive;
        }
      } else {
        currentConsecutive = 0;
      }
    }
    
    return maxConsecutive;
  }
}
