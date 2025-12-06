import 'package:flutter/foundation.dart';

/// Global holder for the latest MT5 account snapshot so multiple pages stay in sync.
class AccountState extends ChangeNotifier {
  AccountState._();

  static final AccountState instance = AccountState._();

  Map<String, dynamic>? _accountInfo;

  Map<String, dynamic>? get accountInfo => _accountInfo;
  double get balance => (_accountInfo?['balance'] ?? 0).toDouble();
  double get equity => (_accountInfo?['equity'] ?? 0).toDouble();
  bool get isConnected => _accountInfo != null;

  /// Replace the current snapshot and notify listeners.
  void updateFromAccountInfo(Map<String, dynamic> info) {
    _accountInfo = Map<String, dynamic>.from(info);
    notifyListeners();
  }

  /// Merge partial updates (e.g., only balance changed) into existing snapshot.
  void mergeAccountInfo(Map<String, dynamic> info) {
    final current =
        Map<String, dynamic>.from(_accountInfo ?? <String, dynamic>{});
    current.addAll(info);
    _accountInfo = current;
    notifyListeners();
  }

  void clear() {
    _accountInfo = null;
    notifyListeners();
  }
}
