import '../models/models.dart';
import 'ai_signal_generator.dart';
import 'mt5_service.dart';
import 'firebase_service.dart';
import 'enhanced_risk_manager.dart';

/// Automated trade execution service based on confirmed signals
class AutomatedTradeExecutor {
  final AISignalGenerator _signalGenerator;
  final MT5Service _mt5Service;
  final FirebaseService _firebaseService;
  final EnhancedRiskManager _riskManager;

  bool _isActive = false;
  final Map<String, Trade> _activeTrades = {};

  AutomatedTradeExecutor({
    AISignalGenerator? signalGenerator,
    MT5Service? mt5Service,
    FirebaseService? firebaseService,
    EnhancedRiskManager? riskManager,
  })  : _signalGenerator = signalGenerator ?? AISignalGenerator(),
        _mt5Service = mt5Service ?? MT5Service(),
        _riskManager = riskManager ?? EnhancedRiskManager(),
        _firebaseService = firebaseService ?? FirebaseService();

  /// Start automated trading
  Future<void> startAutomatedTrading() async {
    if (_isActive) return;

    _isActive = true;
    await _firebaseService.logEvent('automated_trading_started', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Stop automated trading
  Future<void> stopAutomatedTrading() async {
    _isActive = false;
    await _firebaseService.logEvent('automated_trading_stopped', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Execute trade based on confirmed signal
  Future<Trade?> executeTrade({
    required TradingSignal signal,
    required SignalConfirmation confirmation,
    required Portfolio portfolio,
  }) async {
    try {
      if (!_isActive) {
        await _firebaseService.logEvent('trade_rejected_system_inactive', {
          'signalId': signal.id,
          'symbol': signal.symbol,
        });
        return null;
      }

      // 1. Verify signal is confirmed
      if (!confirmation.isConfirmed) {
        await _firebaseService.logEvent('trade_rejected_not_confirmed', {
          'signalId': signal.id,
          'symbol': signal.symbol,
          'confirmationConfidence': confirmation.alignmentScore,
        });
        return null;
      }

      // 2. Check risk management constraints
      final riskCheck = await _riskManager.evaluateTradeRisk(
        signal: signal,
        portfolio: portfolio,
      );

      if (!riskCheck['allowed']) {
        await _firebaseService.logRiskEvent('trade_rejected_risk_check', {
          'signalId': signal.id,
          'symbol': signal.symbol,
          'reason': riskCheck['reason'],
        });
        return null;
      }

      // 3. Calculate position size
      final positionSize = await _riskManager.calculatePositionSize(
        signal: signal,
        portfolio: portfolio,
      );

      if (positionSize <= 0) {
        await _firebaseService
            .logRiskEvent('trade_rejected_invalid_position_size', {
          'signalId': signal.id,
          'symbol': signal.symbol,
        });
        return null;
      }

      // 4. Get current price from confirmation indicators
      final currentPrice =
          confirmation.indicators['price'] as double? ?? signal.entryPrice;

      // 5. Verify price is still valid
      if (!_isPriceValid(signal, currentPrice)) {
        await _firebaseService.logEvent('trade_rejected_price_moved', {
          'signalId': signal.id,
          'symbol': signal.symbol,
          'expectedPrice': signal.entryPrice,
          'currentPrice': currentPrice,
        });
        return null;
      }

      // 6. Execute the trade via MT5
      final tradeResult = await _executeMT5Trade(
        signal: signal,
        positionSize: positionSize,
        currentPrice: currentPrice,
      );

      if (tradeResult == null) {
        await _firebaseService
            .logError('Trade execution failed', null, context: {
          'signalId': signal.id,
          'symbol': signal.symbol,
        });
        return null;
      }

      // 7. Create trade record
      final trade = Trade(
        id: tradeResult['ticket'].toString(),
        symbol: signal.symbol,
        type: signal.type,
        status: TradeStatus.open,
        entryPrice: tradeResult['entryPrice'],
        lotSize: positionSize,
        stopLoss: signal.stopLoss,
        takeProfit: signal.takeProfit,
        openedAt: DateTime.now(),
        signalId: signal.id,
        exitPrice: null,
        closedAt: null,
        profitLoss: null,
      );

      // 8. Store trade in active trades
      _activeTrades[trade.id] = trade;

      // 9. Log trade execution
      await _firebaseService.logTradeExecution(trade);
      await _firebaseService.logEvent('trade_executed_successfully', {
        'tradeId': trade.id,
        'symbol': signal.symbol,
        'type': signal.type.toString(),
        'positionSize': positionSize,
        'entryPrice': trade.entryPrice,
      });

      return trade;
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Trade execution error', stackTrace, context: {
        'signalId': signal.id,
        'symbol': signal.symbol,
        'error': e.toString(),
      });
      return null;
    }
  }

  /// Execute trade via MT5
  Future<Map<String, dynamic>?> _executeMT5Trade({
    required TradingSignal signal,
    required double positionSize,
    required double currentPrice,
  }) async {
    try {
      final orderType = signal.type == SignalType.buy ? 'buy' : 'sell';

      final result = await _mt5Service.placeOrder(
        symbol: signal.symbol,
        orderType: orderType,
        volume: positionSize,
        price: currentPrice,
        stopLoss: signal.stopLoss,
        takeProfit: signal.takeProfit,
        comment: 'AI Signal ${signal.id.substring(0, 8)}',
      );

      return result;
    } catch (e) {
      print('MT5 trade execution error: $e');
      return null;
    }
  }

  /// Check if price is still valid for entry
  bool _isPriceValid(TradingSignal signal, double currentPrice) {
    final expectedPrice = signal.entryPrice;
    final priceDifference =
        (currentPrice - expectedPrice).abs() / expectedPrice;

    // Allow up to 0.5% price deviation
    return priceDifference <= 0.005;
  }

  /// Monitor and manage active trades
  Future<void> monitorActiveTrades(Portfolio portfolio) async {
    if (!_isActive) return;

    try {
      final tradeIds = List<String>.from(_activeTrades.keys);

      for (final tradeId in tradeIds) {
        final trade = _activeTrades[tradeId];
        if (trade == null) continue;

        // Get current position info from MT5
        final positionInfo = await _mt5Service.getPosition(tradeId);
        if (positionInfo == null) {
          // Trade is closed
          await _handleClosedTrade(trade, portfolio);
          continue;
        }

        // Check if we need to modify stop loss (trailing stop)
        await _checkTrailingStop(trade, positionInfo);

        // Check for risk management actions
        await _checkRiskManagementActions(trade, positionInfo, portfolio);
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError('Trade monitoring error', stackTrace);
    }
  }

  /// Handle closed trade
  Future<void> _handleClosedTrade(Trade trade, Portfolio portfolio) async {
    try {
      // Get final trade info
      final tradeHistory = await _mt5Service.getTradeHistory(trade.id);
      if (tradeHistory != null) {
        final updatedTrade = trade.copyWith(
          status: TradeStatus.closed,
          exitPrice: tradeHistory['closePrice'],
          profitLoss: tradeHistory['profit'],
          closedAt: tradeHistory['closeTime'],
        );

        // Update in Firebase
        await _firebaseService.logTradeExecution(updatedTrade);

        // Log result
        await _firebaseService.logEvent('trade_closed', {
          'tradeId': trade.id,
          'symbol': trade.symbol,
          'profit': tradeHistory['profit'],
          'duration':
              updatedTrade.closedAt!.difference(trade.openedAt).inMinutes,
        });

        // Remove from active trades
        _activeTrades.remove(trade.id);
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError('Handle closed trade error', stackTrace);
    }
  }

  /// Check and update trailing stop
  Future<void> _checkTrailingStop(
      Trade trade, Map<String, dynamic> positionInfo) async {
    try {
      final currentPrice = positionInfo['currentPrice'] as double;
      final currentStopLoss = positionInfo['stopLoss'] as double;

      // Calculate new trailing stop
      final newStopLoss = _riskManager.calculateTrailingStop(
        trade: trade,
        currentPrice: currentPrice,
        currentStopLoss: currentStopLoss,
      );

      // If stop loss needs to be updated
      if (newStopLoss != null && newStopLoss != currentStopLoss) {
        await _mt5Service.modifyPosition(
          ticket: trade.id,
          stopLoss: newStopLoss,
          takeProfit: trade.takeProfit,
        );

        await _firebaseService.logEvent('trailing_stop_updated', {
          'tradeId': trade.id,
          'symbol': trade.symbol,
          'oldStopLoss': currentStopLoss,
          'newStopLoss': newStopLoss,
        });
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError('Trailing stop error', stackTrace);
    }
  }

  /// Check for risk management actions
  Future<void> _checkRiskManagementActions(
    Trade trade,
    Map<String, dynamic> positionInfo,
    Portfolio portfolio,
  ) async {
    try {
      final currentProfit = positionInfo['profit'] as double;
      final currentPrice = positionInfo['currentPrice'] as double;

      // Check for early exit conditions
      final shouldExit = await _riskManager.shouldExitTrade(
        trade: trade,
        currentPrice: currentPrice,
        currentProfit: currentProfit,
        portfolio: portfolio,
      );

      if (shouldExit['exit'] == true) {
        await _mt5Service.closePosition(trade.id);

        await _firebaseService.logEvent('trade_closed_risk_management', {
          'tradeId': trade.id,
          'symbol': trade.symbol,
          'reason': shouldExit['reason'],
          'profit': currentProfit,
        });
      }

      // Check for partial profit taking
      final shouldTakePartialProfit = _riskManager.shouldTakePartialProfit(
        trade: trade,
        currentProfit: currentProfit,
      );

      if (shouldTakePartialProfit) {
        // Close half the position
        final partialVolume = trade.lotSize / 2;
        await _mt5Service.closePartialPosition(trade.id, partialVolume);

        await _firebaseService.logEvent('partial_profit_taken', {
          'tradeId': trade.id,
          'symbol': trade.symbol,
          'volume': partialVolume,
        });
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError(
          'Risk management action error', stackTrace);
    }
  }

  /// Get active trades
  List<Trade> getActiveTrades() => _activeTrades.values.toList();

  /// Get trade by ID
  Trade? getTrade(String tradeId) => _activeTrades[tradeId];

  /// Check if automated trading is active
  bool get isActive => _isActive;
}

/// Extension for Trade model
extension TradeExtension on Trade {
  Trade copyWith({
    String? id,
    String? symbol,
    SignalType? type,
    TradeStatus? status,
    double? entryPrice,
    double? exitPrice,
    double? stopLoss,
    double? takeProfit,
    double? lotSize,
    double? profitLoss,
    DateTime? openedAt,
    DateTime? closedAt,
    String? signalId,
  }) {
    return Trade(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      status: status ?? this.status,
      entryPrice: entryPrice ?? this.entryPrice,
      lotSize: lotSize ?? this.lotSize,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      openedAt: openedAt ?? this.openedAt,
      signalId: signalId ?? this.signalId,
      exitPrice: exitPrice ?? this.exitPrice,
      closedAt: closedAt ?? this.closedAt,
      profitLoss: profitLoss ?? this.profitLoss,
    );
  }
}
