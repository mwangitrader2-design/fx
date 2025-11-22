import 'dart:math';
import '../models/models.dart';
import 'firebase_service.dart';
import 'technical_indicator_service.dart';

/// Enhanced AI-powered risk management service
class EnhancedRiskManager {
  final FirebaseService _firebaseService;
  final TechnicalIndicatorService _technicalService;

  // Default risk parameters
  static const double DEFAULT_RISK_PER_TRADE = 1.0; // 1% per trade
  static const double MAX_DAILY_RISK = 3.0; // 3% daily max
  static const double MAX_TOTAL_RISK = 10.0; // 10% total exposure
  static const int MAX_OPEN_TRADES = 5;
  static const double MIN_RISK_REWARD = 2.0; // Minimum 2:1 RR

  EnhancedRiskManager({
    FirebaseService? firebaseService,
    TechnicalIndicatorService? technicalService,
  })  : _firebaseService = firebaseService ?? FirebaseService(),
        _technicalService = technicalService ?? TechnicalIndicatorService();

  /// Evaluate if trade is allowed based on risk constraints
  Future<Map<String, dynamic>> evaluateTradeRisk({
    required TradingSignal signal,
    required Portfolio portfolio,
  }) async {
    try {
      final checks = <String, dynamic>{};
      final warnings = <String>[];
      bool allowed = true;

      // 1. Check account balance
      if (portfolio.currentBalance <= 0) {
        allowed = false;
        warnings.add('Insufficient account balance');
      }
      checks['balance'] = portfolio.currentBalance > 0;

      // 2. Check max open trades
      if (portfolio.openTrades.length >= MAX_OPEN_TRADES) {
        allowed = false;
        warnings.add('Maximum open positions reached ($MAX_OPEN_TRADES)');
      }
      checks['maxTrades'] = portfolio.openTrades.length < MAX_OPEN_TRADES;

      // 3. Check daily loss limit
      final dailyLoss = await _calculateDailyLoss(portfolio);
      if (dailyLoss >= MAX_DAILY_RISK) {
        allowed = false;
        warnings
            .add('Daily loss limit reached (${dailyLoss.toStringAsFixed(2)}%)');
      }
      checks['dailyLoss'] = dailyLoss < MAX_DAILY_RISK;

      // 4. Check total exposure
      final totalExposure = _calculateTotalExposure(portfolio);
      if (totalExposure >= MAX_TOTAL_RISK) {
        allowed = false;
        warnings.add(
            'Maximum total exposure reached (${totalExposure.toStringAsFixed(2)}%)');
      }
      checks['exposure'] = totalExposure < MAX_TOTAL_RISK;

      // 5. Check risk-reward ratio
      final riskReward = _calculateRiskReward(signal);
      if (riskReward < MIN_RISK_REWARD) {
        allowed = false;
        warnings.add(
            'Risk-reward ratio too low (${riskReward.toStringAsFixed(2)}:1, min $MIN_RISK_REWARD:1)');
      }
      checks['riskReward'] = riskReward >= MIN_RISK_REWARD;

      // 6. Check margin level
      final marginLevel = _calculateMarginLevel(portfolio);
      if (marginLevel < 150) {
        allowed = false;
        warnings
            .add('Margin level too low (${marginLevel.toStringAsFixed(0)}%)');
      }
      checks['margin'] = marginLevel >= 150;

      // Log risk evaluation
      await _firebaseService.logRiskEvent('risk_evaluation', {
        'signal': signal.id,
        'symbol': signal.symbol,
        'allowed': allowed,
        'checks': checks,
        'warnings': warnings,
      });

      return {
        'allowed': allowed,
        'checks': checks,
        'warnings': warnings,
        'reason': warnings.isEmpty ? 'All checks passed' : warnings.join('; '),
      };
    } catch (e, stackTrace) {
      await _firebaseService.logError('Risk evaluation error', stackTrace);
      return {
        'allowed': false,
        'checks': {},
        'warnings': ['Error evaluating risk'],
        'reason': 'System error',
      };
    }
  }

