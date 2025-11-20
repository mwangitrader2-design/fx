// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Trade _$TradeFromJson(Map<String, dynamic> json) {
  return _Trade.fromJson(json);
}

/// @nodoc
mixin _$Trade {
  String get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  SignalType get type => throw _privateConstructorUsedError;
  TradeStatus get status => throw _privateConstructorUsedError;
  double get entryPrice => throw _privateConstructorUsedError;
  double get lotSize => throw _privateConstructorUsedError;
  double get stopLoss => throw _privateConstructorUsedError;
  double get takeProfit => throw _privateConstructorUsedError;
  DateTime get openedAt => throw _privateConstructorUsedError;
  String? get signalId => throw _privateConstructorUsedError;
  double? get exitPrice => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  double? get profitLoss => throw _privateConstructorUsedError;
  double? get profitLossPercentage => throw _privateConstructorUsedError;
  TradeResult? get result => throw _privateConstructorUsedError;
  String? get closeReason => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  double get unrealizedPL => throw _privateConstructorUsedError;

  /// Serializes this Trade to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Trade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeCopyWith<Trade> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeCopyWith<$Res> {
  factory $TradeCopyWith(Trade value, $Res Function(Trade) then) =
      _$TradeCopyWithImpl<$Res, Trade>;
  @useResult
  $Res call(
      {String id,
      String symbol,
      SignalType type,
      TradeStatus status,
      double entryPrice,
      double lotSize,
      double stopLoss,
      double takeProfit,
      DateTime openedAt,
      String? signalId,
      double? exitPrice,
      DateTime? closedAt,
      double? profitLoss,
      double? profitLossPercentage,
      TradeResult? result,
      String? closeReason,
      double currentPrice,
      double unrealizedPL});
}

/// @nodoc
class _$TradeCopyWithImpl<$Res, $Val extends Trade>
    implements $TradeCopyWith<$Res> {
  _$TradeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Trade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? type = null,
    Object? status = null,
    Object? entryPrice = null,
    Object? lotSize = null,
    Object? stopLoss = null,
    Object? takeProfit = null,
    Object? openedAt = null,
    Object? signalId = freezed,
    Object? exitPrice = freezed,
    Object? closedAt = freezed,
    Object? profitLoss = freezed,
    Object? profitLossPercentage = freezed,
    Object? result = freezed,
    Object? closeReason = freezed,
    Object? currentPrice = null,
    Object? unrealizedPL = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TradeStatus,
      entryPrice: null == entryPrice
          ? _value.entryPrice
          : entryPrice // ignore: cast_nullable_to_non_nullable
              as double,
      lotSize: null == lotSize
          ? _value.lotSize
          : lotSize // ignore: cast_nullable_to_non_nullable
              as double,
      stopLoss: null == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double,
      takeProfit: null == takeProfit
          ? _value.takeProfit
          : takeProfit // ignore: cast_nullable_to_non_nullable
              as double,
      openedAt: null == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      signalId: freezed == signalId
          ? _value.signalId
          : signalId // ignore: cast_nullable_to_non_nullable
              as String?,
      exitPrice: freezed == exitPrice
          ? _value.exitPrice
          : exitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profitLoss: freezed == profitLoss
          ? _value.profitLoss
          : profitLoss // ignore: cast_nullable_to_non_nullable
              as double?,
      profitLossPercentage: freezed == profitLossPercentage
          ? _value.profitLossPercentage
          : profitLossPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as TradeResult?,
      closeReason: freezed == closeReason
          ? _value.closeReason
          : closeReason // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      unrealizedPL: null == unrealizedPL
          ? _value.unrealizedPL
          : unrealizedPL // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeImplCopyWith<$Res> implements $TradeCopyWith<$Res> {
  factory _$$TradeImplCopyWith(
          _$TradeImpl value, $Res Function(_$TradeImpl) then) =
      __$$TradeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String symbol,
      SignalType type,
      TradeStatus status,
      double entryPrice,
      double lotSize,
      double stopLoss,
      double takeProfit,
      DateTime openedAt,
      String? signalId,
      double? exitPrice,
      DateTime? closedAt,
      double? profitLoss,
      double? profitLossPercentage,
      TradeResult? result,
      String? closeReason,
      double currentPrice,
      double unrealizedPL});
}

