import 'dart:math';
import '../models/models.dart';
import 'firebase_service.dart';
import 'enhanced_risk_manager.dart';

/// AI-powered portfolio manager for steady growth
class AIPortfolioManager {
  final FirebaseService _firebaseService;
  final EnhancedRiskManager _riskManager;

  // Portfolio targets
  static const double TARGET_MONTHLY_GROWTH = 5.0; // 5% per month
  static const double TARGET_ANNUAL_GROWTH = 60.0; // 60% per year (compounded)
  static const double MAX_MONTHLY_DRAWDOWN = 10.0; // 10% max monthly drawdown
  static const double IDEAL_WIN_RATE = 0.65; // 65% win rate target

  AIPortfolioManager({
    FirebaseService? firebaseService,
    EnhancedRiskManager? riskManager,
  })  : _firebaseService = firebaseService ?? FirebaseService(),
        _riskManager = riskManager ?? EnhancedRiskManager();

  /// Optimize portfolio for steady growth
  Future<PortfolioOptimization> optimizePortfolio({
    required Portfolio currentPortfolio,
    required List<Trade> tradeHistory,
    required List<Trade> openTrades,
  }) async {
    try {
      // 1. Analyze current portfolio health
      final healthScore = await _analyzePortfolioHealth(
        currentPortfolio,
        tradeHistory,
        openTrades,
      );

      // 2. Calculate performance metrics
      final performance = await _calculatePerformanceMetrics(
        currentPortfolio,
        tradeHistory,
      );

      // 3. Identify optimization opportunities
      final opportunities = await _identifyOptimizationOpportunities(
        currentPortfolio,
        performance,
        openTrades,
      );

      // 4. Generate diversification recommendations
      final diversification = _analyzeDiversification(openTrades);

      // 5. Calculate optimal position sizing
      final positionSizing = _calculateOptimalPositionSizing(
        currentPortfolio,
        performance,
      );

      // 6. Generate rebalancing recommendations
      final rebalancing = await _generateRebalancingRecommendations(
        openTrades,
        diversification,
      );

      // 7. Calculate risk-adjusted targets
      final targets = _calculateRiskAdjustedTargets(
        currentPortfolio,
        performance,
      );

      final optimization = PortfolioOptimization(
        timestamp: DateTime.now(),
        healthScore: healthScore,
        performance: performance,
        opportunities: opportunities,
        diversification: diversification,
        positionSizing: positionSizing,
        rebalancing: rebalancing,
        targets: targets,
      );

      // Store optimization results
      await _firebaseService.storePerformanceMetrics(optimization.toJson());
      await _firebaseService.logEvent('portfolio_optimized', {
        'healthScore': healthScore,
        'opportunityCount': opportunities.length,
      });

      return optimization;
    } catch (e, stackTrace) {
      await _firebaseService.logError(
          'Portfolio optimization error', stackTrace);
      rethrow;
    }
  }

  /// Analyze portfolio health (0-100 score)
  Future<double> _analyzePortfolioHealth(
    Portfolio portfolio,
    List<Trade> tradeHistory,
    List<Trade> openTrades,
  ) async {
    double healthScore = 100.0;

    // 1. Check balance stability (-20 if balance declining)
    if (portfolio.equity < portfolio.currentBalance) {
      final declinePercentage = ((portfolio.currentBalance - portfolio.equity) /
              portfolio.currentBalance) *
          100;
      healthScore -= min(declinePercentage * 2, 20);
    }

    // 2. Check win rate (-15 if below target)
    final winRate = _calculateWinRate(tradeHistory);
    if (winRate < IDEAL_WIN_RATE) {
      healthScore -= ((IDEAL_WIN_RATE - winRate) * 100);
    }

    // 3. Check diversification (-15 if poor)
    final diversificationScore = _calculateDiversificationScore(openTrades);
    if (diversificationScore < 0.7) {
      healthScore -= (1 - diversificationScore) * 15;
    }

    // 4. Check drawdown (-20 if exceeding limits)
    final drawdown = (portfolio.currentBalance - portfolio.equity) /
        portfolio.currentBalance *
        100;
    if (drawdown > MAX_MONTHLY_DRAWDOWN) {
      healthScore -= (drawdown - MAX_MONTHLY_DRAWDOWN) * 2;
    }

    // 5. Check margin usage (-10 if over-leveraged)
    final marginUsage = portfolio.margin / portfolio.equity;
    if (marginUsage > 0.5) {
      healthScore -= (marginUsage - 0.5) * 20;
    }

    // 6. Check profit factor (-10 if below 1.5)
    final profitFactor = _calculateProfitFactor(tradeHistory);
    if (profitFactor < 1.5) {
      healthScore -= (1.5 - profitFactor) * 10;
    }

    // 7. Check consistency (-10 if inconsistent)
    final consistency = _calculateConsistency(tradeHistory);
    if (consistency < 0.7) {
      healthScore -= (1 - consistency) * 10;
    }

    return healthScore.clamp(0, 100);
  }

