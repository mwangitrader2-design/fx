import 'dart:async';
import '../models/models.dart';
import 'firebase_service.dart';
import 'ai_market_analyzer.dart';
import 'ai_signal_generator.dart';
import 'automated_trade_executor.dart';
import 'enhanced_risk_manager.dart';
import 'ai_portfolio_manager.dart';
import 'portfolio_service.dart';
import 'market_data_service.dart';
import 'mt5_service.dart';

/// Master AI Trading Controller - Orchestrates all AI trading operations
class AITradingController {
  final FirebaseService _firebaseService;
  final AIMarketAnalyzer _marketAnalyzer;
  final AISignalGenerator _signalGenerator;
  final AutomatedTradeExecutor _tradeExecutor;
  final EnhancedRiskManager _riskManager;
  final AIPortfolioManager _portfolioManager;
  final PortfolioService _portfolioService;
  final MarketDataService _marketDataService;
  final MT5Service _mt5Service;

  bool _isRunning = false;
  Timer? _analysisTimer;
  Timer? _monitoringTimer;

  // Trading pairs to monitor
  final List<String> _symbols = [
    'EURUSD',
    'GBPUSD',
    'USDJPY',
    'AUDUSD',
    'USDCAD',
  ];

  // Timeframes for analysis
  final List<TimeframeType> _timeframes = [
    TimeframeType.M15,
    TimeframeType.H1,
    TimeframeType.H4,
    TimeframeType.D1,
  ];

  AITradingController({
    FirebaseService? firebaseService,
    AIMarketAnalyzer? marketAnalyzer,
    AISignalGenerator? signalGenerator,
    AutomatedTradeExecutor? tradeExecutor,
    EnhancedRiskManager? riskManager,
    AIPortfolioManager? portfolioManager,
    PortfolioService? portfolioService,
    MarketDataService? marketDataService,
    MT5Service? mt5Service,
  })  : _firebaseService = firebaseService ?? FirebaseService(),
        _marketAnalyzer = marketAnalyzer ?? AIMarketAnalyzer(),
        _signalGenerator = signalGenerator ?? AISignalGenerator(),
        _tradeExecutor = tradeExecutor ?? AutomatedTradeExecutor(),
        _riskManager = riskManager ?? EnhancedRiskManager(),
        _portfolioManager = portfolioManager ?? AIPortfolioManager(),
        _portfolioService = portfolioService ?? PortfolioService(),
        _marketDataService = marketDataService ?? MarketDataService(),
        _mt5Service = mt5Service ?? MT5Service();

  /// Initialize the AI trading system
  Future<void> initialize() async {
    try {
      await _firebaseService.initialize();
      await _firebaseService.logEvent('ai_trading_initialized', {
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e, stackTrace) {
      await _firebaseService.logError('Initialization error', stackTrace);
      rethrow;
    }
  }

  /// Start automated AI trading
  Future<void> startAutomatedTrading() async {
    if (_isRunning) return;

    _isRunning = true;
    await _tradeExecutor.startAutomatedTrading();

    // Start periodic market analysis (every 15 minutes)
    _analysisTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => _analyzeMarketsAndGenerateSignals(),
    );

    // Start trade monitoring (every 1 minute)
    _monitoringTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _monitorAndManageTrades(),
    );

    // Run initial analysis
    await _analyzeMarketsAndGenerateSignals();

    await _firebaseService.logEvent('automated_trading_started', {
      'symbols': _symbols,
      'timeframes': _timeframes.map((t) => t.toString()).toList(),
    });
  }