/// @nodoc
class __$$TradeImplCopyWithImpl<$Res>
    extends _$TradeCopyWithImpl<$Res, _$TradeImpl>
    implements _$$TradeImplCopyWith<$Res> {
  __$$TradeImplCopyWithImpl(
      _$TradeImpl _value, $Res Function(_$TradeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Trade
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? type = null,
    Object? status = null,
    Object? entryPrice = null,
    Object? lotSize = null,
    Object? stopLoss = null,
    Object? takeProfit = null,
    Object? openedAt = null,
    Object? signalId = freezed,
    Object? exitPrice = freezed,
    Object? closedAt = freezed,
    Object? profitLoss = freezed,
    Object? profitLossPercentage = freezed,
    Object? result = freezed,
    Object? closeReason = freezed,
    Object? currentPrice = null,
    Object? unrealizedPL = null,
  }) {
    return _then(_$TradeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SignalType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TradeStatus,
      entryPrice: null == entryPrice
          ? _value.entryPrice
          : entryPrice // ignore: cast_nullable_to_non_nullable
              as double,
      lotSize: null == lotSize
          ? _value.lotSize
          : lotSize // ignore: cast_nullable_to_non_nullable
              as double,
      stopLoss: null == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double,
      takeProfit: null == takeProfit
          ? _value.takeProfit
          : takeProfit // ignore: cast_nullable_to_non_nullable
              as double,
      openedAt: null == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      signalId: freezed == signalId
          ? _value.signalId
          : signalId // ignore: cast_nullable_to_non_nullable
              as String?,
      exitPrice: freezed == exitPrice
          ? _value.exitPrice
          : exitPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      profitLoss: freezed == profitLoss
          ? _value.profitLoss
          : profitLoss // ignore: cast_nullable_to_non_nullable
              as double?,
      profitLossPercentage: freezed == profitLossPercentage
          ? _value.profitLossPercentage
          : profitLossPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as TradeResult?,
      closeReason: freezed == closeReason
          ? _value.closeReason
          : closeReason // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      unrealizedPL: null == unrealizedPL
          ? _value.unrealizedPL
          : unrealizedPL // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeImpl implements _Trade {
  const _$TradeImpl(
      {required this.id,
      required this.symbol,
      required this.type,
      required this.status,
      required this.entryPrice,
      required this.lotSize,
      required this.stopLoss,
      required this.takeProfit,
      required this.openedAt,
      this.signalId,
      this.exitPrice,
      this.closedAt,
      this.profitLoss,
      this.profitLossPercentage,
      this.result,
      this.closeReason,
      this.currentPrice = 0,
      this.unrealizedPL = 0});

  factory _$TradeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeImplFromJson(json);

  @override
  final String id;
  @override
  final String symbol;
  @override
  final SignalType type;
  @override
  final TradeStatus status;
  @override
  final double entryPrice;
  @override
  final double lotSize;
  @override
  final double stopLoss;
  @override
  final double takeProfit;
  @override
  final DateTime openedAt;
  @override
  final String? signalId;
  @override
  final double? exitPrice;
  @override
  final DateTime? closedAt;
  @override
  final double? profitLoss;
  @override
  final double? profitLossPercentage;
  @override
  final TradeResult? result;
  @override
  final String? closeReason;
  @override
  @JsonKey()
  final double currentPrice;
  @override
  @JsonKey()
  final double unrealizedPL;

  @override
  String toString() {
    return 'Trade(id: $id, symbol: $symbol, type: $type, status: $status, entryPrice: $entryPrice, lotSize: $lotSize, stopLoss: $stopLoss, takeProfit: $takeProfit, openedAt: $openedAt, signalId: $signalId, exitPrice: $exitPrice, closedAt: $closedAt, profitLoss: $profitLoss, profitLossPercentage: $profitLossPercentage, result: $result, closeReason: $closeReason, currentPrice: $currentPrice, unrealizedPL: $unrealizedPL)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.entryPrice, entryPrice) ||
                other.entryPrice == entryPrice) &&
            (identical(other.lotSize, lotSize) || other.lotSize == lotSize) &&
            (identical(other.stopLoss, stopLoss) ||
                other.stopLoss == stopLoss) &&
            (identical(other.takeProfit, takeProfit) ||
                other.takeProfit == takeProfit) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.signalId, signalId) ||
                other.signalId == signalId) &&
            (identical(other.exitPrice, exitPrice) ||
                other.exitPrice == exitPrice) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.profitLoss, profitLoss) ||
                other.profitLoss == profitLoss) &&
            (identical(other.profitLossPercentage, profitLossPercentage) ||
                other.profitLossPercentage == profitLossPercentage) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.closeReason, closeReason) ||
                other.closeReason == closeReason) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.unrealizedPL, unrealizedPL) ||
                other.unrealizedPL == unrealizedPL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      symbol,
      type,
      status,
      entryPrice,
      lotSize,
      stopLoss,
      takeProfit,
      openedAt,
      signalId,
      exitPrice,
      closedAt,
      profitLoss,
      profitLossPercentage,
      result,
      closeReason,
      currentPrice,
      unrealizedPL);

  /// Create a copy of Trade
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeImplCopyWith<_$TradeImpl> get copyWith =>
      __$$TradeImplCopyWithImpl<_$TradeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeImplToJson(
      this,
    );
  }
}

