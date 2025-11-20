// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Portfolio _$PortfolioFromJson(Map<String, dynamic> json) {
  return _Portfolio.fromJson(json);
}

/// @nodoc
mixin _$Portfolio {
  String get id => throw _privateConstructorUsedError;
  double get initialBalance => throw _privateConstructorUsedError;
  double get currentBalance => throw _privateConstructorUsedError;
  double get totalProfit => throw _privateConstructorUsedError;
  double get totalLoss => throw _privateConstructorUsedError;
  double get netProfit => throw _privateConstructorUsedError;
  double get profitPercentage => throw _privateConstructorUsedError;
  int get totalTrades => throw _privateConstructorUsedError;
  int get winningTrades => throw _privateConstructorUsedError;
  int get losingTrades => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  List<Trade> get openTrades => throw _privateConstructorUsedError;
  List<Trade> get closedTrades => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  double get equity => throw _privateConstructorUsedError;
  double get margin => throw _privateConstructorUsedError;
  double get freeMargin => throw _privateConstructorUsedError;
  double get marginLevel => throw _privateConstructorUsedError;
  double get unrealizedPL => throw _privateConstructorUsedError;

  /// Serializes this Portfolio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioCopyWith<Portfolio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioCopyWith<$Res> {
  factory $PortfolioCopyWith(Portfolio value, $Res Function(Portfolio) then) =
      _$PortfolioCopyWithImpl<$Res, Portfolio>;
  @useResult
  $Res call(
      {String id,
      double initialBalance,
      double currentBalance,
      double totalProfit,
      double totalLoss,
      double netProfit,
      double profitPercentage,
      int totalTrades,
      int winningTrades,
      int losingTrades,
      double winRate,
      List<Trade> openTrades,
      List<Trade> closedTrades,
      DateTime createdAt,
      DateTime updatedAt,
      double equity,
      double margin,
      double freeMargin,
      double marginLevel,
      double unrealizedPL});
}

/// @nodoc
class _$PortfolioCopyWithImpl<$Res, $Val extends Portfolio>
    implements $PortfolioCopyWith<$Res> {
  _$PortfolioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? initialBalance = null,
    Object? currentBalance = null,
    Object? totalProfit = null,
    Object? totalLoss = null,
    Object? netProfit = null,
    Object? profitPercentage = null,
    Object? totalTrades = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? openTrades = null,
    Object? closedTrades = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? equity = null,
    Object? margin = null,
    Object? freeMargin = null,
    Object? marginLevel = null,
    Object? unrealizedPL = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      initialBalance: null == initialBalance
          ? _value.initialBalance
          : initialBalance // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
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
      profitPercentage: null == profitPercentage
          ? _value.profitPercentage
          : profitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      totalTrades: null == totalTrades
          ? _value.totalTrades
          : totalTrades // ignore: cast_nullable_to_non_nullable
              as int,
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
      openTrades: null == openTrades
          ? _value.openTrades
          : openTrades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      closedTrades: null == closedTrades
          ? _value.closedTrades
          : closedTrades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      freeMargin: null == freeMargin
          ? _value.freeMargin
          : freeMargin // ignore: cast_nullable_to_non_nullable
              as double,
      marginLevel: null == marginLevel
          ? _value.marginLevel
          : marginLevel // ignore: cast_nullable_to_non_nullable
              as double,
      unrealizedPL: null == unrealizedPL
          ? _value.unrealizedPL
          : unrealizedPL // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioImplCopyWith<$Res>
    implements $PortfolioCopyWith<$Res> {
  factory _$$PortfolioImplCopyWith(
          _$PortfolioImpl value, $Res Function(_$PortfolioImpl) then) =
      __$$PortfolioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double initialBalance,
      double currentBalance,
      double totalProfit,
      double totalLoss,
      double netProfit,
      double profitPercentage,
      int totalTrades,
      int winningTrades,
      int losingTrades,
      double winRate,
      List<Trade> openTrades,
      List<Trade> closedTrades,
      DateTime createdAt,
      DateTime updatedAt,
      double equity,
      double margin,
      double freeMargin,
      double marginLevel,
      double unrealizedPL});
}