  /// Stop automated trading
  Future<void> stopAutomatedTrading() async {
    if (!_isRunning) return;

    _isRunning = false;
    _analysisTimer?.cancel();
    _monitoringTimer?.cancel();

    await _tradeExecutor.stopAutomatedTrading();

    await _firebaseService.logEvent('automated_trading_stopped', {
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Analyze markets and generate signals
  Future<void> _analyzeMarketsAndGenerateSignals() async {
    if (!_isRunning) return;

    try {
      final accountInfo = await _mt5Service.getAccountInfo();
      if (accountInfo == null || accountInfo['success'] != true) return;

      final portfolio = _convertToPortfolio(accountInfo['data']);

      for (final symbol in _symbols) {
        await _analyzeSymbol(symbol, portfolio);
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError('Market analysis error', stackTrace);
    }
  }

  /// Analyze a specific symbol
  Future<void> _analyzeSymbol(String symbol, Portfolio portfolio) async {
    try {
      // 1. Fetch market data for all timeframes
      final timeframeData = <TimeframeType, List<MarketData>>{};

      for (final timeframe in _timeframes) {
        final data = await _marketDataService.getHistoricalData(
          symbol: symbol,
          timeframe: timeframe,
          bars: 200,
        );

        if (data.isNotEmpty) {
          timeframeData[timeframe] = data;
        }
      }

      if (timeframeData.isEmpty) return;

      // 2. Perform comprehensive AI market analysis
      final analysis = await _marketAnalyzer.analyzeMarket(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: TimeframeType.H1,
      );

      // 3. Generate high-confidence signal if conditions are met
      final signal = await _signalGenerator.generateSignal(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: TimeframeType.H1,
      );

      if (signal != null) {
        await _processSignal(signal, portfolio, timeframeData);
      }
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Symbol analysis error', stackTrace, context: {
        'symbol': symbol,
      });
    }
  }

  /// Process a generated signal
  Future<void> _processSignal(
    TradingSignal signal,
    Portfolio portfolio,
    Map<TimeframeType, List<MarketData>> timeframeData,
  ) async {
    try {
      // 1. Get confirmation timeframe data
      final confirmationData =
          timeframeData[signal.confirmationTimeframe] ?? [];

      if (confirmationData.isEmpty) {
        await _firebaseService.logEvent('signal_skipped_no_confirmation_data', {
          'signalId': signal.id,
          'symbol': signal.symbol,
        });
        return;
      }

      // 2. Confirm signal on lower timeframe
      final confirmation = await _signalGenerator.confirmSignalOnLowerTimeframe(
        signal,
        confirmationData,
      );

      // 3. If confirmed, execute the trade
      if (confirmation.isConfirmed) {
        final trade = await _tradeExecutor.executeTrade(
          signal: signal,
          confirmation: confirmation,
          portfolio: portfolio,
        );

        if (trade != null) {
          await _firebaseService.logEvent('trade_executed_from_signal', {
            'signalId': signal.id,
            'tradeId': trade.id,
            'symbol': signal.symbol,
            'type': signal.type.toString(),
            'confidence': signal.confidenceScore,
          });
        }
      } else {
        await _firebaseService.logEvent('signal_not_confirmed', {
          'signalId': signal.id,
          'symbol': signal.symbol,
          'alignmentScore': confirmation.alignmentScore,
          'indicators': confirmation.indicators,
        });
      }
    } catch (e, stackTrace) {
      await _firebaseService
          .logError('Signal processing error', stackTrace, context: {
        'signalId': signal.id,
        'symbol': signal.symbol,
      });
    }
  }

  /// Monitor and manage active trades
  Future<void> _monitorAndManageTrades() async {
    if (!_isRunning) return;

    try {
      final accountInfo = await _mt5Service.getAccountInfo();
      if (accountInfo['success'] != true) return;

      final portfolio = _convertToPortfolio(accountInfo['data']);

      // Monitor active trades
      await _tradeExecutor.monitorActiveTrades(portfolio);

      // Every hour, optimize portfolio
      if (DateTime.now().minute == 0) {
        await _optimizePortfolio(portfolio);
      }
    } catch (e, stackTrace) {
      await _firebaseService.logError('Trade monitoring error', stackTrace);
    }
  }

  /// Optimize portfolio for steady growth
  Future<void> _optimizePortfolio(Portfolio portfolio) async {
    try {
      // Get trade history from portfolio
      final tradeHistory = portfolio.closedTrades;

      final openTrades = _tradeExecutor.getActiveTrades();

      // Perform portfolio optimization
      final optimization = await _portfolioManager.optimizePortfolio(
        currentPortfolio: portfolio,
        tradeHistory: tradeHistory,
        openTrades: openTrades,
      );

      await _firebaseService.logEvent('portfolio_optimized', {
        'healthScore': optimization.healthScore,
        'opportunityCount': optimization.opportunities.length,
        'rebalancingActions': optimization.rebalancing.length,
      });

      // Execute rebalancing actions if needed
      await _executeRebalancing(optimization.rebalancing, openTrades);
    } catch (e, stackTrace) {
      await _firebaseService.logError(
          'Portfolio optimization error', stackTrace);
    }
  }

  /// Execute rebalancing actions
  Future<void> _executeRebalancing(
    List<String> actions,
    List<Trade> openTrades,
  ) async {
    // This would implement automatic position closing/adjusting
    // based on portfolio optimization recommendations
    for (final action in actions) {
      if (action.toLowerCase().contains('close')) {
        // Extract symbol and close positions
        // This is simplified - production would need more robust parsing
        await _firebaseService.logEvent('rebalancing_action_considered', {
          'action': action,
        });
      }
    }
  }

  /// Get trading system status
  Map<String, dynamic> getStatus() {
    return {
      'isRunning': _isRunning,
      'monitoredSymbols': _symbols,
      'timeframes': _timeframes.map((t) => t.toString()).toList(),
      'activeTrades': _tradeExecutor.getActiveTrades().length,
    };
  }

  /// Manually analyze a specific symbol
  Future<MarketAnalysisResult?> analyzeSymbol(
    String symbol,
    TimeframeType primaryTimeframe,
  ) async {
    try {
      final timeframeData = <TimeframeType, List<MarketData>>{};

      for (final timeframe in _timeframes) {
        final data = await _marketDataService.getHistoricalData(
          symbol: symbol,
          timeframe: timeframe,
          bars: 200,
        );

        if (data.isNotEmpty) {
          timeframeData[timeframe] = data;
        }
      }

      if (timeframeData.isEmpty) return null;

      return await _marketAnalyzer.analyzeMarket(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: primaryTimeframe,
      );
    } catch (e, stackTrace) {
      await _firebaseService.logError('Manual analysis error', stackTrace);
      return null;
    }
  }

  /// Manually generate a signal for a symbol
  Future<TradingSignal?> generateSignal(
    String symbol,
    TimeframeType primaryTimeframe,
  ) async {
    try {
      final timeframeData = <TimeframeType, List<MarketData>>{};

      for (final timeframe in _timeframes) {
        final data = await _marketDataService.getHistoricalData(
          symbol: symbol,
          timeframe: timeframe,
          bars: 200,
        );

        if (data.isNotEmpty) {
          timeframeData[timeframe] = data;
        }
      }

      if (timeframeData.isEmpty) return null;

      return await _signalGenerator.generateSignal(
        symbol: symbol,
        timeframeData: timeframeData,
        primaryTimeframe: primaryTimeframe,
      );
    } catch (e, stackTrace) {
      await _firebaseService.logError(
          'Manual signal generation error', stackTrace);
      return null;
    }
  }

  /// Get portfolio optimization report
  Future<PortfolioOptimization?> getPortfolioReport() async {
    try {
      final accountInfo = await _mt5Service.getAccountInfo();
      if (accountInfo['success'] != true) return null;

      final portfolio = _convertToPortfolio(accountInfo['data']);

      // Get trade history from portfolio
      final tradeHistory = portfolio.closedTrades;

      final openTrades = _tradeExecutor.getActiveTrades();

      return await _portfolioManager.optimizePortfolio(
        currentPortfolio: portfolio,
        tradeHistory: tradeHistory,
        openTrades: openTrades,
      );
    } catch (e, stackTrace) {
      await _firebaseService.logError('Portfolio report error', stackTrace);
      return null;
    }
  }

  /// Add symbol to monitoring list
  void addSymbol(String symbol) {
    if (!_symbols.contains(symbol)) {
      _symbols.add(symbol);
      _firebaseService.logEvent('symbol_added', {'symbol': symbol});
    }
  }

  /// Remove symbol from monitoring list
  void removeSymbol(String symbol) {
    _symbols.remove(symbol);
    _firebaseService.logEvent('symbol_removed', {'symbol': symbol});
  }

  /// Get active trades
  List<Trade> getActiveTrades() => _tradeExecutor.getActiveTrades();

  /// Check if system is running
  bool get isRunning => _isRunning;

  /// Get monitored symbols
  List<String> get monitoredSymbols => List.unmodifiable(_symbols);

  /// Convert MT5 account info to Portfolio object
  Portfolio _convertToPortfolio(Map<String, dynamic>? accountData) {
    if (accountData == null) {
      // Return a default portfolio if no data
      return _portfolioService.createPortfolio(10000.0);
    }

    final balance = (accountData['balance'] as num?)?.toDouble() ?? 10000.0;
    final equity = (accountData['equity'] as num?)?.toDouble() ?? balance;
    final margin = (accountData['margin'] as num?)?.toDouble() ?? 0.0;
    final freeMargin =
        (accountData['free_margin'] as num?)?.toDouble() ?? balance;
    final marginLevel =
        (accountData['margin_level'] as num?)?.toDouble() ?? 0.0;

    // Create base portfolio
    final portfolio = _portfolioService.createPortfolio(balance);

    // Update with current values
    return portfolio.copyWith(
      currentBalance: balance,
      equity: equity,
      margin: margin,
      freeMargin: freeMargin,
      marginLevel: marginLevel,
      updatedAt: DateTime.now(),
    );
  }

  /// Dispose resources
  void dispose() {
    _analysisTimer?.cancel();
    _monitoringTimer?.cancel();
  }
}