  /// Calculate optimal position size
  Future<double> calculatePositionSize({
    required TradingSignal signal,
    required Portfolio portfolio,
  }) async {
    try {
      final accountBalance = portfolio.currentBalance;
      final riskPerTrade = DEFAULT_RISK_PER_TRADE / 100;

      // Calculate risk amount
      final riskAmount = accountBalance * riskPerTrade;

      // Calculate stop loss distance in price
      final stopLossDistance = (signal.entryPrice - signal.stopLoss).abs();

      if (stopLossDistance == 0) {
        await _firebaseService
            .logError('Invalid stop loss distance', null, context: {
          'signal': signal.id,
          'entry': signal.entryPrice,
          'stopLoss': signal.stopLoss,
        });
        return 0.01; // Minimum lot size
      }

      // Calculate position size
      // For forex: 1 lot = 100,000 units
      // Position size = Risk amount / Stop loss distance / Contract size
      double positionSize = riskAmount / stopLossDistance;

      // Adjust for symbol-specific contract sizes
      positionSize = _adjustForSymbol(signal.symbol, positionSize);

      // Round to 2 decimal places (standard lot precision)
      positionSize = (positionSize * 100).roundToDouble() / 100;

      // Apply min/max constraints
      positionSize = positionSize.clamp(0.01, 10.0);

      await _firebaseService.logEvent('position_size_calculated', {
        'signal': signal.id,
        'symbol': signal.symbol,
        'accountBalance': accountBalance,
        'riskAmount': riskAmount,
        'stopLossDistance': stopLossDistance,
        'positionSize': positionSize,
      });

      return positionSize;
    } catch (e, stackTrace) {
      await _firebaseService.logError(
          'Position size calculation error', stackTrace);
      return 0.01;
    }
  }

  /// Calculate dynamic stop loss based on volatility and support/resistance
  double calculateDynamicStopLoss({
    required SignalType tradeType,
    required double entryPrice,
    required List<MarketData> marketData,
    required Map<String, List<double>> keyLevels,
  }) {
    // Calculate ATR for volatility-based stop
    final atr = _technicalService.calculateATR(marketData, 14);
    final atrMultiplier = 2.0; // Standard 2x ATR

    if (tradeType == SignalType.buy) {
      // For buy orders, stop loss below entry
      final atrStop = entryPrice - (atr * atrMultiplier);

      // Find nearest support level
      final supports = keyLevels['support'] ?? [];
      final nearestSupport = supports.isEmpty
          ? atrStop
          : supports.lastWhere(
              (s) => s < entryPrice,
              orElse: () => atrStop,
            );

      // Use the lower of ATR-based or support-based stop
      // with a small buffer below support
      final supportStop = nearestSupport - (atr * 0.3);

      return min(atrStop, supportStop);
    } else {
      // For sell orders, stop loss above entry
      final atrStop = entryPrice + (atr * atrMultiplier);

      // Find nearest resistance level
      final resistances = keyLevels['resistance'] ?? [];
      final nearestResistance = resistances.isEmpty
          ? atrStop
          : resistances.firstWhere(
              (r) => r > entryPrice,
              orElse: () => atrStop,
            );

      // Use the higher of ATR-based or resistance-based stop
      // with a small buffer above resistance
      final resistanceStop = nearestResistance + (atr * 0.3);

      return max(atrStop, resistanceStop);
    }
  }