abstract class _Trade implements Trade {
  const factory _Trade(
      {required final String id,
      required final String symbol,
      required final SignalType type,
      required final TradeStatus status,
      required final double entryPrice,
      required final double lotSize,
      required final double stopLoss,
      required final double takeProfit,
      required final DateTime openedAt,
      final String? signalId,
      final double? exitPrice,
      final DateTime? closedAt,
      final double? profitLoss,
      final double? profitLossPercentage,
      final TradeResult? result,
      final String? closeReason,
      final double currentPrice,
      final double unrealizedPL}) = _$TradeImpl;

  factory _Trade.fromJson(Map<String, dynamic> json) = _$TradeImpl.fromJson;

  @override
  String get id;
  @override
  String get symbol;
  @override
  SignalType get type;
  @override
  TradeStatus get status;
  @override
  double get entryPrice;
  @override
  double get lotSize;
  @override
  double get stopLoss;
  @override
  double get takeProfit;
  @override
  DateTime get openedAt;
  @override
  String? get signalId;
  @override
  double? get exitPrice;
  @override
  DateTime? get closedAt;
  @override
  double? get profitLoss;
  @override
  double? get profitLossPercentage;
  @override
  TradeResult? get result;
  @override
  String? get closeReason;
  @override
  double get currentPrice;
  @override
  double get unrealizedPL;

