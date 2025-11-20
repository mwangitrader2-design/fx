// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RiskParameters _$RiskParametersFromJson(Map<String, dynamic> json) {
  return _RiskParameters.fromJson(json);
}

/// @nodoc
mixin _$RiskParameters {
  double get riskPercentage => throw _privateConstructorUsedError;
  double get riskRewardRatio => throw _privateConstructorUsedError;
  double get maxDailyLoss => throw _privateConstructorUsedError;
  int get maxOpenTrades => throw _privateConstructorUsedError;
  double get maxDrawdownPercentage => throw _privateConstructorUsedError;
  double get minLotSize => throw _privateConstructorUsedError;
  double get maxLotSize => throw _privateConstructorUsedError;
  bool get useTrailingStop => throw _privateConstructorUsedError;
  int get trailingStopDistance => throw _privateConstructorUsedError;
  bool get useBreakeven => throw _privateConstructorUsedError;
  int get breakevenDistance => throw _privateConstructorUsedError;
  bool get partialTakeProfit => throw _privateConstructorUsedError;
  List<double> get takeProfitLevels => throw _privateConstructorUsedError;

  /// Serializes this RiskParameters to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskParametersCopyWith<RiskParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskParametersCopyWith<$Res> {
  factory $RiskParametersCopyWith(
          RiskParameters value, $Res Function(RiskParameters) then) =
      _$RiskParametersCopyWithImpl<$Res, RiskParameters>;
  @useResult
  $Res call(
      {double riskPercentage,
      double riskRewardRatio,
      double maxDailyLoss,
      int maxOpenTrades,
      double maxDrawdownPercentage,
      double minLotSize,
      double maxLotSize,
      bool useTrailingStop,
      int trailingStopDistance,
      bool useBreakeven,
      int breakevenDistance,
      bool partialTakeProfit,
      List<double> takeProfitLevels});
}