  /// Calculate comprehensive performance metrics
  Future<Map<String, dynamic>> _calculatePerformanceMetrics(
    Portfolio portfolio,
    List<Trade> tradeHistory,
  ) async {
    if (tradeHistory.isEmpty) {
      return {
        'totalTrades': 0,
        'winRate': 0.0,
        'profitFactor': 0.0,
        'averageWin': 0.0,
        'averageLoss': 0.0,
        'largestWin': 0.0,
        'largestLoss': 0.0,
        'averageRR': 0.0,
        'consistency': 0.0,
        'sharpeRatio': 0.0,
        'maxDrawdown': 0.0,
        'recoveryFactor': 0.0,
      };
    }

    final closedTrades =
        tradeHistory.where((t) => t.status == TradeStatus.closed).toList();

    final winningTrades =
        closedTrades.where((t) => (t.profitLoss ?? 0) > 0).toList();
    final losingTrades =
        closedTrades.where((t) => (t.profitLoss ?? 0) < 0).toList();

    final totalWins =
        winningTrades.fold<double>(0, (sum, t) => sum + (t.profitLoss ?? 0));
    final totalLosses = losingTrades.fold<double>(
        0, (sum, t) => sum + (t.profitLoss ?? 0).abs());

    final avgWin =
        winningTrades.isEmpty ? 0.0 : totalWins / winningTrades.length;
    final avgLoss =
        losingTrades.isEmpty ? 0.0 : totalLosses / losingTrades.length;

    final profitFactor = totalLosses == 0 ? 0.0 : totalWins / totalLosses;
    final winRate =
        closedTrades.isEmpty ? 0.0 : winningTrades.length / closedTrades.length;

    // Calculate risk-reward ratios
    final rrRatios = <double>[];
    for (final trade in closedTrades) {
      final profit = trade.profitLoss ?? 0;
      final risk = (trade.entryPrice - trade.stopLoss).abs() * trade.lotSize;
      if (risk > 0) {
        rrRatios.add(profit.abs() / risk);
      }
    }
    final avgRR = rrRatios.isEmpty
        ? 0.0
        : rrRatios.reduce((a, b) => a + b) / rrRatios.length;

    // Calculate Sharpe ratio
    final sharpeRatio = _calculateSharpeRatio(closedTrades);

    // Calculate max drawdown
    final maxDrawdown = _calculateMaxDrawdown(portfolio, tradeHistory);

    // Calculate recovery factor
    final totalProfit =
        closedTrades.fold<double>(0, (sum, t) => sum + (t.profitLoss ?? 0));
    final recoveryFactor = maxDrawdown == 0 ? 0.0 : totalProfit / maxDrawdown;

    return {
      'totalTrades': closedTrades.length,
      'winRate': winRate,
      'profitFactor': profitFactor,
      'averageWin': avgWin,
      'averageLoss': avgLoss,
      'largestWin': winningTrades.isEmpty
          ? 0.0
          : winningTrades.map((t) => t.profitLoss!).reduce(max),
      'largestLoss': losingTrades.isEmpty
          ? 0.0
          : losingTrades.map((t) => t.profitLoss!).reduce(min).abs(),
      'averageRR': avgRR,
      'consistency': _calculateConsistency(closedTrades),
      'sharpeRatio': sharpeRatio,
      'maxDrawdown': maxDrawdown,
      'recoveryFactor': recoveryFactor,
      'expectancy': _calculateExpectancy(winRate, avgWin, avgLoss),
    };
  }

