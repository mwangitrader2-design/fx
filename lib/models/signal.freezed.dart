// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradingSignal _$TradingSignalFromJson(Map<String, dynamic> json) {
  return _TradingSignal.fromJson(json);
}

/// @nodoc
mixin _$TradingSignal {
  String get id => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  SignalType get type => throw _privateConstructorUsedError;
  SignalStrength get strength => throw _privateConstructorUsedError;
  SignalStatus get status => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  TimeframeType get primaryTimeframe => throw _privateConstructorUsedError;
  TimeframeType get confirmationTimeframe => throw _privateConstructorUsedError;
  double get entryPrice => throw _privateConstructorUsedError;
  double get stopLoss => throw _privateConstructorUsedError;
  double get takeProfit => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;
  List<String> get indicators => throw _privateConstructorUsedError;
  Map<String, dynamic> get technicalAnalysis =>
      throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  DateTime? get executedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  bool get isConfirmedOnLowerTimeframe => throw _privateConstructorUsedError;

  /// Serializes this TradingSignal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TradingSignal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TradingSignalCopyWith<TradingSignal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradingSignalCopyWith<$Res> {
  factory $TradingSignalCopyWith(
          TradingSignal value, $Res Function(TradingSignal) then) =
      _$TradingSignalCopyWithImpl<$Res, TradingSignal>;
  @useResult
  $Res call(
      {String id,
      String symbol,
      SignalType type,
      SignalStrength strength,
      SignalStatus status,
      DateTime generatedAt,
      TimeframeType primaryTimeframe,
      TimeframeType confirmationTimeframe,
      double entryPrice,
      double stopLoss,
      double takeProfit,
      double confidenceScore,
      List<String> indicators,
      Map<String, dynamic> technicalAnalysis,
      DateTime? confirmedAt,
      DateTime? executedAt,
      DateTime? expiresAt,
      String? notes,
      bool isConfirmedOnLowerTimeframe});
}

/// @nodoc
class _$TradingSignalCopyWithImpl<$Res, $Val extends TradingSignal>
    implements $TradingSignalCopyWith<$Res> {
  _$TradingSignalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TradingSignal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? type = null,
    Object? strength = null,
    Object? status = null,
    Object? generatedAt = null,
    Object? primaryTimeframe = null,
    Object? confirmationTimeframe = null,
    Object? entryPrice = null,
    Object? stopLoss = null,
    Object? takeProfit = null,
    Object? confidenceScore = null,
    Object? indicators = null,
    Object? technicalAnalysis = null,
    Object? confirmedAt = freezed,
    Object? executedAt = freezed,
    Object? expiresAt = freezed,
    Object? notes = freezed,
    Object? isConfirmedOnLowerTimeframe = null,
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
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as SignalStrength,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalStatus,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      primaryTimeframe: null == primaryTimeframe
          ? _value.primaryTimeframe
          : primaryTimeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      confirmationTimeframe: null == confirmationTimeframe
          ? _value.confirmationTimeframe
          : confirmationTimeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      entryPrice: null == entryPrice
          ? _value.entryPrice
          : entryPrice // ignore: cast_nullable_to_non_nullable
              as double,
      stopLoss: null == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double,
      takeProfit: null == takeProfit
          ? _value.takeProfit
          : takeProfit // ignore: cast_nullable_to_non_nullable
              as double,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      technicalAnalysis: null == technicalAnalysis
          ? _value.technicalAnalysis
          : technicalAnalysis // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      executedAt: freezed == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isConfirmedOnLowerTimeframe: null == isConfirmedOnLowerTimeframe
          ? _value.isConfirmedOnLowerTimeframe
          : isConfirmedOnLowerTimeframe // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradingSignalImplCopyWith<$Res>
    implements $TradingSignalCopyWith<$Res> {
  factory _$$TradingSignalImplCopyWith(
          _$TradingSignalImpl value, $Res Function(_$TradingSignalImpl) then) =
      __$$TradingSignalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String symbol,
      SignalType type,
      SignalStrength strength,
      SignalStatus status,
      DateTime generatedAt,
      TimeframeType primaryTimeframe,
      TimeframeType confirmationTimeframe,
      double entryPrice,
      double stopLoss,
      double takeProfit,
      double confidenceScore,
      List<String> indicators,
      Map<String, dynamic> technicalAnalysis,
      DateTime? confirmedAt,
      DateTime? executedAt,
      DateTime? expiresAt,
      String? notes,
      bool isConfirmedOnLowerTimeframe});
}