  /// Calculate trailing stop loss
  double? calculateTrailingStop({
    required Trade trade,
    required double currentPrice,
    required double currentStopLoss,
  }) {
    final entryPrice = trade.entryPrice;
    final profitPips = (currentPrice - entryPrice).abs();

    // Only activate trailing stop after price has moved favorably
    final activationThreshold = (entryPrice - currentStopLoss).abs();

    if (profitPips < activationThreshold) {
      return null; // Not yet profitable enough to trail
    }

    if (trade.type == SignalType.buy) {
      // For buy trades, move stop loss up
      final trailingDistance =
          activationThreshold * 0.5; // Trail at 50% of initial risk
      final newStopLoss = currentPrice - trailingDistance;

      // Only move up, never down
      if (newStopLoss > currentStopLoss) {
        return newStopLoss;
      }
    } else {
      // For sell trades, move stop loss down
      final trailingDistance = activationThreshold * 0.5;
      final newStopLoss = currentPrice + trailingDistance;

      // Only move down, never up
      if (newStopLoss < currentStopLoss) {
        return newStopLoss;
      }
    }

    return null;
  }

  /// Determine if trade should be exited early
  Future<Map<String, dynamic>> shouldExitTrade({
    required Trade trade,
    required double currentPrice,
    required double currentProfit,
    required Portfolio portfolio,
  }) async {
    final reasons = <String>[];

    // 1. Check if account is in severe drawdown
    final drawdown = _calculateCurrentDrawdown(portfolio);
    if (drawdown >= 15) {
      return {
        'exit': true,
        'reason': 'Account drawdown exceeds 15%',
      };
    }

    // 2. Check if daily loss limit reached
    final dailyLoss = await _calculateDailyLoss(portfolio);
    if (dailyLoss >= MAX_DAILY_RISK && currentProfit < 0) {
      return {
        'exit': true,
        'reason': 'Daily loss limit reached',
      };
    }

    // 3. Check if trade has been open too long without profit
    final duration = DateTime.now().difference(trade.openedAt);
    if (duration.inHours > 48 && currentProfit < 0) {
      return {
        'exit': true,
        'reason': 'Trade open too long without profit (>48 hours)',
      };
    }

    // 4. Check for excessive loss on single trade
    final accountBalance = portfolio.currentBalance;
    final lossPercentage = (currentProfit / accountBalance).abs() * 100;
    if (lossPercentage > 2.0) {
      return {
        'exit': true,
        'reason': 'Single trade loss exceeds 2%',
      };
    }

    return {
      'exit': false,
      'reason': null,
    };
  }

  /// Determine if should take partial profit
  bool shouldTakePartialProfit({
    required Trade trade,
    required double currentProfit,
  }) {
    final entryPrice = trade.entryPrice;
    final takeProfit = trade.takeProfit;
    final stopLoss = trade.stopLoss;

    // Calculate how far price has moved toward take profit
    final totalDistance = (takeProfit - entryPrice).abs();
    final currentDistance = (currentProfit / trade.lotSize).abs();

    final progressPercentage = currentDistance / totalDistance;

    // Take 50% profit when 50% of the way to full take profit
    return progressPercentage >= 0.5;
  }

  /// Calculate portfolio correlation risk
  Future<double> calculateCorrelationRisk(
    List<Trade> openTrades,
  ) async {
    if (openTrades.length <= 1) return 0.0;

    // Group trades by symbol
    final symbolGroups = <String, int>{};
    for (final trade in openTrades) {
      symbolGroups[trade.symbol] = (symbolGroups[trade.symbol] ?? 0) + 1;
    }

    // Check for over-concentration
    double maxConcentration = 0.0;
    for (final count in symbolGroups.values) {
      final concentration = count / openTrades.length;
      if (concentration > maxConcentration) {
        maxConcentration = concentration;
      }
    }

    // Check for correlated pairs (simplified)
    final correlationScore =
        _checkSymbolCorrelations(symbolGroups.keys.toList());

    return (maxConcentration + correlationScore) / 2;
  }

  /// Calculate optimal risk-reward ratio
  double calculateOptimalRiskReward({
    required double winRate,
    required double accountGrowthTarget,
  }) {
    // Kelly Criterion adjusted for trading
    // Optimal RR = (Win% * Avg Win) / (Loss% * Avg Loss)
    final lossRate = 1 - winRate;

    if (lossRate == 0) return 3.0; // Default if perfect win rate

    final optimalRR = (winRate / lossRate) * (accountGrowthTarget / 100);

    return optimalRR.clamp(2.0, 5.0); // Reasonable bounds
  }

