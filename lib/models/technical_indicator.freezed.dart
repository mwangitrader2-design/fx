// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'technical_indicator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TechnicalIndicator _$TechnicalIndicatorFromJson(Map<String, dynamic> json) {
  return _TechnicalIndicator.fromJson(json);
}

/// @nodoc
mixin _$TechnicalIndicator {
  IndicatorType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  IndicatorSignal get signal => throw _privateConstructorUsedError;
  DateTime get calculatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalData =>
      throw _privateConstructorUsedError;
  String? get interpretation => throw _privateConstructorUsedError;

  /// Serializes this TechnicalIndicator to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TechnicalIndicator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TechnicalIndicatorCopyWith<TechnicalIndicator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicalIndicatorCopyWith<$Res> {
  factory $TechnicalIndicatorCopyWith(
          TechnicalIndicator value, $Res Function(TechnicalIndicator) then) =
      _$TechnicalIndicatorCopyWithImpl<$Res, TechnicalIndicator>;
  @useResult
  $Res call(
      {IndicatorType type,
      String name,
      double value,
      IndicatorSignal signal,
      DateTime calculatedAt,
      Map<String, dynamic>? additionalData,
      String? interpretation});
}

/// @nodoc
class _$TechnicalIndicatorCopyWithImpl<$Res, $Val extends TechnicalIndicator>
    implements $TechnicalIndicatorCopyWith<$Res> {
  _$TechnicalIndicatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TechnicalIndicator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? value = null,
    Object? signal = null,
    Object? calculatedAt = null,
    Object? additionalData = freezed,
    Object? interpretation = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndicatorType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      signal: null == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as IndicatorSignal,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      additionalData: freezed == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      interpretation: freezed == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TechnicalIndicatorImplCopyWith<$Res>
    implements $TechnicalIndicatorCopyWith<$Res> {
  factory _$$TechnicalIndicatorImplCopyWith(_$TechnicalIndicatorImpl value,
          $Res Function(_$TechnicalIndicatorImpl) then) =
      __$$TechnicalIndicatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IndicatorType type,
      String name,
      double value,
      IndicatorSignal signal,
      DateTime calculatedAt,
      Map<String, dynamic>? additionalData,
      String? interpretation});
}