  /// Identify optimization opportunities
  Future<List<String>> _identifyOptimizationOpportunities(
    Portfolio portfolio,
    Map<String, dynamic> performance,
    List<Trade> openTrades,
  ) async {
    final opportunities = <String>[];

    // Check win rate
    if (performance['winRate'] < IDEAL_WIN_RATE) {
      opportunities.add(
          'Improve signal quality to increase win rate from ${(performance['winRate'] * 100).toStringAsFixed(1)}% to ${(IDEAL_WIN_RATE * 100).toStringAsFixed(1)}%');
    }

    // Check profit factor
    if (performance['profitFactor'] < 1.5) {
      opportunities.add(
          'Enhance profit factor from ${performance['profitFactor'].toStringAsFixed(2)} to above 1.5');
    }

    // Check risk-reward
    if (performance['averageRR'] < 2.0) {
      opportunities.add(
          'Target higher risk-reward ratios (current: ${performance['averageRR'].toStringAsFixed(2)}:1)');
    }

    // Check diversification
    final diversificationScore = _calculateDiversificationScore(openTrades);
    if (diversificationScore < 0.7) {
      opportunities.add(
          'Improve portfolio diversification across symbols and timeframes');
    }

    // Check position sizing
    if (openTrades.length < 3 &&
        portfolio.freeMargin > portfolio.currentBalance * 0.7) {
      opportunities
          .add('Consider opening more positions to utilize available capital');
    }

    if (openTrades.length > 5) {
      opportunities.add(
          'Reduce number of concurrent positions for better risk management');
    }

    // Check drawdown
    if (performance['maxDrawdown'] > MAX_MONTHLY_DRAWDOWN) {
      opportunities.add(
          'Reduce position sizes to limit drawdown below ${MAX_MONTHLY_DRAWDOWN}%');
    }

    // Check consistency
    if (performance['consistency'] < 0.7) {
      opportunities.add(
          'Improve trading consistency by following signals more strictly');
    }

    return opportunities;
  }

  /// Analyze diversification
  Map<String, dynamic> _analyzeDiversification(List<Trade> openTrades) {
    if (openTrades.isEmpty) {
      return {
        'score': 1.0,
        'symbolCount': 0,
        'correlationRisk': 0.0,
        'recommendations': <String>[],
      };
    }

    // Count unique symbols
    final symbols = openTrades.map((t) => t.symbol).toSet();
    final symbolCount = symbols.length;

    // Calculate correlation risk
    final correlationRisk = _calculateCorrelationRisk(openTrades);

    // Calculate diversification score
    final diversificationScore = _calculateDiversificationScore(openTrades);

    final recommendations = <String>[];
    if (symbolCount < 3) {
      recommendations
          .add('Trade more currency pairs for better diversification');
    }
    if (correlationRisk > 0.6) {
      recommendations
          .add('Reduce correlated positions to minimize correlation risk');
    }

    return {
      'score': diversificationScore,
      'symbolCount': symbolCount,
      'correlationRisk': correlationRisk,
      'recommendations': recommendations,
    };
  }

  /// Calculate optimal position sizing strategy
  Map<String, dynamic> _calculateOptimalPositionSizing(
    Portfolio portfolio,
    Map<String, dynamic> performance,
  ) {
    final winRate = performance['winRate'] as double;
    final avgWin = performance['averageWin'] as double;
    final avgLoss = performance['averageLoss'] as double;

    // Kelly Criterion for optimal position sizing
    double kellyPercentage = 0.0;
    if (avgLoss > 0) {
      kellyPercentage = (winRate - ((1 - winRate) / (avgWin / avgLoss))) * 100;
    }

    // Use fractional Kelly for safety (25% of full Kelly)
    final fractionalKelly = kellyPercentage * 0.25;

    // Clamp to reasonable bounds
    final recommendedRisk = fractionalKelly.clamp(0.5, 2.0);

    return {
      'currentRisk': 1.0, // Current risk per trade
      'kellyPercentage': kellyPercentage,
      'fractionalKelly': fractionalKelly,
      'recommendedRisk': recommendedRisk,
      'explanation':
          'Based on Kelly Criterion with 25% fractional sizing for safety',
    };
  }