  // ==================== HELPER METHODS ====================

  double _calculateRiskReward(TradingSignal signal) {
    final risk = (signal.entryPrice - signal.stopLoss).abs();
    final reward = (signal.takeProfit - signal.entryPrice).abs();

    if (risk == 0) return 0;
    return reward / risk;
  }

  double _calculateTotalExposure(Portfolio portfolio) {
    if (portfolio.currentBalance == 0) return 0;

    final exposedMargin = portfolio.margin;
    return (exposedMargin / portfolio.currentBalance) * 100;
  }

  Future<double> _calculateDailyLoss(Portfolio portfolio) async {
    // Get today's trade history from Firebase
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final performanceMetrics = await _firebaseService.getPerformanceMetrics(1);

    if (performanceMetrics.isEmpty) return 0.0;

    final todayMetrics = performanceMetrics.first;
    final dailyProfit = todayMetrics['dailyProfit'] as double? ?? 0.0;

    if (dailyProfit >= 0) return 0.0;

    return (dailyProfit.abs() / portfolio.currentBalance) * 100;
  }

  double _calculateMarginLevel(Portfolio portfolio) {
    if (portfolio.margin == 0) return double.infinity;

    return (portfolio.equity / portfolio.margin) * 100;
  }

  double _calculateCurrentDrawdown(Portfolio portfolio) {
    final peakBalance = portfolio.currentBalance + portfolio.totalProfit;
    if (peakBalance == 0) return 0;

    final currentEquity = portfolio.equity;
    final drawdown = ((peakBalance - currentEquity) / peakBalance) * 100;

    return drawdown.clamp(0, 100);
  }

  double _adjustForSymbol(String symbol, double positionSize) {
    // Adjust position size based on symbol type
    // This is simplified - in production, you'd query symbol specifications

    if (symbol.contains('JPY')) {
      // JPY pairs have different pip value
      return positionSize * 0.01;
    }

    if (symbol.contains('XAU') || symbol.contains('GOLD')) {
      // Gold requires smaller position sizes
      return positionSize * 0.01;
    }

    if (symbol.contains('INDEX') ||
        symbol.contains('SPX') ||
        symbol.contains('US30')) {
      // Indices require different sizing
      return positionSize * 0.1;
    }

    // Standard forex pair
    return positionSize * 0.001; // Convert to lots
  }

  double _checkSymbolCorrelations(List<String> symbols) {
    // Simplified correlation check
    // In production, use historical price correlation

    int correlatedPairs = 0;
    final checkedPairs = <String>{};

    for (final symbol1 in symbols) {
      for (final symbol2 in symbols) {
        if (symbol1 == symbol2) continue;

        final pairKey = [symbol1, symbol2]..sort();
        final pairString = pairKey.join('-');

        if (checkedPairs.contains(pairString)) continue;
        checkedPairs.add(pairString);

        // Check if symbols share currency
        if (_symbolsAreCorrelated(symbol1, symbol2)) {
          correlatedPairs++;
        }
      }
    }

    if (symbols.length <= 1) return 0.0;

    final maxPairs = (symbols.length * (symbols.length - 1)) / 2;
    return correlatedPairs / maxPairs;
  }

  bool _symbolsAreCorrelated(String symbol1, String symbol2) {
    // Simplified correlation logic
    // Check if they share a common currency

    final currencies1 = _extractCurrencies(symbol1);
    final currencies2 = _extractCurrencies(symbol2);

    return currencies1.any((c) => currencies2.contains(c));
  }

  List<String> _extractCurrencies(String symbol) {
    // Extract currency codes from symbol
    // Example: EURUSD -> [EUR, USD]

    if (symbol.length >= 6) {
      return [
        symbol.substring(0, 3),
        symbol.substring(3, 6),
      ];
    }

    return [symbol];
  }
}