/// @nodoc
class __$$TradingSignalImplCopyWithImpl<$Res>
    extends _$TradingSignalCopyWithImpl<$Res, _$TradingSignalImpl>
    implements _$$TradingSignalImplCopyWith<$Res> {
  __$$TradingSignalImplCopyWithImpl(
      _$TradingSignalImpl _value, $Res Function(_$TradingSignalImpl) _then)
      : super(_value, _then);

  /// Create a copy of TradingSignal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? symbol = null,
    Object? type = null,
    Object? strength = null,
    Object? status = null,
    Object? generatedAt = null,
    Object? primaryTimeframe = null,
    Object? confirmationTimeframe = null,
    Object? entryPrice = null,
    Object? stopLoss = null,
    Object? takeProfit = null,
    Object? confidenceScore = null,
    Object? indicators = null,
    Object? technicalAnalysis = null,
    Object? confirmedAt = freezed,
    Object? executedAt = freezed,
    Object? expiresAt = freezed,
    Object? notes = freezed,
    Object? isConfirmedOnLowerTimeframe = null,
  }) {
    return _then(_$TradingSignalImpl(
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
      strength: null == strength
          ? _value.strength
          : strength // ignore: cast_nullable_to_non_nullable
              as SignalStrength,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SignalStatus,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      primaryTimeframe: null == primaryTimeframe
          ? _value.primaryTimeframe
          : primaryTimeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      confirmationTimeframe: null == confirmationTimeframe
          ? _value.confirmationTimeframe
          : confirmationTimeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      entryPrice: null == entryPrice
          ? _value.entryPrice
          : entryPrice // ignore: cast_nullable_to_non_nullable
              as double,
      stopLoss: null == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double,
      takeProfit: null == takeProfit
          ? _value.takeProfit
          : takeProfit // ignore: cast_nullable_to_non_nullable
              as double,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      indicators: null == indicators
          ? _value._indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      technicalAnalysis: null == technicalAnalysis
          ? _value._technicalAnalysis
          : technicalAnalysis // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      executedAt: freezed == executedAt
          ? _value.executedAt
          : executedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      isConfirmedOnLowerTimeframe: null == isConfirmedOnLowerTimeframe
          ? _value.isConfirmedOnLowerTimeframe
          : isConfirmedOnLowerTimeframe // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradingSignalImpl implements _TradingSignal {
  const _$TradingSignalImpl(
      {required this.id,
      required this.symbol,
      required this.type,
      required this.strength,
      required this.status,
      required this.generatedAt,
      required this.primaryTimeframe,
      required this.confirmationTimeframe,
      required this.entryPrice,
      required this.stopLoss,
      required this.takeProfit,
      required this.confidenceScore,
      required final List<String> indicators,
      required final Map<String, dynamic> technicalAnalysis,
      this.confirmedAt,
      this.executedAt,
      this.expiresAt,
      this.notes,
      this.isConfirmedOnLowerTimeframe = false})
      : _indicators = indicators,
        _technicalAnalysis = technicalAnalysis;

  factory _$TradingSignalImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradingSignalImplFromJson(json);

  @override
  final String id;
  @override
  final String symbol;
  @override
  final SignalType type;
  @override
  final SignalStrength strength;
  @override
  final SignalStatus status;
  @override
  final DateTime generatedAt;
  @override
  final TimeframeType primaryTimeframe;
  @override
  final TimeframeType confirmationTimeframe;
  @override
  final double entryPrice;
  @override
  final double stopLoss;
  @override
  final double takeProfit;
  @override
  final double confidenceScore;
  final List<String> _indicators;
  @override
  List<String> get indicators {
    if (_indicators is EqualUnmodifiableListView) return _indicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_indicators);
  }

  final Map<String, dynamic> _technicalAnalysis;
  @override
  Map<String, dynamic> get technicalAnalysis {
    if (_technicalAnalysis is EqualUnmodifiableMapView)
      return _technicalAnalysis;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_technicalAnalysis);
  }

  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? executedAt;
  @override
  final DateTime? expiresAt;
  @override
  final String? notes;
  @override
  @JsonKey()
  final bool isConfirmedOnLowerTimeframe;

  @override
  String toString() {
    return 'TradingSignal(id: $id, symbol: $symbol, type: $type, strength: $strength, status: $status, generatedAt: $generatedAt, primaryTimeframe: $primaryTimeframe, confirmationTimeframe: $confirmationTimeframe, entryPrice: $entryPrice, stopLoss: $stopLoss, takeProfit: $takeProfit, confidenceScore: $confidenceScore, indicators: $indicators, technicalAnalysis: $technicalAnalysis, confirmedAt: $confirmedAt, executedAt: $executedAt, expiresAt: $expiresAt, notes: $notes, isConfirmedOnLowerTimeframe: $isConfirmedOnLowerTimeframe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradingSignalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.strength, strength) ||
                other.strength == strength) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.primaryTimeframe, primaryTimeframe) ||
                other.primaryTimeframe == primaryTimeframe) &&
            (identical(other.confirmationTimeframe, confirmationTimeframe) ||
                other.confirmationTimeframe == confirmationTimeframe) &&
            (identical(other.entryPrice, entryPrice) ||
                other.entryPrice == entryPrice) &&
            (identical(other.stopLoss, stopLoss) ||
                other.stopLoss == stopLoss) &&
            (identical(other.takeProfit, takeProfit) ||
                other.takeProfit == takeProfit) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            const DeepCollectionEquality()
                .equals(other._indicators, _indicators) &&
            const DeepCollectionEquality()
                .equals(other._technicalAnalysis, _technicalAnalysis) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.executedAt, executedAt) ||
                other.executedAt == executedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isConfirmedOnLowerTimeframe,
                    isConfirmedOnLowerTimeframe) ||
                other.isConfirmedOnLowerTimeframe ==
                    isConfirmedOnLowerTimeframe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        symbol,
        type,
        strength,
        status,
        generatedAt,
        primaryTimeframe,
        confirmationTimeframe,
        entryPrice,
        stopLoss,
        takeProfit,
        confidenceScore,
        const DeepCollectionEquality().hash(_indicators),
        const DeepCollectionEquality().hash(_technicalAnalysis),
        confirmedAt,
        executedAt,
        expiresAt,
        notes,
        isConfirmedOnLowerTimeframe
      ]);

  /// Create a copy of TradingSignal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TradingSignalImplCopyWith<_$TradingSignalImpl> get copyWith =>
      __$$TradingSignalImplCopyWithImpl<_$TradingSignalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradingSignalImplToJson(
      this,
    );
  }
}