/// @nodoc
class _$RiskParametersCopyWithImpl<$Res, $Val extends RiskParameters>
    implements $RiskParametersCopyWith<$Res> {
  _$RiskParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riskPercentage = null,
    Object? riskRewardRatio = null,
    Object? maxDailyLoss = null,
    Object? maxOpenTrades = null,
    Object? maxDrawdownPercentage = null,
    Object? minLotSize = null,
    Object? maxLotSize = null,
    Object? useTrailingStop = null,
    Object? trailingStopDistance = null,
    Object? useBreakeven = null,
    Object? breakevenDistance = null,
    Object? partialTakeProfit = null,
    Object? takeProfitLevels = null,
  }) {
    return _then(_value.copyWith(
      riskPercentage: null == riskPercentage
          ? _value.riskPercentage
          : riskPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      riskRewardRatio: null == riskRewardRatio
          ? _value.riskRewardRatio
          : riskRewardRatio // ignore: cast_nullable_to_non_nullable
              as double,
      maxDailyLoss: null == maxDailyLoss
          ? _value.maxDailyLoss
          : maxDailyLoss // ignore: cast_nullable_to_non_nullable
              as double,
      maxOpenTrades: null == maxOpenTrades
          ? _value.maxOpenTrades
          : maxOpenTrades // ignore: cast_nullable_to_non_nullable
              as int,
      maxDrawdownPercentage: null == maxDrawdownPercentage
          ? _value.maxDrawdownPercentage
          : maxDrawdownPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      minLotSize: null == minLotSize
          ? _value.minLotSize
          : minLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      maxLotSize: null == maxLotSize
          ? _value.maxLotSize
          : maxLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      useTrailingStop: null == useTrailingStop
          ? _value.useTrailingStop
          : useTrailingStop // ignore: cast_nullable_to_non_nullable
              as bool,
      trailingStopDistance: null == trailingStopDistance
          ? _value.trailingStopDistance
          : trailingStopDistance // ignore: cast_nullable_to_non_nullable
              as int,
      useBreakeven: null == useBreakeven
          ? _value.useBreakeven
          : useBreakeven // ignore: cast_nullable_to_non_nullable
              as bool,
      breakevenDistance: null == breakevenDistance
          ? _value.breakevenDistance
          : breakevenDistance // ignore: cast_nullable_to_non_nullable
              as int,
      partialTakeProfit: null == partialTakeProfit
          ? _value.partialTakeProfit
          : partialTakeProfit // ignore: cast_nullable_to_non_nullable
              as bool,
      takeProfitLevels: null == takeProfitLevels
          ? _value.takeProfitLevels
          : takeProfitLevels // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskParametersImplCopyWith<$Res>
    implements $RiskParametersCopyWith<$Res> {
  factory _$$RiskParametersImplCopyWith(_$RiskParametersImpl value,
          $Res Function(_$RiskParametersImpl) then) =
      __$$RiskParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double riskPercentage,
      double riskRewardRatio,
      double maxDailyLoss,
      int maxOpenTrades,
      double maxDrawdownPercentage,
      double minLotSize,
      double maxLotSize,
      bool useTrailingStop,
      int trailingStopDistance,
      bool useBreakeven,
      int breakevenDistance,
      bool partialTakeProfit,
      List<double> takeProfitLevels});
}

/// @nodoc
class __$$RiskParametersImplCopyWithImpl<$Res>
    extends _$RiskParametersCopyWithImpl<$Res, _$RiskParametersImpl>
    implements _$$RiskParametersImplCopyWith<$Res> {
  __$$RiskParametersImplCopyWithImpl(
      _$RiskParametersImpl _value, $Res Function(_$RiskParametersImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskParameters
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? riskPercentage = null,
    Object? riskRewardRatio = null,
    Object? maxDailyLoss = null,
    Object? maxOpenTrades = null,
    Object? maxDrawdownPercentage = null,
    Object? minLotSize = null,
    Object? maxLotSize = null,
    Object? useTrailingStop = null,
    Object? trailingStopDistance = null,
    Object? useBreakeven = null,
    Object? breakevenDistance = null,
    Object? partialTakeProfit = null,
    Object? takeProfitLevels = null,
  }) {
    return _then(_$RiskParametersImpl(
      riskPercentage: null == riskPercentage
          ? _value.riskPercentage
          : riskPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      riskRewardRatio: null == riskRewardRatio
          ? _value.riskRewardRatio
          : riskRewardRatio // ignore: cast_nullable_to_non_nullable
              as double,
      maxDailyLoss: null == maxDailyLoss
          ? _value.maxDailyLoss
          : maxDailyLoss // ignore: cast_nullable_to_non_nullable
              as double,
      maxOpenTrades: null == maxOpenTrades
          ? _value.maxOpenTrades
          : maxOpenTrades // ignore: cast_nullable_to_non_nullable
              as int,
      maxDrawdownPercentage: null == maxDrawdownPercentage
          ? _value.maxDrawdownPercentage
          : maxDrawdownPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      minLotSize: null == minLotSize
          ? _value.minLotSize
          : minLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      maxLotSize: null == maxLotSize
          ? _value.maxLotSize
          : maxLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      useTrailingStop: null == useTrailingStop
          ? _value.useTrailingStop
          : useTrailingStop // ignore: cast_nullable_to_non_nullable
              as bool,
      trailingStopDistance: null == trailingStopDistance
          ? _value.trailingStopDistance
          : trailingStopDistance // ignore: cast_nullable_to_non_nullable
              as int,
      useBreakeven: null == useBreakeven
          ? _value.useBreakeven
          : useBreakeven // ignore: cast_nullable_to_non_nullable
              as bool,
      breakevenDistance: null == breakevenDistance
          ? _value.breakevenDistance
          : breakevenDistance // ignore: cast_nullable_to_non_nullable
              as int,
      partialTakeProfit: null == partialTakeProfit
          ? _value.partialTakeProfit
          : partialTakeProfit // ignore: cast_nullable_to_non_nullable
              as bool,
      takeProfitLevels: null == takeProfitLevels
          ? _value._takeProfitLevels
          : takeProfitLevels // ignore: cast_nullable_to_non_nullable
              as List<double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskParametersImpl implements _RiskParameters {
  const _$RiskParametersImpl(
      {this.riskPercentage = 2.0,
      this.riskRewardRatio = 1.5,
      this.maxDailyLoss = 5.0,
      this.maxOpenTrades = 3,
      this.maxDrawdownPercentage = 10.0,
      this.minLotSize = 0.01,
      this.maxLotSize = 10.0,
      this.useTrailingStop = true,
      this.trailingStopDistance = 50,
      this.useBreakeven = true,
      this.breakevenDistance = 20,
      this.partialTakeProfit = true,
      final List<double> takeProfitLevels = const [0.5, 1.0, 2.0]})
      : _takeProfitLevels = takeProfitLevels;

  factory _$RiskParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskParametersImplFromJson(json);

  @override
  @JsonKey()
  final double riskPercentage;
  @override
  @JsonKey()
  final double riskRewardRatio;
  @override
  @JsonKey()
  final double maxDailyLoss;
  @override
  @JsonKey()
  final int maxOpenTrades;
  @override
  @JsonKey()
  final double maxDrawdownPercentage;
  @override
  @JsonKey()
  final double minLotSize;
  @override
  @JsonKey()
  final double maxLotSize;
  @override
  @JsonKey()
  final bool useTrailingStop;
  @override
  @JsonKey()
  final int trailingStopDistance;
  @override
  @JsonKey()
  final bool useBreakeven;
  @override
  @JsonKey()
  final int breakevenDistance;
  @override
  @JsonKey()
  final bool partialTakeProfit;
  final List<double> _takeProfitLevels;
  @override
  @JsonKey()
  List<double> get takeProfitLevels {
    if (_takeProfitLevels is EqualUnmodifiableListView)
      return _takeProfitLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_takeProfitLevels);
  }

  @override
  String toString() {
    return 'RiskParameters(riskPercentage: $riskPercentage, riskRewardRatio: $riskRewardRatio, maxDailyLoss: $maxDailyLoss, maxOpenTrades: $maxOpenTrades, maxDrawdownPercentage: $maxDrawdownPercentage, minLotSize: $minLotSize, maxLotSize: $maxLotSize, useTrailingStop: $useTrailingStop, trailingStopDistance: $trailingStopDistance, useBreakeven: $useBreakeven, breakevenDistance: $breakevenDistance, partialTakeProfit: $partialTakeProfit, takeProfitLevels: $takeProfitLevels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskParametersImpl &&
            (identical(other.riskPercentage, riskPercentage) ||
                other.riskPercentage == riskPercentage) &&
            (identical(other.riskRewardRatio, riskRewardRatio) ||
                other.riskRewardRatio == riskRewardRatio) &&
            (identical(other.maxDailyLoss, maxDailyLoss) ||
                other.maxDailyLoss == maxDailyLoss) &&
            (identical(other.maxOpenTrades, maxOpenTrades) ||
                other.maxOpenTrades == maxOpenTrades) &&
            (identical(other.maxDrawdownPercentage, maxDrawdownPercentage) ||
                other.maxDrawdownPercentage == maxDrawdownPercentage) &&
            (identical(other.minLotSize, minLotSize) ||
                other.minLotSize == minLotSize) &&
            (identical(other.maxLotSize, maxLotSize) ||
                other.maxLotSize == maxLotSize) &&
            (identical(other.useTrailingStop, useTrailingStop) ||
                other.useTrailingStop == useTrailingStop) &&
            (identical(other.trailingStopDistance, trailingStopDistance) ||
                other.trailingStopDistance == trailingStopDistance) &&
            (identical(other.useBreakeven, useBreakeven) ||
                other.useBreakeven == useBreakeven) &&
            (identical(other.breakevenDistance, breakevenDistance) ||
                other.breakevenDistance == breakevenDistance) &&
            (identical(other.partialTakeProfit, partialTakeProfit) ||
                other.partialTakeProfit == partialTakeProfit) &&
            const DeepCollectionEquality()
                .equals(other._takeProfitLevels, _takeProfitLevels));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      riskPercentage,
      riskRewardRatio,
      maxDailyLoss,
      maxOpenTrades,
      maxDrawdownPercentage,
      minLotSize,
      maxLotSize,
      useTrailingStop,
      trailingStopDistance,
      useBreakeven,
      breakevenDistance,
      partialTakeProfit,
      const DeepCollectionEquality().hash(_takeProfitLevels));

  /// Create a copy of RiskParameters
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskParametersImplCopyWith<_$RiskParametersImpl> get copyWith =>
      __$$RiskParametersImplCopyWithImpl<_$RiskParametersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskParametersImplToJson(
      this,
    );
  }
}

abstract class _RiskParameters implements RiskParameters {
  const factory _RiskParameters(
      {final double riskPercentage,
      final double riskRewardRatio,
      final double maxDailyLoss,
      final int maxOpenTrades,
      final double maxDrawdownPercentage,
      final double minLotSize,
      final double maxLotSize,
      final bool useTrailingStop,
      final int trailingStopDistance,
      final bool useBreakeven,
      final int breakevenDistance,
      final bool partialTakeProfit,
      final List<double> takeProfitLevels}) = _$RiskParametersImpl;

  factory _RiskParameters.fromJson(Map<String, dynamic> json) =
      _$RiskParametersImpl.fromJson;

  @override
  double get riskPercentage;
  @override
  double get riskRewardRatio;
  @override
  double get maxDailyLoss;
  @override
  int get maxOpenTrades;
  @override
  double get maxDrawdownPercentage;
  @override
  double get minLotSize;
  @override
  double get maxLotSize;
  @override
  bool get useTrailingStop;
  @override
  int get trailingStopDistance;
  @override
  bool get useBreakeven;
  @override
  int get breakevenDistance;
  @override
  bool get partialTakeProfit;
  @override
  List<double> get takeProfitLevels;

  /// Create a copy of RiskParameters
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskParametersImplCopyWith<_$RiskParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RiskMetrics _$RiskMetricsFromJson(Map<String, dynamic> json) {
  return _RiskMetrics.fromJson(json);
}

/// @nodoc
mixin _$RiskMetrics {
  double get currentRiskPercentage => throw _privateConstructorUsedError;
  double get dailyLoss => throw _privateConstructorUsedError;
  double get currentDrawdown => throw _privateConstructorUsedError;
  int get openTradesCount => throw _privateConstructorUsedError;
  double get exposedMargin => throw _privateConstructorUsedError;
  bool get canOpenNewTrade => throw _privateConstructorUsedError;
  List<String> get riskWarnings => throw _privateConstructorUsedError;
  DateTime get calculatedAt => throw _privateConstructorUsedError;

  /// Serializes this RiskMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskMetricsCopyWith<RiskMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskMetricsCopyWith<$Res> {
  factory $RiskMetricsCopyWith(
          RiskMetrics value, $Res Function(RiskMetrics) then) =
      _$RiskMetricsCopyWithImpl<$Res, RiskMetrics>;
  @useResult
  $Res call(
      {double currentRiskPercentage,
      double dailyLoss,
      double currentDrawdown,
      int openTradesCount,
      double exposedMargin,
      bool canOpenNewTrade,
      List<String> riskWarnings,
      DateTime calculatedAt});
}

/// @nodoc
class _$RiskMetricsCopyWithImpl<$Res, $Val extends RiskMetrics>
    implements $RiskMetricsCopyWith<$Res> {
  _$RiskMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRiskPercentage = null,
    Object? dailyLoss = null,
    Object? currentDrawdown = null,
    Object? openTradesCount = null,
    Object? exposedMargin = null,
    Object? canOpenNewTrade = null,
    Object? riskWarnings = null,
    Object? calculatedAt = null,
  }) {
    return _then(_value.copyWith(
      currentRiskPercentage: null == currentRiskPercentage
          ? _value.currentRiskPercentage
          : currentRiskPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      dailyLoss: null == dailyLoss
          ? _value.dailyLoss
          : dailyLoss // ignore: cast_nullable_to_non_nullable
              as double,
      currentDrawdown: null == currentDrawdown
          ? _value.currentDrawdown
          : currentDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      openTradesCount: null == openTradesCount
          ? _value.openTradesCount
          : openTradesCount // ignore: cast_nullable_to_non_nullable
              as int,
      exposedMargin: null == exposedMargin
          ? _value.exposedMargin
          : exposedMargin // ignore: cast_nullable_to_non_nullable
              as double,
      canOpenNewTrade: null == canOpenNewTrade
          ? _value.canOpenNewTrade
          : canOpenNewTrade // ignore: cast_nullable_to_non_nullable
              as bool,
      riskWarnings: null == riskWarnings
          ? _value.riskWarnings
          : riskWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RiskMetricsImplCopyWith<$Res>
    implements $RiskMetricsCopyWith<$Res> {
  factory _$$RiskMetricsImplCopyWith(
          _$RiskMetricsImpl value, $Res Function(_$RiskMetricsImpl) then) =
      __$$RiskMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double currentRiskPercentage,
      double dailyLoss,
      double currentDrawdown,
      int openTradesCount,
      double exposedMargin,
      bool canOpenNewTrade,
      List<String> riskWarnings,
      DateTime calculatedAt});
}

/// @nodoc
class __$$RiskMetricsImplCopyWithImpl<$Res>
    extends _$RiskMetricsCopyWithImpl<$Res, _$RiskMetricsImpl>
    implements _$$RiskMetricsImplCopyWith<$Res> {
  __$$RiskMetricsImplCopyWithImpl(
      _$RiskMetricsImpl _value, $Res Function(_$RiskMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of RiskMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRiskPercentage = null,
    Object? dailyLoss = null,
    Object? currentDrawdown = null,
    Object? openTradesCount = null,
    Object? exposedMargin = null,
    Object? canOpenNewTrade = null,
    Object? riskWarnings = null,
    Object? calculatedAt = null,
  }) {
    return _then(_$RiskMetricsImpl(
      currentRiskPercentage: null == currentRiskPercentage
          ? _value.currentRiskPercentage
          : currentRiskPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      dailyLoss: null == dailyLoss
          ? _value.dailyLoss
          : dailyLoss // ignore: cast_nullable_to_non_nullable
              as double,
      currentDrawdown: null == currentDrawdown
          ? _value.currentDrawdown
          : currentDrawdown // ignore: cast_nullable_to_non_nullable
              as double,
      openTradesCount: null == openTradesCount
          ? _value.openTradesCount
          : openTradesCount // ignore: cast_nullable_to_non_nullable
              as int,
      exposedMargin: null == exposedMargin
          ? _value.exposedMargin
          : exposedMargin // ignore: cast_nullable_to_non_nullable
              as double,
      canOpenNewTrade: null == canOpenNewTrade
          ? _value.canOpenNewTrade
          : canOpenNewTrade // ignore: cast_nullable_to_non_nullable
              as bool,
      riskWarnings: null == riskWarnings
          ? _value._riskWarnings
          : riskWarnings // ignore: cast_nullable_to_non_nullable
              as List<String>,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskMetricsImpl implements _RiskMetrics {
  const _$RiskMetricsImpl(
      {required this.currentRiskPercentage,
      required this.dailyLoss,
      required this.currentDrawdown,
      required this.openTradesCount,
      required this.exposedMargin,
      required this.canOpenNewTrade,
      required final List<String> riskWarnings,
      required this.calculatedAt})
      : _riskWarnings = riskWarnings;

  factory _$RiskMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskMetricsImplFromJson(json);

  @override
  final double currentRiskPercentage;
  @override
  final double dailyLoss;
  @override
  final double currentDrawdown;
  @override
  final int openTradesCount;
  @override
  final double exposedMargin;
  @override
  final bool canOpenNewTrade;
  final List<String> _riskWarnings;
  @override
  List<String> get riskWarnings {
    if (_riskWarnings is EqualUnmodifiableListView) return _riskWarnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_riskWarnings);
  }

  @override
  final DateTime calculatedAt;

  @override
  String toString() {
    return 'RiskMetrics(currentRiskPercentage: $currentRiskPercentage, dailyLoss: $dailyLoss, currentDrawdown: $currentDrawdown, openTradesCount: $openTradesCount, exposedMargin: $exposedMargin, canOpenNewTrade: $canOpenNewTrade, riskWarnings: $riskWarnings, calculatedAt: $calculatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskMetricsImpl &&
            (identical(other.currentRiskPercentage, currentRiskPercentage) ||
                other.currentRiskPercentage == currentRiskPercentage) &&
            (identical(other.dailyLoss, dailyLoss) ||
                other.dailyLoss == dailyLoss) &&
            (identical(other.currentDrawdown, currentDrawdown) ||
                other.currentDrawdown == currentDrawdown) &&
            (identical(other.openTradesCount, openTradesCount) ||
                other.openTradesCount == openTradesCount) &&
            (identical(other.exposedMargin, exposedMargin) ||
                other.exposedMargin == exposedMargin) &&
            (identical(other.canOpenNewTrade, canOpenNewTrade) ||
                other.canOpenNewTrade == canOpenNewTrade) &&
            const DeepCollectionEquality()
                .equals(other._riskWarnings, _riskWarnings) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentRiskPercentage,
      dailyLoss,
      currentDrawdown,
      openTradesCount,
      exposedMargin,
      canOpenNewTrade,
      const DeepCollectionEquality().hash(_riskWarnings),
      calculatedAt);

  /// Create a copy of RiskMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskMetricsImplCopyWith<_$RiskMetricsImpl> get copyWith =>
      __$$RiskMetricsImplCopyWithImpl<_$RiskMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskMetricsImplToJson(
      this,
    );
  }
}

abstract class _RiskMetrics implements RiskMetrics {
  const factory _RiskMetrics(
      {required final double currentRiskPercentage,
      required final double dailyLoss,
      required final double currentDrawdown,
      required final int openTradesCount,
      required final double exposedMargin,
      required final bool canOpenNewTrade,
      required final List<String> riskWarnings,
      required final DateTime calculatedAt}) = _$RiskMetricsImpl;

  factory _RiskMetrics.fromJson(Map<String, dynamic> json) =
      _$RiskMetricsImpl.fromJson;

  @override
  double get currentRiskPercentage;
  @override
  double get dailyLoss;
  @override
  double get currentDrawdown;
  @override
  int get openTradesCount;
  @override
  double get exposedMargin;
  @override
  bool get canOpenNewTrade;
  @override
  List<String> get riskWarnings;
  @override
  DateTime get calculatedAt;

  /// Create a copy of RiskMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskMetricsImplCopyWith<_$RiskMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