  /// Generate rebalancing recommendations
  Future<List<String>> _generateRebalancingRecommendations(
    List<Trade> openTrades,
    Map<String, dynamic> diversification,
  ) async {
    final recommendations = <String>[];

    // Check for over-concentrated positions
    final symbolGroups = <String, List<Trade>>{};
    for (final trade in openTrades) {
      symbolGroups.putIfAbsent(trade.symbol, () => []).add(trade);
    }

    for (final entry in symbolGroups.entries) {
      final concentration = entry.value.length / openTrades.length;
      if (concentration > 0.4) {
        recommendations.add(
            'Close some ${entry.key} positions (${(concentration * 100).toStringAsFixed(0)}% concentration)');
      }
    }

    // Check for underperforming positions
    for (final trade in openTrades) {
      final duration = DateTime.now().difference(trade.openedAt);
      if (duration.inHours > 72 && (trade.profitLoss ?? 0) < 0) {
        recommendations.add(
            'Consider closing ${trade.symbol} position (open ${duration.inHours}h with loss)');
      }
    }

    return recommendations;
  }

  /// Calculate risk-adjusted growth targets
  Map<String, dynamic> _calculateRiskAdjustedTargets(
    Portfolio portfolio,
    Map<String, dynamic> performance,
  ) {
    final currentDrawdown = (portfolio.currentBalance - portfolio.equity) /
        portfolio.currentBalance *
        100;
    final winRate = performance['winRate'] as double;
    final profitFactor = performance['profitFactor'] as double;

    // Adjust targets based on current performance
    double monthlyTarget = TARGET_MONTHLY_GROWTH;
    double maxDrawdown = MAX_MONTHLY_DRAWDOWN;

    // If performing well, can target higher
    if (winRate > 0.7 && profitFactor > 2.0) {
      monthlyTarget *= 1.2; // 20% higher target
    }

    // If struggling, be more conservative
    if (winRate < 0.5 || profitFactor < 1.2) {
      monthlyTarget *= 0.7; // 30% lower target
      maxDrawdown *= 0.7; // Tighter drawdown control
    }

    return {
      'monthlyGrowthTarget': monthlyTarget,
      'annualGrowthTarget': TARGET_ANNUAL_GROWTH,
      'maxDrawdownLimit': maxDrawdown,
      'currentDrawdown': currentDrawdown,
      'targetWinRate': IDEAL_WIN_RATE,
      'currentWinRate': winRate,
      'minProfitFactor': 1.5,
      'currentProfitFactor': profitFactor,
    };
  }

  // ==================== HELPER METHODS ====================

  double _calculateWinRate(List<Trade> trades) {
    final closedTrades =
        trades.where((t) => t.status == TradeStatus.closed).toList();
    if (closedTrades.isEmpty) return 0.0;

    final winningTrades =
        closedTrades.where((t) => (t.profitLoss ?? 0) > 0).length;
    return winningTrades / closedTrades.length;
  }

  double _calculateProfitFactor(List<Trade> trades) {
    final closedTrades =
        trades.where((t) => t.status == TradeStatus.closed).toList();
    if (closedTrades.isEmpty) return 0.0;

    final totalWins = closedTrades
        .where((t) => (t.profitLoss ?? 0) > 0)
        .fold<double>(0, (sum, t) => sum + (t.profitLoss ?? 0));

    final totalLosses = closedTrades
        .where((t) => (t.profitLoss ?? 0) < 0)
        .fold<double>(0, (sum, t) => sum + (t.profitLoss ?? 0).abs());

    if (totalLosses == 0) return 0.0;
    return totalWins / totalLosses;
  }

  double _calculateConsistency(List<Trade> trades) {
    if (trades.length < 10) return 0.0;

    // Group trades into batches of 10
    final batchSize = 10;
    final batches = <List<Trade>>[];

    for (int i = 0; i < trades.length; i += batchSize) {
      final end = min(i + batchSize, trades.length);
      batches.add(trades.sublist(i, end));
    }

    // Calculate win rate for each batch
    final batchWinRates =
        batches.map((batch) => _calculateWinRate(batch)).toList();

    // Calculate standard deviation
    final mean = batchWinRates.reduce((a, b) => a + b) / batchWinRates.length;
    final variance =
        batchWinRates.map((wr) => pow(wr - mean, 2)).reduce((a, b) => a + b) /
            batchWinRates.length;
    final stdDev = sqrt(variance);

    // Lower stdDev = higher consistency
    return (1 - stdDev).clamp(0, 1);
  }