  /// Create a copy of Trade
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeImplCopyWith<_$TradeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TradeHistory _$TradeHistoryFromJson(Map<String, dynamic> json) {
  return _TradeHistory.fromJson(json);
}

/// @nodoc
mixin _$TradeHistory {
  String get id => throw _privateConstructorUsedError;
  List<Trade> get trades => throw _privateConstructorUsedError;
  double get totalProfit => throw _privateConstructorUsedError;
  double get totalLoss => throw _privateConstructorUsedError;
  double get netProfit => throw _privateConstructorUsedError;
  int get winningTrades => throw _privateConstructorUsedError;
  int get losingTrades => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  double get averageWin => throw _privateConstructorUsedError;
  double get averageLoss => throw _privateConstructorUsedError;
  double get profitFactor => throw _privateConstructorUsedError;
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;

  /// Serializes this TradeHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradeHistoryCopyWith<TradeHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeHistoryCopyWith<$Res> {
  factory $TradeHistoryCopyWith(
          TradeHistory value, $Res Function(TradeHistory) then) =
      _$TradeHistoryCopyWithImpl<$Res, TradeHistory>;
  @useResult
  $Res call(
      {String id,
      List<Trade> trades,
      double totalProfit,
      double totalLoss,
      double netProfit,
      int winningTrades,
      int losingTrades,
      double winRate,
      double averageWin,
      double averageLoss,
      double profitFactor,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class _$TradeHistoryCopyWithImpl<$Res, $Val extends TradeHistory>
    implements $TradeHistoryCopyWith<$Res> {
  _$TradeHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? trades = null,
    Object? totalProfit = null,
    Object? totalLoss = null,
    Object? netProfit = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? averageWin = null,
    Object? averageLoss = null,
    Object? profitFactor = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      trades: null == trades
          ? _value.trades
          : trades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoss: null == totalLoss
          ? _value.totalLoss
          : totalLoss // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
      winningTrades: null == winningTrades
          ? _value.winningTrades
          : winningTrades // ignore: cast_nullable_to_non_nullable
              as int,
      losingTrades: null == losingTrades
          ? _value.losingTrades
          : losingTrades // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageWin: null == averageWin
          ? _value.averageWin
          : averageWin // ignore: cast_nullable_to_non_nullable
              as double,
      averageLoss: null == averageLoss
          ? _value.averageLoss
          : averageLoss // ignore: cast_nullable_to_non_nullable
              as double,
      profitFactor: null == profitFactor
          ? _value.profitFactor
          : profitFactor // ignore: cast_nullable_to_non_nullable
              as double,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeHistoryImplCopyWith<$Res>
    implements $TradeHistoryCopyWith<$Res> {
  factory _$$TradeHistoryImplCopyWith(
          _$TradeHistoryImpl value, $Res Function(_$TradeHistoryImpl) then) =
      __$$TradeHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<Trade> trades,
      double totalProfit,
      double totalLoss,
      double netProfit,
      int winningTrades,
      int losingTrades,
      double winRate,
      double averageWin,
      double averageLoss,
      double profitFactor,
      DateTime periodStart,
      DateTime periodEnd});
}

/// @nodoc
class __$$TradeHistoryImplCopyWithImpl<$Res>
    extends _$TradeHistoryCopyWithImpl<$Res, _$TradeHistoryImpl>
    implements _$$TradeHistoryImplCopyWith<$Res> {
  __$$TradeHistoryImplCopyWithImpl(
      _$TradeHistoryImpl _value, $Res Function(_$TradeHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? trades = null,
    Object? totalProfit = null,
    Object? totalLoss = null,
    Object? netProfit = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? averageWin = null,
    Object? averageLoss = null,
    Object? profitFactor = null,
    Object? periodStart = null,
    Object? periodEnd = null,
  }) {
    return _then(_$TradeHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      trades: null == trades
          ? _value._trades
          : trades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as double,
      totalLoss: null == totalLoss
          ? _value.totalLoss
          : totalLoss // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
      winningTrades: null == winningTrades
          ? _value.winningTrades
          : winningTrades // ignore: cast_nullable_to_non_nullable
              as int,
      losingTrades: null == losingTrades
          ? _value.losingTrades
          : losingTrades // ignore: cast_nullable_to_non_nullable
              as int,
      winRate: null == winRate
          ? _value.winRate
          : winRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageWin: null == averageWin
          ? _value.averageWin
          : averageWin // ignore: cast_nullable_to_non_nullable
              as double,
      averageLoss: null == averageLoss
          ? _value.averageLoss
          : averageLoss // ignore: cast_nullable_to_non_nullable
              as double,
      profitFactor: null == profitFactor
          ? _value.profitFactor
          : profitFactor // ignore: cast_nullable_to_non_nullable
              as double,
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeHistoryImpl implements _TradeHistory {
  const _$TradeHistoryImpl(
      {required this.id,
      required final List<Trade> trades,
      required this.totalProfit,
      required this.totalLoss,
      required this.netProfit,
      required this.winningTrades,
      required this.losingTrades,
      required this.winRate,
      required this.averageWin,
      required this.averageLoss,
      required this.profitFactor,
      required this.periodStart,
      required this.periodEnd})
      : _trades = trades;

  factory _$TradeHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeHistoryImplFromJson(json);

  @override
  final String id;
  final List<Trade> _trades;
  @override
  List<Trade> get trades {
    if (_trades is EqualUnmodifiableListView) return _trades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trades);
  }

  @override
  final double totalProfit;
  @override
  final double totalLoss;
  @override
  final double netProfit;
  @override
  final int winningTrades;
  @override
  final int losingTrades;
  @override
  final double winRate;
  @override
  final double averageWin;
  @override
  final double averageLoss;
  @override
  final double profitFactor;
  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;

  @override
  String toString() {
    return 'TradeHistory(id: $id, trades: $trades, totalProfit: $totalProfit, totalLoss: $totalLoss, netProfit: $netProfit, winningTrades: $winningTrades, losingTrades: $losingTrades, winRate: $winRate, averageWin: $averageWin, averageLoss: $averageLoss, profitFactor: $profitFactor, periodStart: $periodStart, periodEnd: $periodEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._trades, _trades) &&
            (identical(other.totalProfit, totalProfit) ||
                other.totalProfit == totalProfit) &&
            (identical(other.totalLoss, totalLoss) ||
                other.totalLoss == totalLoss) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.winningTrades, winningTrades) ||
                other.winningTrades == winningTrades) &&
            (identical(other.losingTrades, losingTrades) ||
                other.losingTrades == losingTrades) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.averageWin, averageWin) ||
                other.averageWin == averageWin) &&
            (identical(other.averageLoss, averageLoss) ||
                other.averageLoss == averageLoss) &&
            (identical(other.profitFactor, profitFactor) ||
                other.profitFactor == profitFactor) &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_trades),
      totalProfit,
      totalLoss,
      netProfit,
      winningTrades,
      losingTrades,
      winRate,
      averageWin,
      averageLoss,
      profitFactor,
      periodStart,
      periodEnd);