abstract class _TradingSignal implements TradingSignal {
  const factory _TradingSignal(
      {required final String id,
      required final String symbol,
      required final SignalType type,
      required final SignalStrength strength,
      required final SignalStatus status,
      required final DateTime generatedAt,
      required final TimeframeType primaryTimeframe,
      required final TimeframeType confirmationTimeframe,
      required final double entryPrice,
      required final double stopLoss,
      required final double takeProfit,
      required final double confidenceScore,
      required final List<String> indicators,
      required final Map<String, dynamic> technicalAnalysis,
      final DateTime? confirmedAt,
      final DateTime? executedAt,
      final DateTime? expiresAt,
      final String? notes,
      final bool isConfirmedOnLowerTimeframe}) = _$TradingSignalImpl;

  factory _TradingSignal.fromJson(Map<String, dynamic> json) =
      _$TradingSignalImpl.fromJson;

  @override
  String get id;
  @override
  String get symbol;
  @override
  SignalType get type;
  @override
  SignalStrength get strength;
  @override
  SignalStatus get status;
  @override
  DateTime get generatedAt;
  @override
  TimeframeType get primaryTimeframe;
  @override
  TimeframeType get confirmationTimeframe;
  @override
  double get entryPrice;
  @override
  double get stopLoss;
  @override
  double get takeProfit;
  @override
  double get confidenceScore;
  @override
  List<String> get indicators;
  @override
  Map<String, dynamic> get technicalAnalysis;
  @override
  DateTime? get confirmedAt;
  @override
  DateTime? get executedAt;
  @override
  DateTime? get expiresAt;
  @override
  String? get notes;
  @override
  bool get isConfirmedOnLowerTimeframe;

  /// Create a copy of TradingSignal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TradingSignalImplCopyWith<_$TradingSignalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SignalConfirmation _$SignalConfirmationFromJson(Map<String, dynamic> json) {
  return _SignalConfirmation.fromJson(json);
}

/// @nodoc
mixin _$SignalConfirmation {
  String get signalId => throw _privateConstructorUsedError;
  TimeframeType get timeframe => throw _privateConstructorUsedError;
  bool get isConfirmed => throw _privateConstructorUsedError;
  DateTime get checkedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get indicators => throw _privateConstructorUsedError;
  double get alignmentScore => throw _privateConstructorUsedError;

  /// Serializes this SignalConfirmation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignalConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignalConfirmationCopyWith<SignalConfirmation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignalConfirmationCopyWith<$Res> {
  factory $SignalConfirmationCopyWith(
          SignalConfirmation value, $Res Function(SignalConfirmation) then) =
      _$SignalConfirmationCopyWithImpl<$Res, SignalConfirmation>;
  @useResult
  $Res call(
      {String signalId,
      TimeframeType timeframe,
      bool isConfirmed,
      DateTime checkedAt,
      Map<String, dynamic> indicators,
      double alignmentScore});
}