/// @nodoc
class __$$PortfolioImplCopyWithImpl<$Res>
    extends _$PortfolioCopyWithImpl<$Res, _$PortfolioImpl>
    implements _$$PortfolioImplCopyWith<$Res> {
  __$$PortfolioImplCopyWithImpl(
      _$PortfolioImpl _value, $Res Function(_$PortfolioImpl) _then)
      : super(_value, _then);

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? initialBalance = null,
    Object? currentBalance = null,
    Object? totalProfit = null,
    Object? totalLoss = null,
    Object? netProfit = null,
    Object? profitPercentage = null,
    Object? totalTrades = null,
    Object? winningTrades = null,
    Object? losingTrades = null,
    Object? winRate = null,
    Object? openTrades = null,
    Object? closedTrades = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? equity = null,
    Object? margin = null,
    Object? freeMargin = null,
    Object? marginLevel = null,
    Object? unrealizedPL = null,
  }) {
    return _then(_$PortfolioImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      initialBalance: null == initialBalance
          ? _value.initialBalance
          : initialBalance // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
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
      profitPercentage: null == profitPercentage
          ? _value.profitPercentage
          : profitPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      totalTrades: null == totalTrades
          ? _value.totalTrades
          : totalTrades // ignore: cast_nullable_to_non_nullable
              as int,
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
      openTrades: null == openTrades
          ? _value._openTrades
          : openTrades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      closedTrades: null == closedTrades
          ? _value._closedTrades
          : closedTrades // ignore: cast_nullable_to_non_nullable
              as List<Trade>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
      margin: null == margin
          ? _value.margin
          : margin // ignore: cast_nullable_to_non_nullable
              as double,
      freeMargin: null == freeMargin
          ? _value.freeMargin
          : freeMargin // ignore: cast_nullable_to_non_nullable
              as double,
      marginLevel: null == marginLevel
          ? _value.marginLevel
          : marginLevel // ignore: cast_nullable_to_non_nullable
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
class _$PortfolioImpl implements _Portfolio {
  const _$PortfolioImpl(
      {required this.id,
      required this.initialBalance,
      required this.currentBalance,
      required this.totalProfit,
      required this.totalLoss,
      required this.netProfit,
      required this.profitPercentage,
      required this.totalTrades,
      required this.winningTrades,
      required this.losingTrades,
      required this.winRate,
      required final List<Trade> openTrades,
      required final List<Trade> closedTrades,
      required this.createdAt,
      required this.updatedAt,
      this.equity = 0,
      this.margin = 0,
      this.freeMargin = 0,
      this.marginLevel = 0,
      this.unrealizedPL = 0})
      : _openTrades = openTrades,
        _closedTrades = closedTrades;

  factory _$PortfolioImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioImplFromJson(json);

  @override
  final String id;
  @override
  final double initialBalance;
  @override
  final double currentBalance;
  @override
  final double totalProfit;
  @override
  final double totalLoss;
  @override
  final double netProfit;
  @override
  final double profitPercentage;
  @override
  final int totalTrades;
  @override
  final int winningTrades;
  @override
  final int losingTrades;
  @override
  final double winRate;
  final List<Trade> _openTrades;
  @override
  List<Trade> get openTrades {
    if (_openTrades is EqualUnmodifiableListView) return _openTrades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_openTrades);
  }

  final List<Trade> _closedTrades;
  @override
  List<Trade> get closedTrades {
    if (_closedTrades is EqualUnmodifiableListView) return _closedTrades;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_closedTrades);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final double equity;
  @override
  @JsonKey()
  final double margin;
  @override
  @JsonKey()
  final double freeMargin;
  @override
  @JsonKey()
  final double marginLevel;
  @override
  @JsonKey()
  final double unrealizedPL;

  @override
  String toString() {
    return 'Portfolio(id: $id, initialBalance: $initialBalance, currentBalance: $currentBalance, totalProfit: $totalProfit, totalLoss: $totalLoss, netProfit: $netProfit, profitPercentage: $profitPercentage, totalTrades: $totalTrades, winningTrades: $winningTrades, losingTrades: $losingTrades, winRate: $winRate, openTrades: $openTrades, closedTrades: $closedTrades, createdAt: $createdAt, updatedAt: $updatedAt, equity: $equity, margin: $margin, freeMargin: $freeMargin, marginLevel: $marginLevel, unrealizedPL: $unrealizedPL)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.initialBalance, initialBalance) ||
                other.initialBalance == initialBalance) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.totalProfit, totalProfit) ||
                other.totalProfit == totalProfit) &&
            (identical(other.totalLoss, totalLoss) ||
                other.totalLoss == totalLoss) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.profitPercentage, profitPercentage) ||
                other.profitPercentage == profitPercentage) &&
            (identical(other.totalTrades, totalTrades) ||
                other.totalTrades == totalTrades) &&
            (identical(other.winningTrades, winningTrades) ||
                other.winningTrades == winningTrades) &&
            (identical(other.losingTrades, losingTrades) ||
                other.losingTrades == losingTrades) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            const DeepCollectionEquality()
                .equals(other._openTrades, _openTrades) &&
            const DeepCollectionEquality()
                .equals(other._closedTrades, _closedTrades) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.equity, equity) || other.equity == equity) &&
            (identical(other.margin, margin) || other.margin == margin) &&
            (identical(other.freeMargin, freeMargin) ||
                other.freeMargin == freeMargin) &&
            (identical(other.marginLevel, marginLevel) ||
                other.marginLevel == marginLevel) &&
            (identical(other.unrealizedPL, unrealizedPL) ||
                other.unrealizedPL == unrealizedPL));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        initialBalance,
        currentBalance,
        totalProfit,
        totalLoss,
        netProfit,
        profitPercentage,
        totalTrades,
        winningTrades,
        losingTrades,
        winRate,
        const DeepCollectionEquality().hash(_openTrades),
        const DeepCollectionEquality().hash(_closedTrades),
        createdAt,
        updatedAt,
        equity,
        margin,
        freeMargin,
        marginLevel,
        unrealizedPL
      ]);

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioImplCopyWith<_$PortfolioImpl> get copyWith =>
      __$$PortfolioImplCopyWithImpl<_$PortfolioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioImplToJson(
      this,
    );
  }
}