/// @nodoc
class __$$TechnicalIndicatorImplCopyWithImpl<$Res>
    extends _$TechnicalIndicatorCopyWithImpl<$Res, _$TechnicalIndicatorImpl>
    implements _$$TechnicalIndicatorImplCopyWith<$Res> {
  __$$TechnicalIndicatorImplCopyWithImpl(_$TechnicalIndicatorImpl _value,
      $Res Function(_$TechnicalIndicatorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TechnicalIndicator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? value = null,
    Object? signal = null,
    Object? calculatedAt = null,
    Object? additionalData = freezed,
    Object? interpretation = freezed,
  }) {
    return _then(_$TechnicalIndicatorImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IndicatorType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      signal: null == signal
          ? _value.signal
          : signal // ignore: cast_nullable_to_non_nullable
              as IndicatorSignal,
      calculatedAt: null == calculatedAt
          ? _value.calculatedAt
          : calculatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      additionalData: freezed == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      interpretation: freezed == interpretation
          ? _value.interpretation
          : interpretation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TechnicalIndicatorImpl implements _TechnicalIndicator {
  const _$TechnicalIndicatorImpl(
      {required this.type,
      required this.name,
      required this.value,
      required this.signal,
      required this.calculatedAt,
      final Map<String, dynamic>? additionalData,
      this.interpretation})
      : _additionalData = additionalData;

  factory _$TechnicalIndicatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechnicalIndicatorImplFromJson(json);

  @override
  final IndicatorType type;
  @override
  final String name;
  @override
  final double value;
  @override
  final IndicatorSignal signal;
  @override
  final DateTime calculatedAt;
  final Map<String, dynamic>? _additionalData;
  @override
  Map<String, dynamic>? get additionalData {
    final value = _additionalData;
    if (value == null) return null;
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? interpretation;

  @override
  String toString() {
    return 'TechnicalIndicator(type: $type, name: $name, value: $value, signal: $signal, calculatedAt: $calculatedAt, additionalData: $additionalData, interpretation: $interpretation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechnicalIndicatorImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.signal, signal) || other.signal == signal) &&
            (identical(other.calculatedAt, calculatedAt) ||
                other.calculatedAt == calculatedAt) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData) &&
            (identical(other.interpretation, interpretation) ||
                other.interpretation == interpretation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      name,
      value,
      signal,
      calculatedAt,
      const DeepCollectionEquality().hash(_additionalData),
      interpretation);

  /// Create a copy of TechnicalIndicator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TechnicalIndicatorImplCopyWith<_$TechnicalIndicatorImpl> get copyWith =>
      __$$TechnicalIndicatorImplCopyWithImpl<_$TechnicalIndicatorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechnicalIndicatorImplToJson(
      this,
    );
  }
}

abstract class _TechnicalIndicator implements TechnicalIndicator {
  const factory _TechnicalIndicator(
      {required final IndicatorType type,
      required final String name,
      required final double value,
      required final IndicatorSignal signal,
      required final DateTime calculatedAt,
      final Map<String, dynamic>? additionalData,
      final String? interpretation}) = _$TechnicalIndicatorImpl;

  factory _TechnicalIndicator.fromJson(Map<String, dynamic> json) =
      _$TechnicalIndicatorImpl.fromJson;

  @override
  IndicatorType get type;
  @override
  String get name;
  @override
  double get value;
  @override
  IndicatorSignal get signal;
  @override
  DateTime get calculatedAt;
  @override
  Map<String, dynamic>? get additionalData;
  @override
  String? get interpretation;

  /// Create a copy of TechnicalIndicator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TechnicalIndicatorImplCopyWith<_$TechnicalIndicatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IndicatorValues _$IndicatorValuesFromJson(Map<String, dynamic> json) {
  return _IndicatorValues.fromJson(json);
}

/// @nodoc
mixin _$IndicatorValues {
// Moving Averages
  double? get sma20 => throw _privateConstructorUsedError;
  double? get sma50 => throw _privateConstructorUsedError;
  double? get sma200 => throw _privateConstructorUsedError;
  double? get ema9 => throw _privateConstructorUsedError;
  double? get ema21 => throw _privateConstructorUsedError;
  double? get ema50 => throw _privateConstructorUsedError; // RSI
  double? get rsi => throw _privateConstructorUsedError; // MACD
  double? get macdLine => throw _privateConstructorUsedError;
  double? get macdSignal => throw _privateConstructorUsedError;
  double? get macdHistogram =>
      throw _privateConstructorUsedError; // Bollinger Bands
  double? get bollingerUpper => throw _privateConstructorUsedError;
  double? get bollingerMiddle => throw _privateConstructorUsedError;
  double? get bollingerLower =>
      throw _privateConstructorUsedError; // Stochastic
  double? get stochasticK => throw _privateConstructorUsedError;
  double? get stochasticD => throw _privateConstructorUsedError; // Others
  double? get atr => throw _privateConstructorUsedError;
  double? get adx => throw _privateConstructorUsedError;
  double? get cci => throw _privateConstructorUsedError;
  double? get parabolicSar => throw _privateConstructorUsedError;

  /// Serializes this IndicatorValues to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IndicatorValues
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IndicatorValuesCopyWith<IndicatorValues> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndicatorValuesCopyWith<$Res> {
  factory $IndicatorValuesCopyWith(
          IndicatorValues value, $Res Function(IndicatorValues) then) =
      _$IndicatorValuesCopyWithImpl<$Res, IndicatorValues>;
  @useResult
  $Res call(
      {double? sma20,
      double? sma50,
      double? sma200,
      double? ema9,
      double? ema21,
      double? ema50,
      double? rsi,
      double? macdLine,
      double? macdSignal,
      double? macdHistogram,
      double? bollingerUpper,
      double? bollingerMiddle,
      double? bollingerLower,
      double? stochasticK,
      double? stochasticD,
      double? atr,
      double? adx,
      double? cci,
      double? parabolicSar});
}

/// @nodoc
class _$IndicatorValuesCopyWithImpl<$Res, $Val extends IndicatorValues>
    implements $IndicatorValuesCopyWith<$Res> {
  _$IndicatorValuesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IndicatorValues
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sma20 = freezed,
    Object? sma50 = freezed,
    Object? sma200 = freezed,
    Object? ema9 = freezed,
    Object? ema21 = freezed,
    Object? ema50 = freezed,
    Object? rsi = freezed,
    Object? macdLine = freezed,
    Object? macdSignal = freezed,
    Object? macdHistogram = freezed,
    Object? bollingerUpper = freezed,
    Object? bollingerMiddle = freezed,
    Object? bollingerLower = freezed,
    Object? stochasticK = freezed,
    Object? stochasticD = freezed,
    Object? atr = freezed,
    Object? adx = freezed,
    Object? cci = freezed,
    Object? parabolicSar = freezed,
  }) {
    return _then(_value.copyWith(
      sma20: freezed == sma20
          ? _value.sma20
          : sma20 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma50: freezed == sma50
          ? _value.sma50
          : sma50 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma200: freezed == sma200
          ? _value.sma200
          : sma200 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema9: freezed == ema9
          ? _value.ema9
          : ema9 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema21: freezed == ema21
          ? _value.ema21
          : ema21 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema50: freezed == ema50
          ? _value.ema50
          : ema50 // ignore: cast_nullable_to_non_nullable
              as double?,
      rsi: freezed == rsi
          ? _value.rsi
          : rsi // ignore: cast_nullable_to_non_nullable
              as double?,
      macdLine: freezed == macdLine
          ? _value.macdLine
          : macdLine // ignore: cast_nullable_to_non_nullable
              as double?,
      macdSignal: freezed == macdSignal
          ? _value.macdSignal
          : macdSignal // ignore: cast_nullable_to_non_nullable
              as double?,
      macdHistogram: freezed == macdHistogram
          ? _value.macdHistogram
          : macdHistogram // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerUpper: freezed == bollingerUpper
          ? _value.bollingerUpper
          : bollingerUpper // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerMiddle: freezed == bollingerMiddle
          ? _value.bollingerMiddle
          : bollingerMiddle // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerLower: freezed == bollingerLower
          ? _value.bollingerLower
          : bollingerLower // ignore: cast_nullable_to_non_nullable
              as double?,
      stochasticK: freezed == stochasticK
          ? _value.stochasticK
          : stochasticK // ignore: cast_nullable_to_non_nullable
              as double?,
      stochasticD: freezed == stochasticD
          ? _value.stochasticD
          : stochasticD // ignore: cast_nullable_to_non_nullable
              as double?,
      atr: freezed == atr
          ? _value.atr
          : atr // ignore: cast_nullable_to_non_nullable
              as double?,
      adx: freezed == adx
          ? _value.adx
          : adx // ignore: cast_nullable_to_non_nullable
              as double?,
      cci: freezed == cci
          ? _value.cci
          : cci // ignore: cast_nullable_to_non_nullable
              as double?,
      parabolicSar: freezed == parabolicSar
          ? _value.parabolicSar
          : parabolicSar // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndicatorValuesImplCopyWith<$Res>
    implements $IndicatorValuesCopyWith<$Res> {
  factory _$$IndicatorValuesImplCopyWith(_$IndicatorValuesImpl value,
          $Res Function(_$IndicatorValuesImpl) then) =
      __$$IndicatorValuesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? sma20,
      double? sma50,
      double? sma200,
      double? ema9,
      double? ema21,
      double? ema50,
      double? rsi,
      double? macdLine,
      double? macdSignal,
      double? macdHistogram,
      double? bollingerUpper,
      double? bollingerMiddle,
      double? bollingerLower,
      double? stochasticK,
      double? stochasticD,
      double? atr,
      double? adx,
      double? cci,
      double? parabolicSar});
}

/// @nodoc
class __$$IndicatorValuesImplCopyWithImpl<$Res>
    extends _$IndicatorValuesCopyWithImpl<$Res, _$IndicatorValuesImpl>
    implements _$$IndicatorValuesImplCopyWith<$Res> {
  __$$IndicatorValuesImplCopyWithImpl(
      _$IndicatorValuesImpl _value, $Res Function(_$IndicatorValuesImpl) _then)
      : super(_value, _then);

  /// Create a copy of IndicatorValues
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sma20 = freezed,
    Object? sma50 = freezed,
    Object? sma200 = freezed,
    Object? ema9 = freezed,
    Object? ema21 = freezed,
    Object? ema50 = freezed,
    Object? rsi = freezed,
    Object? macdLine = freezed,
    Object? macdSignal = freezed,
    Object? macdHistogram = freezed,
    Object? bollingerUpper = freezed,
    Object? bollingerMiddle = freezed,
    Object? bollingerLower = freezed,
    Object? stochasticK = freezed,
    Object? stochasticD = freezed,
    Object? atr = freezed,
    Object? adx = freezed,
    Object? cci = freezed,
    Object? parabolicSar = freezed,
  }) {
    return _then(_$IndicatorValuesImpl(
      sma20: freezed == sma20
          ? _value.sma20
          : sma20 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma50: freezed == sma50
          ? _value.sma50
          : sma50 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma200: freezed == sma200
          ? _value.sma200
          : sma200 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema9: freezed == ema9
          ? _value.ema9
          : ema9 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema21: freezed == ema21
          ? _value.ema21
          : ema21 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema50: freezed == ema50
          ? _value.ema50
          : ema50 // ignore: cast_nullable_to_non_nullable
              as double?,
      rsi: freezed == rsi
          ? _value.rsi
          : rsi // ignore: cast_nullable_to_non_nullable
              as double?,
      macdLine: freezed == macdLine
          ? _value.macdLine
          : macdLine // ignore: cast_nullable_to_non_nullable
              as double?,
      macdSignal: freezed == macdSignal
          ? _value.macdSignal
          : macdSignal // ignore: cast_nullable_to_non_nullable
              as double?,
      macdHistogram: freezed == macdHistogram
          ? _value.macdHistogram
          : macdHistogram // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerUpper: freezed == bollingerUpper
          ? _value.bollingerUpper
          : bollingerUpper // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerMiddle: freezed == bollingerMiddle
          ? _value.bollingerMiddle
          : bollingerMiddle // ignore: cast_nullable_to_non_nullable
              as double?,
      bollingerLower: freezed == bollingerLower
          ? _value.bollingerLower
          : bollingerLower // ignore: cast_nullable_to_non_nullable
              as double?,
      stochasticK: freezed == stochasticK
          ? _value.stochasticK
          : stochasticK // ignore: cast_nullable_to_non_nullable
              as double?,
      stochasticD: freezed == stochasticD
          ? _value.stochasticD
          : stochasticD // ignore: cast_nullable_to_non_nullable
              as double?,
      atr: freezed == atr
          ? _value.atr
          : atr // ignore: cast_nullable_to_non_nullable
              as double?,
      adx: freezed == adx
          ? _value.adx
          : adx // ignore: cast_nullable_to_non_nullable
              as double?,
      cci: freezed == cci
          ? _value.cci
          : cci // ignore: cast_nullable_to_non_nullable
              as double?,
      parabolicSar: freezed == parabolicSar
          ? _value.parabolicSar
          : parabolicSar // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IndicatorValuesImpl implements _IndicatorValues {
  const _$IndicatorValuesImpl(
      {this.sma20,
      this.sma50,
      this.sma200,
      this.ema9,
      this.ema21,
      this.ema50,
      this.rsi,
      this.macdLine,
      this.macdSignal,
      this.macdHistogram,
      this.bollingerUpper,
      this.bollingerMiddle,
      this.bollingerLower,
      this.stochasticK,
      this.stochasticD,
      this.atr,
      this.adx,
      this.cci,
      this.parabolicSar});

  factory _$IndicatorValuesImpl.fromJson(Map<String, dynamic> json) =>
      _$$IndicatorValuesImplFromJson(json);

// Moving Averages
  @override
  final double? sma20;
  @override
  final double? sma50;
  @override
  final double? sma200;
  @override
  final double? ema9;
  @override
  final double? ema21;
  @override
  final double? ema50;
// RSI
  @override
  final double? rsi;
// MACD
  @override
  final double? macdLine;
  @override
  final double? macdSignal;
  @override
  final double? macdHistogram;
// Bollinger Bands
  @override
  final double? bollingerUpper;
  @override
  final double? bollingerMiddle;
  @override
  final double? bollingerLower;
// Stochastic
  @override
  final double? stochasticK;
  @override
  final double? stochasticD;
// Others
  @override
  final double? atr;
  @override
  final double? adx;
  @override
  final double? cci;
  @override
  final double? parabolicSar;

  @override
  String toString() {
    return 'IndicatorValues(sma20: $sma20, sma50: $sma50, sma200: $sma200, ema9: $ema9, ema21: $ema21, ema50: $ema50, rsi: $rsi, macdLine: $macdLine, macdSignal: $macdSignal, macdHistogram: $macdHistogram, bollingerUpper: $bollingerUpper, bollingerMiddle: $bollingerMiddle, bollingerLower: $bollingerLower, stochasticK: $stochasticK, stochasticD: $stochasticD, atr: $atr, adx: $adx, cci: $cci, parabolicSar: $parabolicSar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndicatorValuesImpl &&
            (identical(other.sma20, sma20) || other.sma20 == sma20) &&
            (identical(other.sma50, sma50) || other.sma50 == sma50) &&
            (identical(other.sma200, sma200) || other.sma200 == sma200) &&
            (identical(other.ema9, ema9) || other.ema9 == ema9) &&
            (identical(other.ema21, ema21) || other.ema21 == ema21) &&
            (identical(other.ema50, ema50) || other.ema50 == ema50) &&
            (identical(other.rsi, rsi) || other.rsi == rsi) &&
            (identical(other.macdLine, macdLine) ||
                other.macdLine == macdLine) &&
            (identical(other.macdSignal, macdSignal) ||
                other.macdSignal == macdSignal) &&
            (identical(other.macdHistogram, macdHistogram) ||
                other.macdHistogram == macdHistogram) &&
            (identical(other.bollingerUpper, bollingerUpper) ||
                other.bollingerUpper == bollingerUpper) &&
            (identical(other.bollingerMiddle, bollingerMiddle) ||
                other.bollingerMiddle == bollingerMiddle) &&
            (identical(other.bollingerLower, bollingerLower) ||
                other.bollingerLower == bollingerLower) &&
            (identical(other.stochasticK, stochasticK) ||
                other.stochasticK == stochasticK) &&
            (identical(other.stochasticD, stochasticD) ||
                other.stochasticD == stochasticD) &&
            (identical(other.atr, atr) || other.atr == atr) &&
            (identical(other.adx, adx) || other.adx == adx) &&
            (identical(other.cci, cci) || other.cci == cci) &&
            (identical(other.parabolicSar, parabolicSar) ||
                other.parabolicSar == parabolicSar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        sma20,
        sma50,
        sma200,
        ema9,
        ema21,
        ema50,
        rsi,
        macdLine,
        macdSignal,
        macdHistogram,
        bollingerUpper,
        bollingerMiddle,
        bollingerLower,
        stochasticK,
        stochasticD,
        atr,
        adx,
        cci,
        parabolicSar
      ]);

  /// Create a copy of IndicatorValues
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IndicatorValuesImplCopyWith<_$IndicatorValuesImpl> get copyWith =>
      __$$IndicatorValuesImplCopyWithImpl<_$IndicatorValuesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IndicatorValuesImplToJson(
      this,
    );
  }
}

abstract class _IndicatorValues implements IndicatorValues {
  const factory _IndicatorValues(
      {final double? sma20,
      final double? sma50,
      final double? sma200,
      final double? ema9,
      final double? ema21,
      final double? ema50,
      final double? rsi,
      final double? macdLine,
      final double? macdSignal,
      final double? macdHistogram,
      final double? bollingerUpper,
      final double? bollingerMiddle,
      final double? bollingerLower,
      final double? stochasticK,
      final double? stochasticD,
      final double? atr,
      final double? adx,
      final double? cci,
      final double? parabolicSar}) = _$IndicatorValuesImpl;

  factory _IndicatorValues.fromJson(Map<String, dynamic> json) =
      _$IndicatorValuesImpl.fromJson;

// Moving Averages
  @override
  double? get sma20;
  @override
  double? get sma50;
  @override
  double? get sma200;
  @override
  double? get ema9;
  @override
  double? get ema21;
  @override
  double? get ema50; // RSI
  @override
  double? get rsi; // MACD
  @override
  double? get macdLine;
  @override
  double? get macdSignal;
  @override
  double? get macdHistogram; // Bollinger Bands
  @override
  double? get bollingerUpper;
  @override
  double? get bollingerMiddle;
  @override
  double? get bollingerLower; // Stochastic
  @override
  double? get stochasticK;
  @override
  double? get stochasticD; // Others
  @override
  double? get atr;
  @override
  double? get adx;
  @override
  double? get cci;
  @override
  double? get parabolicSar;

  /// Create a copy of IndicatorValues
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IndicatorValuesImplCopyWith<_$IndicatorValuesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TechnicalAnalysis _$TechnicalAnalysisFromJson(Map<String, dynamic> json) {
  return _TechnicalAnalysis.fromJson(json);
}

/// @nodoc
mixin _$TechnicalAnalysis {
  String get symbol => throw _privateConstructorUsedError;
  DateTime get analyzedAt => throw _privateConstructorUsedError;
  IndicatorValues get indicators => throw _privateConstructorUsedError;
  List<TechnicalIndicator> get signals => throw _privateConstructorUsedError;
  IndicatorSignal get overallSignal => throw _privateConstructorUsedError;
  double get bullishScore => throw _privateConstructorUsedError;
  double get bearishScore => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;

  /// Serializes this TechnicalAnalysis to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TechnicalAnalysisCopyWith<TechnicalAnalysis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicalAnalysisCopyWith<$Res> {
  factory $TechnicalAnalysisCopyWith(
          TechnicalAnalysis value, $Res Function(TechnicalAnalysis) then) =
      _$TechnicalAnalysisCopyWithImpl<$Res, TechnicalAnalysis>;
  @useResult
  $Res call(
      {String symbol,
      DateTime analyzedAt,
      IndicatorValues indicators,
      List<TechnicalIndicator> signals,
      IndicatorSignal overallSignal,
      double bullishScore,
      double bearishScore,
      String summary});

  $IndicatorValuesCopyWith<$Res> get indicators;
}

/// @nodoc
class _$TechnicalAnalysisCopyWithImpl<$Res, $Val extends TechnicalAnalysis>
    implements $TechnicalAnalysisCopyWith<$Res> {
  _$TechnicalAnalysisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? analyzedAt = null,
    Object? indicators = null,
    Object? signals = null,
    Object? overallSignal = null,
    Object? bullishScore = null,
    Object? bearishScore = null,
    Object? summary = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as IndicatorValues,
      signals: null == signals
          ? _value.signals
          : signals // ignore: cast_nullable_to_non_nullable
              as List<TechnicalIndicator>,
      overallSignal: null == overallSignal
          ? _value.overallSignal
          : overallSignal // ignore: cast_nullable_to_non_nullable
              as IndicatorSignal,
      bullishScore: null == bullishScore
          ? _value.bullishScore
          : bullishScore // ignore: cast_nullable_to_non_nullable
              as double,
      bearishScore: null == bearishScore
          ? _value.bearishScore
          : bearishScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IndicatorValuesCopyWith<$Res> get indicators {
    return $IndicatorValuesCopyWith<$Res>(_value.indicators, (value) {
      return _then(_value.copyWith(indicators: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TechnicalAnalysisImplCopyWith<$Res>
    implements $TechnicalAnalysisCopyWith<$Res> {
  factory _$$TechnicalAnalysisImplCopyWith(_$TechnicalAnalysisImpl value,
          $Res Function(_$TechnicalAnalysisImpl) then) =
      __$$TechnicalAnalysisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      DateTime analyzedAt,
      IndicatorValues indicators,
      List<TechnicalIndicator> signals,
      IndicatorSignal overallSignal,
      double bullishScore,
      double bearishScore,
      String summary});

  @override
  $IndicatorValuesCopyWith<$Res> get indicators;
}

/// @nodoc
class __$$TechnicalAnalysisImplCopyWithImpl<$Res>
    extends _$TechnicalAnalysisCopyWithImpl<$Res, _$TechnicalAnalysisImpl>
    implements _$$TechnicalAnalysisImplCopyWith<$Res> {
  __$$TechnicalAnalysisImplCopyWithImpl(_$TechnicalAnalysisImpl _value,
      $Res Function(_$TechnicalAnalysisImpl) _then)
      : super(_value, _then);

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? analyzedAt = null,
    Object? indicators = null,
    Object? signals = null,
    Object? overallSignal = null,
    Object? bullishScore = null,
    Object? bearishScore = null,
    Object? summary = null,
  }) {
    return _then(_$TechnicalAnalysisImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      analyzedAt: null == analyzedAt
          ? _value.analyzedAt
          : analyzedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as IndicatorValues,
      signals: null == signals
          ? _value._signals
          : signals // ignore: cast_nullable_to_non_nullable
              as List<TechnicalIndicator>,
      overallSignal: null == overallSignal
          ? _value.overallSignal
          : overallSignal // ignore: cast_nullable_to_non_nullable
              as IndicatorSignal,
      bullishScore: null == bullishScore
          ? _value.bullishScore
          : bullishScore // ignore: cast_nullable_to_non_nullable
              as double,
      bearishScore: null == bearishScore
          ? _value.bearishScore
          : bearishScore // ignore: cast_nullable_to_non_nullable
              as double,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TechnicalAnalysisImpl implements _TechnicalAnalysis {
  const _$TechnicalAnalysisImpl(
      {required this.symbol,
      required this.analyzedAt,
      required this.indicators,
      required final List<TechnicalIndicator> signals,
      required this.overallSignal,
      required this.bullishScore,
      required this.bearishScore,
      required this.summary})
      : _signals = signals;

  factory _$TechnicalAnalysisImpl.fromJson(Map<String, dynamic> json) =>
      _$$TechnicalAnalysisImplFromJson(json);

  @override
  final String symbol;
  @override
  final DateTime analyzedAt;
  @override
  final IndicatorValues indicators;
  final List<TechnicalIndicator> _signals;
  @override
  List<TechnicalIndicator> get signals {
    if (_signals is EqualUnmodifiableListView) return _signals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signals);
  }

  @override
  final IndicatorSignal overallSignal;
  @override
  final double bullishScore;
  @override
  final double bearishScore;
  @override
  final String summary;

  @override
  String toString() {
    return 'TechnicalAnalysis(symbol: $symbol, analyzedAt: $analyzedAt, indicators: $indicators, signals: $signals, overallSignal: $overallSignal, bullishScore: $bullishScore, bearishScore: $bearishScore, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TechnicalAnalysisImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.analyzedAt, analyzedAt) ||
                other.analyzedAt == analyzedAt) &&
            (identical(other.indicators, indicators) ||
                other.indicators == indicators) &&
            const DeepCollectionEquality().equals(other._signals, _signals) &&
            (identical(other.overallSignal, overallSignal) ||
                other.overallSignal == overallSignal) &&
            (identical(other.bullishScore, bullishScore) ||
                other.bullishScore == bullishScore) &&
            (identical(other.bearishScore, bearishScore) ||
                other.bearishScore == bearishScore) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      symbol,
      analyzedAt,
      indicators,
      const DeepCollectionEquality().hash(_signals),
      overallSignal,
      bullishScore,
      bearishScore,
      summary);

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TechnicalAnalysisImplCopyWith<_$TechnicalAnalysisImpl> get copyWith =>
      __$$TechnicalAnalysisImplCopyWithImpl<_$TechnicalAnalysisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TechnicalAnalysisImplToJson(
      this,
    );
  }
}

abstract class _TechnicalAnalysis implements TechnicalAnalysis {
  const factory _TechnicalAnalysis(
      {required final String symbol,
      required final DateTime analyzedAt,
      required final IndicatorValues indicators,
      required final List<TechnicalIndicator> signals,
      required final IndicatorSignal overallSignal,
      required final double bullishScore,
      required final double bearishScore,
      required final String summary}) = _$TechnicalAnalysisImpl;

  factory _TechnicalAnalysis.fromJson(Map<String, dynamic> json) =
      _$TechnicalAnalysisImpl.fromJson;

  @override
  String get symbol;
  @override
  DateTime get analyzedAt;
  @override
  IndicatorValues get indicators;
  @override
  List<TechnicalIndicator> get signals;
  @override
  IndicatorSignal get overallSignal;
  @override
  double get bullishScore;
  @override
  double get bearishScore;
  @override
  String get summary;

  /// Create a copy of TechnicalAnalysis
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TechnicalAnalysisImplCopyWith<_$TechnicalAnalysisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