  double _calculateDiversificationScore(List<Trade> trades) {
    if (trades.isEmpty) return 1.0;
    if (trades.length == 1) return 0.5;

    final symbols = trades.map((t) => t.symbol).toSet();
    final symbolDiversity = symbols.length / trades.length;

    // Check correlation
    final correlationRisk = _calculateCorrelationRisk(trades);

    return ((symbolDiversity + (1 - correlationRisk)) / 2).clamp(0, 1);
  }

  double _calculateCorrelationRisk(List<Trade> trades) {
    if (trades.length <= 1) return 0.0;

    final symbols = trades.map((t) => t.symbol).toList();
    int correlatedCount = 0;

    for (int i = 0; i < symbols.length; i++) {
      for (int j = i + 1; j < symbols.length; j++) {
        if (_areSymbolsCorrelated(symbols[i], symbols[j])) {
          correlatedCount++;
        }
      }
    }

    final maxPairs = (symbols.length * (symbols.length - 1)) / 2;
    return correlatedCount / maxPairs;
  }

  bool _areSymbolsCorrelated(String symbol1, String symbol2) {
    // Simplified correlation check
    if (symbol1 == symbol2) return true;

    // Extract currency codes
    final curr1 = symbol1.length >= 6 ? symbol1.substring(0, 3) : '';
    final curr2 = symbol1.length >= 6 ? symbol1.substring(3, 6) : '';
    final curr3 = symbol2.length >= 6 ? symbol2.substring(0, 3) : '';
    final curr4 = symbol2.length >= 6 ? symbol2.substring(3, 6) : '';

    // Check if they share currencies
    return curr1 == curr3 || curr1 == curr4 || curr2 == curr3 || curr2 == curr4;
  }

  double _calculateSharpeRatio(List<Trade> trades) {
    if (trades.isEmpty) return 0.0;

    final returns = trades.map((t) => t.profitLoss ?? 0).toList();
    final avgReturn = returns.reduce((a, b) => a + b) / returns.length;

    final variance =
        returns.map((r) => pow(r - avgReturn, 2)).reduce((a, b) => a + b) /
            returns.length;
    final stdDev = sqrt(variance);

    if (stdDev == 0) return 0.0;

    // Risk-free rate assumed to be 2% annually
    const riskFreeRate = 0.02 / 252; // Daily rate

    return (avgReturn - riskFreeRate) / stdDev;
  }

  double _calculateMaxDrawdown(Portfolio portfolio, List<Trade> trades) {
    if (trades.isEmpty) return 0.0;

    double peak = portfolio.currentBalance;
    double maxDrawdown = 0.0;
    double currentEquity = portfolio.currentBalance;

    for (final trade in trades) {
      currentEquity += (trade.profitLoss ?? 0);

      if (currentEquity > peak) {
        peak = currentEquity;
      }

      final drawdown = (peak - currentEquity) / peak * 100;
      if (drawdown > maxDrawdown) {
        maxDrawdown = drawdown;
      }
    }

    return maxDrawdown;
  }

  double _calculateExpectancy(double winRate, double avgWin, double avgLoss) {
    return (winRate * avgWin) - ((1 - winRate) * avgLoss);
  }
}

/// Portfolio optimization result
class PortfolioOptimization {
  final DateTime timestamp;
  final double healthScore;
  final Map<String, dynamic> performance;
  final List<String> opportunities;
  final Map<String, dynamic> diversification;
  final Map<String, dynamic> positionSizing;
  final List<String> rebalancing;
  final Map<String, dynamic> targets;

  PortfolioOptimization({
    required this.timestamp,
    required this.healthScore,
    required this.performance,
    required this.opportunities,
    required this.diversification,
    required this.positionSizing,
    required this.rebalancing,
    required this.targets,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'healthScore': healthScore,
        'performance': performance,
        'opportunities': opportunities,
        'diversification': diversification,
        'positionSizing': positionSizing,
        'rebalancing': rebalancing,
        'targets': targets,
      };
}