abstract class _Portfolio implements Portfolio {
  const factory _Portfolio(
      {required final String id,
      required final double initialBalance,
      required final double currentBalance,
      required final double totalProfit,
      required final double totalLoss,
      required final double netProfit,
      required final double profitPercentage,
      required final int totalTrades,
      required final int winningTrades,
      required final int losingTrades,
      required final double winRate,
      required final List<Trade> openTrades,
      required final List<Trade> closedTrades,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final double equity,
      final double margin,
      final double freeMargin,
      final double marginLevel,
      final double unrealizedPL}) = _$PortfolioImpl;

  factory _Portfolio.fromJson(Map<String, dynamic> json) =
      _$PortfolioImpl.fromJson;

  @override
  String get id;
  @override
  double get initialBalance;
  @override
  double get currentBalance;
  @override
  double get totalProfit;
  @override
  double get totalLoss;
  @override
  double get netProfit;
  @override
  double get profitPercentage;
  @override
  int get totalTrades;
  @override
  int get winningTrades;
  @override
  int get losingTrades;
  @override
  double get winRate;
  @override
  List<Trade> get openTrades;
  @override
  List<Trade> get closedTrades;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  double get equity;
  @override
  double get margin;
  @override
  double get freeMargin;
  @override
  double get marginLevel;
  @override
  double get unrealizedPL;

  /// Create a copy of Portfolio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioImplCopyWith<_$PortfolioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PortfolioPerformance _$PortfolioPerformanceFromJson(Map<String, dynamic> json) {
  return _PortfolioPerformance.fromJson(json);
}

/// @nodoc
mixin _$PortfolioPerformance {
  DateTime get date => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  double get equity => throw _privateConstructorUsedError;
  double get profit => throw _privateConstructorUsedError;
  double get drawdown => throw _privateConstructorUsedError;
  int get tradesCount => throw _privateConstructorUsedError;

  /// Serializes this PortfolioPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioPerformanceCopyWith<PortfolioPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioPerformanceCopyWith<$Res> {
  factory $PortfolioPerformanceCopyWith(PortfolioPerformance value,
          $Res Function(PortfolioPerformance) then) =
      _$PortfolioPerformanceCopyWithImpl<$Res, PortfolioPerformance>;
  @useResult
  $Res call(
      {DateTime date,
      double balance,
      double equity,
      double profit,
      double drawdown,
      int tradesCount});
}