  /// Create a copy of TradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeHistoryImplCopyWith<_$TradeHistoryImpl> get copyWith =>
      __$$TradeHistoryImplCopyWithImpl<_$TradeHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeHistoryImplToJson(
      this,
    );
  }
}

abstract class _TradeHistory implements TradeHistory {
  const factory _TradeHistory(
      {required final String id,
      required final List<Trade> trades,
      required final double totalProfit,
      required final double totalLoss,
      required final double netProfit,
      required final int winningTrades,
      required final int losingTrades,
      required final double winRate,
      required final double averageWin,
      required final double averageLoss,
      required final double profitFactor,
      required final DateTime periodStart,
      required final DateTime periodEnd}) = _$TradeHistoryImpl;

  factory _TradeHistory.fromJson(Map<String, dynamic> json) =
      _$TradeHistoryImpl.fromJson;

  @override
  String get id;
  @override
  List<Trade> get trades;
  @override
  double get totalProfit;
  @override
  double get totalLoss;
  @override
  double get netProfit;
  @override
  int get winningTrades;
  @override
  int get losingTrades;
  @override
  double get winRate;
  @override
  double get averageWin;
  @override
  double get averageLoss;
  @override
  double get profitFactor;
  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;

  /// Create a copy of TradeHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradeHistoryImplCopyWith<_$TradeHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