/// @nodoc
class _$SignalConfirmationCopyWithImpl<$Res, $Val extends SignalConfirmation>
    implements $SignalConfirmationCopyWith<$Res> {
  _$SignalConfirmationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignalConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signalId = null,
    Object? timeframe = null,
    Object? isConfirmed = null,
    Object? checkedAt = null,
    Object? indicators = null,
    Object? alignmentScore = null,
  }) {
    return _then(_value.copyWith(
      signalId: null == signalId
          ? _value.signalId
          : signalId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      alignmentScore: null == alignmentScore
          ? _value.alignmentScore
          : alignmentScore // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignalConfirmationImplCopyWith<$Res>
    implements $SignalConfirmationCopyWith<$Res> {
  factory _$$SignalConfirmationImplCopyWith(_$SignalConfirmationImpl value,
          $Res Function(_$SignalConfirmationImpl) then) =
      __$$SignalConfirmationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String signalId,
      TimeframeType timeframe,
      bool isConfirmed,
      DateTime checkedAt,
      Map<String, dynamic> indicators,
      double alignmentScore});
}

/// @nodoc
class __$$SignalConfirmationImplCopyWithImpl<$Res>
    extends _$SignalConfirmationCopyWithImpl<$Res, _$SignalConfirmationImpl>
    implements _$$SignalConfirmationImplCopyWith<$Res> {
  __$$SignalConfirmationImplCopyWithImpl(_$SignalConfirmationImpl _value,
      $Res Function(_$SignalConfirmationImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignalConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signalId = null,
    Object? timeframe = null,
    Object? isConfirmed = null,
    Object? checkedAt = null,
    Object? indicators = null,
    Object? alignmentScore = null,
  }) {
    return _then(_$SignalConfirmationImpl(
      signalId: null == signalId
          ? _value.signalId
          : signalId // ignore: cast_nullable_to_non_nullable
              as String,
      timeframe: null == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as TimeframeType,
      isConfirmed: null == isConfirmed
          ? _value.isConfirmed
          : isConfirmed // ignore: cast_nullable_to_non_nullable
              as bool,
      checkedAt: null == checkedAt
          ? _value.checkedAt
          : checkedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      indicators: null == indicators
          ? _value._indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      alignmentScore: null == alignmentScore
          ? _value.alignmentScore
          : alignmentScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignalConfirmationImpl implements _SignalConfirmation {
  const _$SignalConfirmationImpl(
      {required this.signalId,
      required this.timeframe,
      required this.isConfirmed,
      required this.checkedAt,
      required final Map<String, dynamic> indicators,
      required this.alignmentScore})
      : _indicators = indicators;

  factory _$SignalConfirmationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignalConfirmationImplFromJson(json);

  @override
  final String signalId;
  @override
  final TimeframeType timeframe;
  @override
  final bool isConfirmed;
  @override
  final DateTime checkedAt;
  final Map<String, dynamic> _indicators;
  @override
  Map<String, dynamic> get indicators {
    if (_indicators is EqualUnmodifiableMapView) return _indicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_indicators);
  }

  @override
  final double alignmentScore;

  @override
  String toString() {
    return 'SignalConfirmation(signalId: $signalId, timeframe: $timeframe, isConfirmed: $isConfirmed, checkedAt: $checkedAt, indicators: $indicators, alignmentScore: $alignmentScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalConfirmationImpl &&
            (identical(other.signalId, signalId) ||
                other.signalId == signalId) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.isConfirmed, isConfirmed) ||
                other.isConfirmed == isConfirmed) &&
            (identical(other.checkedAt, checkedAt) ||
                other.checkedAt == checkedAt) &&
            const DeepCollectionEquality()
                .equals(other._indicators, _indicators) &&
            (identical(other.alignmentScore, alignmentScore) ||
                other.alignmentScore == alignmentScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      signalId,
      timeframe,
      isConfirmed,
      checkedAt,
      const DeepCollectionEquality().hash(_indicators),
      alignmentScore);

  /// Create a copy of SignalConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignalConfirmationImplCopyWith<_$SignalConfirmationImpl> get copyWith =>
      __$$SignalConfirmationImplCopyWithImpl<_$SignalConfirmationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignalConfirmationImplToJson(
      this,
    );
  }
}

abstract class _SignalConfirmation implements SignalConfirmation {
  const factory _SignalConfirmation(
      {required final String signalId,
      required final TimeframeType timeframe,
      required final bool isConfirmed,
      required final DateTime checkedAt,
      required final Map<String, dynamic> indicators,
      required final double alignmentScore}) = _$SignalConfirmationImpl;

  factory _SignalConfirmation.fromJson(Map<String, dynamic> json) =
      _$SignalConfirmationImpl.fromJson;

  @override
  String get signalId;
  @override
  TimeframeType get timeframe;
  @override
  bool get isConfirmed;
  @override
  DateTime get checkedAt;
  @override
  Map<String, dynamic> get indicators;
  @override
  double get alignmentScore;

  /// Create a copy of SignalConfirmation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignalConfirmationImplCopyWith<_$SignalConfirmationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
