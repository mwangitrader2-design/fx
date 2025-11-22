import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart' hide Query;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../models/models.dart';

/// Service for Firebase integration - logging, data storage, and real-time sync
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  bool _initialized = false;

  /// Initialize Firebase
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await Firebase.initializeApp();
      _initialized = true;
      await logEvent('firebase_initialized',
          {'timestamp': DateTime.now().toIso8601String()});
    } catch (e) {
      print('Firebase initialization error: $e');
      rethrow;
    }
  }

  // ==================== LOGGING ====================

  /// Log an event for analytics
  Future<void> logEvent(
      String eventName, Map<String, dynamic> parameters) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters:
            parameters?.map((key, value) => MapEntry(key, value as Object)),
      );

      // Also store in Firestore for historical analysis
      await _firestore.collection('logs').add({
        'event': eventName,
        'parameters': parameters,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging event: $e');
    }
  }

  /// Log an error
  Future<void> logError(String error, StackTrace? stackTrace,
      {Map<String, dynamic>? context}) async {
    try {
      await _firestore.collection('errors').add({
        'error': error,
        'stackTrace': stackTrace?.toString(),
        'context': context,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging error: $e');
    }
  }

  /// Log trade execution
  Future<void> logTradeExecution(Trade trade) async {
    try {
      await _firestore.collection('trades').doc(trade.id).set({
        'id': trade.id,
        'symbol': trade.symbol,
        'type': trade.type.toString(),
        'status': trade.status.toString(),
        'entryPrice': trade.entryPrice,
        'exitPrice': trade.exitPrice,
        'stopLoss': trade.stopLoss,
        'takeProfit': trade.takeProfit,
        'lotSize': trade.lotSize,
        'profitLoss': trade.profitLoss ?? 0,
        'openedAt': trade.openedAt.toIso8601String(),
        'closedAt': trade.closedAt?.toIso8601String(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      await logEvent('trade_executed', {
        'symbol': trade.symbol,
        'type': trade.type.toString(),
        'profit': trade.profitLoss ?? 0,
      });
    } catch (e) {
      print('Error logging trade: $e');
    }
  }

  /// Log signal generation
  Future<void> logSignal(TradingSignal signal) async {
    try {
      await _firestore.collection('signals').doc(signal.id).set({
        'id': signal.id,
        'symbol': signal.symbol,
        'type': signal.type.toString(),
        'strength': signal.strength.toString(),
        'status': signal.status.toString(),
        'confidenceScore': signal.confidenceScore,
        'entryPrice': signal.entryPrice,
        'stopLoss': signal.stopLoss,
        'takeProfit': signal.takeProfit,
        'primaryTimeframe': signal.primaryTimeframe.toString(),
        'generatedAt': signal.generatedAt.toIso8601String(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      await logEvent('signal_generated', {
        'symbol': signal.symbol,
        'type': signal.type.toString(),
        'confidence': signal.confidenceScore,
      });
    } catch (e) {
      print('Error logging signal: $e');
    }
  }

  // ==================== MARKET DATA STORAGE ====================

  /// Store market data
  Future<void> storeMarketData(String symbol, MarketData data) async {
    try {
      final ref = _database
          .ref('market_data/$symbol/${data.timestamp.millisecondsSinceEpoch}');
      await ref.set({
        'open': data.open,
        'high': data.high,
        'low': data.low,
        'close': data.close,
        'volume': data.volume,
        'timestamp': data.timestamp.toIso8601String(),
      });
    } catch (e) {
      print('Error storing market data: $e');
    }
  }

  /// Store batch market data
  Future<void> storeBatchMarketData(
      String symbol, List<MarketData> dataList) async {
    try {
      final updates = <String, dynamic>{};
      for (final data in dataList) {
        final key =
            'market_data/$symbol/${data.timestamp.millisecondsSinceEpoch}';
        updates[key] = {
          'open': data.open,
          'high': data.high,
          'low': data.low,
          'close': data.close,
          'volume': data.volume,
          'timestamp': data.timestamp.toIso8601String(),
        };
      }
      await _database.ref().update(updates);
    } catch (e) {
      print('Error storing batch market data: $e');
    }
  }

  /// Get historical market data from Firebase
  Future<List<MarketData>> getHistoricalMarketData(
    String symbol,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      final snapshot = await _database
          .ref('market_data/$symbol')
          .orderByKey()
          .startAt(startTime.millisecondsSinceEpoch.toString())
          .endAt(endTime.millisecondsSinceEpoch.toString())
          .get();

      if (!snapshot.exists) return [];

      final data = snapshot.value as Map<dynamic, dynamic>;
      final result = <MarketData>[];

      data.forEach((key, value) {
        final map = Map<String, dynamic>.from(value as Map);
        result.add(MarketData(
          symbol: symbol,
          timestamp: DateTime.parse(map['timestamp']),
          open: map['open'].toDouble(),
          high: map['high'].toDouble(),
          low: map['low'].toDouble(),
          close: map['close'].toDouble(),
          volume: map['volume'].toDouble(),
        ));
      });

      return result;
    } catch (e) {
      print('Error getting historical market data: $e');
      return [];
    }
  }

  // ==================== AI/ML DATA STORAGE ====================

  /// Store ML prediction results
  Future<void> storePrediction(
      String symbol, Map<String, dynamic> prediction) async {
    try {
      await _firestore.collection('predictions').add({
        'symbol': symbol,
        'prediction': prediction,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error storing prediction: $e');
    }
  }

  /// Store technical analysis results
  Future<void> storeTechnicalAnalysis(
      String symbol, Map<String, dynamic> analysis) async {
    try {
      await _firestore.collection('technical_analysis').doc(symbol).set({
        'symbol': symbol,
        'analysis': analysis,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error storing technical analysis: $e');
    }
  }

  /// Store pattern recognition results
  Future<void> storePatternRecognition(
      String symbol, List<String> patterns) async {
    try {
      await _firestore.collection('patterns').doc(symbol).set({
        'symbol': symbol,
        'patterns': patterns,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await logEvent('patterns_detected', {
        'symbol': symbol,
        'count': patterns.length,
      });
    } catch (e) {
      print('Error storing patterns: $e');
    }
  }

  // ==================== PORTFOLIO DATA ====================

  /// Store portfolio snapshot
  Future<void> storePortfolioSnapshot(Portfolio portfolio) async {
    try {
      await _firestore.collection('portfolio_history').add({
        'balance': portfolio.currentBalance,
        'equity': portfolio.equity,
        'margin': portfolio.margin,
        'freeMargin': portfolio.freeMargin,
        'profit': portfolio.netProfit,
        'openPositions': portfolio.openTrades.length,
        'totalTrades': portfolio.totalTrades,
        'winRate': portfolio.winRate,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error storing portfolio snapshot: $e');
    }
  }

  /// Get portfolio history
  Future<List<Map<String, dynamic>>> getPortfolioHistory(int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('portfolio_history')
          .where('timestamp', isGreaterThan: Timestamp.fromDate(startDate))
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting portfolio history: $e');
      return [];
    }
  }

  // ==================== PERFORMANCE METRICS ====================

  /// Store performance metrics
  Future<void> storePerformanceMetrics(Map<String, dynamic> metrics) async {
    try {
      await _firestore.collection('performance_metrics').add({
        ...metrics,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error storing performance metrics: $e');
    }
  }

  /// Get performance metrics
  Future<List<Map<String, dynamic>>> getPerformanceMetrics(int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      final snapshot = await _firestore
          .collection('performance_metrics')
          .where('timestamp', isGreaterThan: Timestamp.fromDate(startDate))
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting performance metrics: $e');
      return [];
    }
  }

  // ==================== RISK MANAGEMENT ====================

  /// Log risk event
  Future<void> logRiskEvent(String type, Map<String, dynamic> details) async {
    try {
      await _firestore.collection('risk_events').add({
        'type': type,
        'details': details,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await logEvent('risk_event', {
        'type': type,
        ...details,
      });
    } catch (e) {
      print('Error logging risk event: $e');
    }
  }

  // ==================== REAL-TIME SYNC ====================

  /// Listen to signal updates
  Stream<List<TradingSignal>> watchSignals({String? symbol}) {
    try {
      Query query = _firestore.collection('signals');

      if (symbol != null) {
        query = query.where('symbol', isEqualTo: symbol);
      }

      return query
          .orderBy('generatedAt', descending: true)
          .limit(50)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // Convert back to TradingSignal model
          // This is simplified - you'd need proper conversion
          return TradingSignal(
            id: data['id'],
            symbol: data['symbol'],
            type: SignalType.values.firstWhere(
              (e) => e.toString() == data['type'],
              orElse: () => SignalType.hold,
            ),
            strength: SignalStrength.values.firstWhere(
              (e) => e.toString() == data['strength'],
              orElse: () => SignalStrength.moderate,
            ),
            status: SignalStatus.values.firstWhere(
              (e) => e.toString() == data['status'],
              orElse: () => SignalStatus.pending,
            ),
            generatedAt: DateTime.parse(data['generatedAt']),
            primaryTimeframe: TimeframeType.H1, // Default
            confirmationTimeframe: TimeframeType.M15, // Default
            entryPrice: data['entryPrice'],
            stopLoss: data['stopLoss'],
            takeProfit: data['takeProfit'],
            confidenceScore: data['confidenceScore'],
            indicators: List<String>.from(data['indicators'] ?? []),
            technicalAnalysis: Map<String, dynamic>.from(data['technicalAnalysis'] ?? {}),
          );
        }).toList();
      });
    } catch (e) {
      print('Error watching signals: $e');
      return Stream.value([]);
    }
  }

  /// Listen to trade updates
  Stream<List<Trade>> watchTrades({String? symbol}) {
    try {
      Query query = _firestore.collection('trades');

      if (symbol != null) {
        query = query.where('symbol', isEqualTo: symbol);
      }

      return query
          .orderBy('entryTime', descending: true)
          .limit(100)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Trade(
            id: data['id'],
            symbol: data['symbol'],
            type: SignalType.values.firstWhere(
              (e) => e.toString() == data['type'],
              orElse: () => SignalType.buy,
            ),
            status: TradeStatus.values.firstWhere(
              (e) => e.toString() == data['status'],
              orElse: () => TradeStatus.open,
            ),
            entryPrice: data['entryPrice'],
            exitPrice: data['exitPrice'],
            stopLoss: data['stopLoss'],
            takeProfit: data['takeProfit'],
            lotSize: data['lotSize'] ?? 0.01,
            profitLoss: data['profitLoss'],
            openedAt: DateTime.parse(data['openedAt']),
            closedAt: data['closedAt'] != null
                ? DateTime.parse(data['closedAt'])
                : null,
          );
        }).toList();
      });
    } catch (e) {
      print('Error watching trades: $e');
      return Stream.value([]);
    }
  }
}