/// @nodoc
class _$PortfolioPerformanceCopyWithImpl<$Res,
        $Val extends PortfolioPerformance>
    implements $PortfolioPerformanceCopyWith<$Res> {
  _$PortfolioPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? balance = null,
    Object? equity = null,
    Object? profit = null,
    Object? drawdown = null,
    Object? tradesCount = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
      drawdown: null == drawdown
          ? _value.drawdown
          : drawdown // ignore: cast_nullable_to_non_nullable
              as double,
      tradesCount: null == tradesCount
          ? _value.tradesCount
          : tradesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioPerformanceImplCopyWith<$Res>
    implements $PortfolioPerformanceCopyWith<$Res> {
  factory _$$PortfolioPerformanceImplCopyWith(_$PortfolioPerformanceImpl value,
          $Res Function(_$PortfolioPerformanceImpl) then) =
      __$$PortfolioPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      double balance,
      double equity,
      double profit,
      double drawdown,
      int tradesCount});
}

/// @nodoc
class __$$PortfolioPerformanceImplCopyWithImpl<$Res>
    extends _$PortfolioPerformanceCopyWithImpl<$Res, _$PortfolioPerformanceImpl>
    implements _$$PortfolioPerformanceImplCopyWith<$Res> {
  __$$PortfolioPerformanceImplCopyWithImpl(_$PortfolioPerformanceImpl _value,
      $Res Function(_$PortfolioPerformanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? balance = null,
    Object? equity = null,
    Object? profit = null,
    Object? drawdown = null,
    Object? tradesCount = null,
  }) {
    return _then(_$PortfolioPerformanceImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      equity: null == equity
          ? _value.equity
          : equity // ignore: cast_nullable_to_non_nullable
              as double,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as double,
      drawdown: null == drawdown
          ? _value.drawdown
          : drawdown // ignore: cast_nullable_to_non_nullable
              as double,
      tradesCount: null == tradesCount
          ? _value.tradesCount
          : tradesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioPerformanceImpl implements _PortfolioPerformance {
  const _$PortfolioPerformanceImpl(
      {required this.date,
      required this.balance,
      required this.equity,
      required this.profit,
      required this.drawdown,
      required this.tradesCount});

  factory _$PortfolioPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioPerformanceImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double balance;
  @override
  final double equity;
  @override
  final double profit;
  @override
  final double drawdown;
  @override
  final int tradesCount;

  @override
  String toString() {
    return 'PortfolioPerformance(date: $date, balance: $balance, equity: $equity, profit: $profit, drawdown: $drawdown, tradesCount: $tradesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioPerformanceImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.equity, equity) || other.equity == equity) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            (identical(other.drawdown, drawdown) ||
                other.drawdown == drawdown) &&
            (identical(other.tradesCount, tradesCount) ||
                other.tradesCount == tradesCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, balance, equity, profit, drawdown, tradesCount);

  /// Create a copy of PortfolioPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioPerformanceImplCopyWith<_$PortfolioPerformanceImpl>
      get copyWith =>
          __$$PortfolioPerformanceImplCopyWithImpl<_$PortfolioPerformanceImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioPerformanceImplToJson(
      this,
    );
  }
}

abstract class _PortfolioPerformance implements PortfolioPerformance {
  const factory _PortfolioPerformance(
      {required final DateTime date,
      required final double balance,
      required final double equity,
      required final double profit,
      required final double drawdown,
      required final int tradesCount}) = _$PortfolioPerformanceImpl;

  factory _PortfolioPerformance.fromJson(Map<String, dynamic> json) =
      _$PortfolioPerformanceImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get balance;
  @override
  double get equity;
  @override
  double get profit;
  @override
  double get drawdown;
  @override
  int get tradesCount;

  /// Create a copy of PortfolioPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioPerformanceImplCopyWith<_$PortfolioPerformanceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PortfolioStats _$PortfolioStatsFromJson(Map<String, dynamic> json) {
  return _PortfolioStats.fromJson(json);
}

/// @nodoc
mixin _$PortfolioStats {
  double get sharpeRatio => throw _privateConstructorUsedError;
  double get sortinoRatio => throw _privateConstructorUsedError;
  double get maxDrawdown => throw _privateConstructorUsedError;
  double get averageDrawdown => throw _privateConstructorUsedError;
  double get recoveryFactor => throw _privateConstructorUsedError;
  double get profitFactor => throw _privateConstructorUsedError;
  double get expectancy => throw _privateConstructorUsedError;
  double get averageWin => throw _privateConstructorUsedError;
  double get averageLoss => throw _privateConstructorUsedError;
  double get largestWin => throw _privateConstructorUsedError;
  double get largestLoss => throw _privateConstructorUsedError;
  int get consecutiveWins => throw _privateConstructorUsedError;
  int get consecutiveLosses => throw _privateConstructorUsedError;
  Duration get averageTradeDuration => throw _privateConstructorUsedError;

  /// Serializes this PortfolioStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PortfolioStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PortfolioStatsCopyWith<PortfolioStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortfolioStatsCopyWith<$Res> {
  factory $PortfolioStatsCopyWith(
          PortfolioStats value, $Res Function(PortfolioStats) then) =
      _$PortfolioStatsCopyWithImpl<$Res, PortfolioStats>;
  @useResult
  $Res call(
      {double sharpeRatio,
      double sortinoRatio,
      double maxDrawdown,
      double averageDrawdown,
      double recoveryFactor,
      double profitFactor,
      double expectancy,
      double averageWin,
      double averageLoss,
      double largestWin,
      double largestLoss,
      int consecutiveWins,
      int consecutiveLosses,
      Duration averageTradeDuration});
}

/// @nodoc
class _$PortfolioStatsCopyWithImpl<$Res, $Val extends PortfolioStats>
    implements $PortfolioStatsCopyWith<$Res> {
  _$PortfolioStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PortfolioStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sharpeRatio = null,
    Object? sortinoRatio = null,
    Object? maxDrawdown = null,
    Object? averageDrawdown = null,
    Object? recoveryFactor = null,
    Object? profitFactor = null,
    Object? expectancy = null,
    Object? averageWin = null,
    Object? averageLoss = null,
    Object? largestWin = null,
    Object? largestLoss = null,
    Object? consecutiveWins = null,
    Object? consecutiveLosses = null,
    Object? averageTradeDuration = null,
  }) {
    return _then(_value.copyWith(
      sharpeRatio: null == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double,
      sortinoRatio: null == sortinoRatio
          ? _value.sortinoRatio
          : sortinoRatio // ignore: cast_nullable_to_non_nullable
              as double,
      maxDrawdown: null == maxDrawdown
          ? _value.maxDrawdown
          : maxDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      averageDrawdown: null == averageDrawdown
          ? _value.averageDrawdown
          : averageDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryFactor: null == recoveryFactor
          ? _value.recoveryFactor
          : recoveryFactor // ignore: cast_nullable_to_non_nullable
              as double,
      profitFactor: null == profitFactor
          ? _value.profitFactor
          : profitFactor // ignore: cast_nullable_to_non_nullable
              as double,
      expectancy: null == expectancy
          ? _value.expectancy
          : expectancy // ignore: cast_nullable_to_non_nullable
              as double,
      averageWin: null == averageWin
          ? _value.averageWin
          : averageWin // ignore: cast_nullable_to_non_nullable
              as double,
      averageLoss: null == averageLoss
          ? _value.averageLoss
          : averageLoss // ignore: cast_nullable_to_non_nullable
              as double,
      largestWin: null == largestWin
          ? _value.largestWin
          : largestWin // ignore: cast_nullable_to_non_nullable
              as double,
      largestLoss: null == largestLoss
          ? _value.largestLoss
          : largestLoss // ignore: cast_nullable_to_non_nullable
              as double,
      consecutiveWins: null == consecutiveWins
          ? _value.consecutiveWins
          : consecutiveWins // ignore: cast_nullable_to_non_nullable
              as int,
      consecutiveLosses: null == consecutiveLosses
          ? _value.consecutiveLosses
          : consecutiveLosses // ignore: cast_nullable_to_non_nullable
              as int,
      averageTradeDuration: null == averageTradeDuration
          ? _value.averageTradeDuration
          : averageTradeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PortfolioStatsImplCopyWith<$Res>
    implements $PortfolioStatsCopyWith<$Res> {
  factory _$$PortfolioStatsImplCopyWith(_$PortfolioStatsImpl value,
          $Res Function(_$PortfolioStatsImpl) then) =
      __$$PortfolioStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double sharpeRatio,
      double sortinoRatio,
      double maxDrawdown,
      double averageDrawdown,
      double recoveryFactor,
      double profitFactor,
      double expectancy,
      double averageWin,
      double averageLoss,
      double largestWin,
      double largestLoss,
      int consecutiveWins,
      int consecutiveLosses,
      Duration averageTradeDuration});
}

/// @nodoc
class __$$PortfolioStatsImplCopyWithImpl<$Res>
    extends _$PortfolioStatsCopyWithImpl<$Res, _$PortfolioStatsImpl>
    implements _$$PortfolioStatsImplCopyWith<$Res> {
  __$$PortfolioStatsImplCopyWithImpl(
      _$PortfolioStatsImpl _value, $Res Function(_$PortfolioStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PortfolioStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sharpeRatio = null,
    Object? sortinoRatio = null,
    Object? maxDrawdown = null,
    Object? averageDrawdown = null,
    Object? recoveryFactor = null,
    Object? profitFactor = null,
    Object? expectancy = null,
    Object? averageWin = null,
    Object? averageLoss = null,
    Object? largestWin = null,
    Object? largestLoss = null,
    Object? consecutiveWins = null,
    Object? consecutiveLosses = null,
    Object? averageTradeDuration = null,
  }) {
    return _then(_$PortfolioStatsImpl(
      sharpeRatio: null == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double,
      sortinoRatio: null == sortinoRatio
          ? _value.sortinoRatio
          : sortinoRatio // ignore: cast_nullable_to_non_nullable
              as double,
      maxDrawdown: null == maxDrawdown
          ? _value.maxDrawdown
          : maxDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      averageDrawdown: null == averageDrawdown
          ? _value.averageDrawdown
          : averageDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryFactor: null == recoveryFactor
          ? _value.recoveryFactor
          : recoveryFactor // ignore: cast_nullable_to_non_nullable
              as double,
      profitFactor: null == profitFactor
          ? _value.profitFactor
          : profitFactor // ignore: cast_nullable_to_non_nullable
              as double,
      expectancy: null == expectancy
          ? _value.expectancy
          : expectancy // ignore: cast_nullable_to_non_nullable
              as double,
      averageWin: null == averageWin
          ? _value.averageWin
          : averageWin // ignore: cast_nullable_to_non_nullable
              as double,
      averageLoss: null == averageLoss
          ? _value.averageLoss
          : averageLoss // ignore: cast_nullable_to_non_nullable
              as double,
      largestWin: null == largestWin
          ? _value.largestWin
          : largestWin // ignore: cast_nullable_to_non_nullable
              as double,
      largestLoss: null == largestLoss
          ? _value.largestLoss
          : largestLoss // ignore: cast_nullable_to_non_nullable
              as double,
      consecutiveWins: null == consecutiveWins
          ? _value.consecutiveWins
          : consecutiveWins // ignore: cast_nullable_to_non_nullable
              as int,
      consecutiveLosses: null == consecutiveLosses
          ? _value.consecutiveLosses
          : consecutiveLosses // ignore: cast_nullable_to_non_nullable
              as int,
      averageTradeDuration: null == averageTradeDuration
          ? _value.averageTradeDuration
          : averageTradeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PortfolioStatsImpl implements _PortfolioStats {
  const _$PortfolioStatsImpl(
      {required this.sharpeRatio,
      required this.sortinoRatio,
      required this.maxDrawdown,
      required this.averageDrawdown,
      required this.recoveryFactor,
      required this.profitFactor,
      required this.expectancy,
      required this.averageWin,
      required this.averageLoss,
      required this.largestWin,
      required this.largestLoss,
      required this.consecutiveWins,
      required this.consecutiveLosses,
      required this.averageTradeDuration});

  factory _$PortfolioStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PortfolioStatsImplFromJson(json);

  @override
  final double sharpeRatio;
  @override
  final double sortinoRatio;
  @override
  final double maxDrawdown;
  @override
  final double averageDrawdown;
  @override
  final double recoveryFactor;
  @override
  final double profitFactor;
  @override
  final double expectancy;
  @override
  final double averageWin;
  @override
  final double averageLoss;
  @override
  final double largestWin;
  @override
  final double largestLoss;
  @override
  final int consecutiveWins;
  @override
  final int consecutiveLosses;
  @override
  final Duration averageTradeDuration;

  @override
  String toString() {
    return 'PortfolioStats(sharpeRatio: $sharpeRatio, sortinoRatio: $sortinoRatio, maxDrawdown: $maxDrawdown, averageDrawdown: $averageDrawdown, recoveryFactor: $recoveryFactor, profitFactor: $profitFactor, expectancy: $expectancy, averageWin: $averageWin, averageLoss: $averageLoss, largestWin: $largestWin, largestLoss: $largestLoss, consecutiveWins: $consecutiveWins, consecutiveLosses: $consecutiveLosses, averageTradeDuration: $averageTradeDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortfolioStatsImpl &&
            (identical(other.sharpeRatio, sharpeRatio) ||
                other.sharpeRatio == sharpeRatio) &&
            (identical(other.sortinoRatio, sortinoRatio) ||
                other.sortinoRatio == sortinoRatio) &&
            (identical(other.maxDrawdown, maxDrawdown) ||
                other.maxDrawdown == maxDrawdown) &&
            (identical(other.averageDrawdown, averageDrawdown) ||
                other.averageDrawdown == averageDrawdown) &&
            (identical(other.recoveryFactor, recoveryFactor) ||
                other.recoveryFactor == recoveryFactor) &&
            (identical(other.profitFactor, profitFactor) ||
                other.profitFactor == profitFactor) &&
            (identical(other.expectancy, expectancy) ||
                other.expectancy == expectancy) &&
            (identical(other.averageWin, averageWin) ||
                other.averageWin == averageWin) &&
            (identical(other.averageLoss, averageLoss) ||
                other.averageLoss == averageLoss) &&
            (identical(other.largestWin, largestWin) ||
                other.largestWin == largestWin) &&
            (identical(other.largestLoss, largestLoss) ||
                other.largestLoss == largestLoss) &&
            (identical(other.consecutiveWins, consecutiveWins) ||
                other.consecutiveWins == consecutiveWins) &&
            (identical(other.consecutiveLosses, consecutiveLosses) ||
                other.consecutiveLosses == consecutiveLosses) &&
            (identical(other.averageTradeDuration, averageTradeDuration) ||
                other.averageTradeDuration == averageTradeDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      sharpeRatio,
      sortinoRatio,
      maxDrawdown,
      averageDrawdown,
      recoveryFactor,
      profitFactor,
      expectancy,
      averageWin,
      averageLoss,
      largestWin,
      largestLoss,
      consecutiveWins,
      consecutiveLosses,
      averageTradeDuration);

  /// Create a copy of PortfolioStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PortfolioStatsImplCopyWith<_$PortfolioStatsImpl> get copyWith =>
      __$$PortfolioStatsImplCopyWithImpl<_$PortfolioStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PortfolioStatsImplToJson(
      this,
    );
  }
}

abstract class _PortfolioStats implements PortfolioStats {
  const factory _PortfolioStats(
      {required final double sharpeRatio,
      required final double sortinoRatio,
      required final double maxDrawdown,
      required final double averageDrawdown,
      required final double recoveryFactor,
      required final double profitFactor,
      required final double expectancy,
      required final double averageWin,
      required final double averageLoss,
      required final double largestWin,
      required final double largestLoss,
      required final int consecutiveWins,
      required final int consecutiveLosses,
      required final Duration averageTradeDuration}) = _$PortfolioStatsImpl;

  factory _PortfolioStats.fromJson(Map<String, dynamic> json) =
      _$PortfolioStatsImpl.fromJson;

  @override
  double get sharpeRatio;
  @override
  double get sortinoRatio;
  @override
  double get maxDrawdown;
  @override
  double get averageDrawdown;
  @override
  double get recoveryFactor;
  @override
  double get profitFactor;
  @override
  double get expectancy;
  @override
  double get averageWin;
  @override
  double get averageLoss;
  @override
  double get largestWin;
  @override
  double get largestLoss;
  @override
  int get consecutiveWins;
  @override
  int get consecutiveLosses;
  @override
  Duration get averageTradeDuration;

  /// Create a copy of PortfolioStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PortfolioStatsImplCopyWith<_$PortfolioStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
