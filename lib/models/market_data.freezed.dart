// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'market_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarketData _$MarketDataFromJson(Map<String, dynamic> json) {
  return _MarketData.fromJson(json);
}

/// @nodoc
mixin _$MarketData {
  String get symbol => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get open => throw _privateConstructorUsedError;
  double get high => throw _privateConstructorUsedError;
  double get low => throw _privateConstructorUsedError;
  double get close => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  double? get bid => throw _privateConstructorUsedError;
  double? get ask => throw _privateConstructorUsedError;
  double? get spread => throw _privateConstructorUsedError;

  /// Serializes this MarketData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketDataCopyWith<MarketData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketDataCopyWith<$Res> {
  factory $MarketDataCopyWith(
          MarketData value, $Res Function(MarketData) then) =
      _$MarketDataCopyWithImpl<$Res, MarketData>;
  @useResult
  $Res call(
      {String symbol,
      DateTime timestamp,
      double open,
      double high,
      double low,
      double close,
      double volume,
      double? bid,
      double? ask,
      double? spread});
}

/// @nodoc
class _$MarketDataCopyWithImpl<$Res, $Val extends MarketData>
    implements $MarketDataCopyWith<$Res> {
  _$MarketDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? timestamp = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
    Object? bid = freezed,
    Object? ask = freezed,
    Object? spread = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      bid: freezed == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as double?,
      ask: freezed == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as double?,
      spread: freezed == spread
          ? _value.spread
          : spread // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketDataImplCopyWith<$Res>
    implements $MarketDataCopyWith<$Res> {
  factory _$$MarketDataImplCopyWith(
          _$MarketDataImpl value, $Res Function(_$MarketDataImpl) then) =
      __$$MarketDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      DateTime timestamp,
      double open,
      double high,
      double low,
      double close,
      double volume,
      double? bid,
      double? ask,
      double? spread});
}

/// @nodoc
class __$$MarketDataImplCopyWithImpl<$Res>
    extends _$MarketDataCopyWithImpl<$Res, _$MarketDataImpl>
    implements _$$MarketDataImplCopyWith<$Res> {
  __$$MarketDataImplCopyWithImpl(
      _$MarketDataImpl _value, $Res Function(_$MarketDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? timestamp = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
    Object? bid = freezed,
    Object? ask = freezed,
    Object? spread = freezed,
  }) {
    return _then(_$MarketDataImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      bid: freezed == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as double?,
      ask: freezed == ask
          ? _value.ask
          : ask // ignore: cast_nullable_to_non_nullable
              as double?,
      spread: freezed == spread
          ? _value.spread
          : spread // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketDataImpl implements _MarketData {
  const _$MarketDataImpl(
      {required this.symbol,
      required this.timestamp,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume,
      this.bid,
      this.ask,
      this.spread});

  factory _$MarketDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketDataImplFromJson(json);

  @override
  final String symbol;
  @override
  final DateTime timestamp;
  @override
  final double open;
  @override
  final double high;
  @override
  final double low;
  @override
  final double close;
  @override
  final double volume;
  @override
  final double? bid;
  @override
  final double? ask;
  @override
  final double? spread;

  @override
  String toString() {
    return 'MarketData(symbol: $symbol, timestamp: $timestamp, open: $open, high: $high, low: $low, close: $close, volume: $volume, bid: $bid, ask: $ask, spread: $spread)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketDataImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.ask, ask) || other.ask == ask) &&
            (identical(other.spread, spread) || other.spread == spread));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, symbol, timestamp, open, high,
      low, close, volume, bid, ask, spread);

  /// Create a copy of MarketData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketDataImplCopyWith<_$MarketDataImpl> get copyWith =>
      __$$MarketDataImplCopyWithImpl<_$MarketDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketDataImplToJson(
      this,
    );
  }
}

abstract class _MarketData implements MarketData {
  const factory _MarketData(
      {required final String symbol,
      required final DateTime timestamp,
      required final double open,
      required final double high,
      required final double low,
      required final double close,
      required final double volume,
      final double? bid,
      final double? ask,
      final double? spread}) = _$MarketDataImpl;

  factory _MarketData.fromJson(Map<String, dynamic> json) =
      _$MarketDataImpl.fromJson;

  @override
  String get symbol;
  @override
  DateTime get timestamp;
  @override
  double get open;
  @override
  double get high;
  @override
  double get low;
  @override
  double get close;
  @override
  double get volume;
  @override
  double? get bid;
  @override
  double? get ask;
  @override
  double? get spread;

  /// Create a copy of MarketData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketDataImplCopyWith<_$MarketDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CandleStick _$CandleStickFromJson(Map<String, dynamic> json) {
  return _CandleStick.fromJson(json);
}

/// @nodoc
mixin _$CandleStick {
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get open => throw _privateConstructorUsedError;
  double get high => throw _privateConstructorUsedError;
  double get low => throw _privateConstructorUsedError;
  double get close => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;

  /// Serializes this CandleStick to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CandleStick
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CandleStickCopyWith<CandleStick> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandleStickCopyWith<$Res> {
  factory $CandleStickCopyWith(
          CandleStick value, $Res Function(CandleStick) then) =
      _$CandleStickCopyWithImpl<$Res, CandleStick>;
  @useResult
  $Res call(
      {DateTime timestamp,
      double open,
      double high,
      double low,
      double close,
      double volume});
}

/// @nodoc
class _$CandleStickCopyWithImpl<$Res, $Val extends CandleStick>
    implements $CandleStickCopyWith<$Res> {
  _$CandleStickCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CandleStick
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandleStickImplCopyWith<$Res>
    implements $CandleStickCopyWith<$Res> {
  factory _$$CandleStickImplCopyWith(
          _$CandleStickImpl value, $Res Function(_$CandleStickImpl) then) =
      __$$CandleStickImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      double open,
      double high,
      double low,
      double close,
      double volume});
}

/// @nodoc
class __$$CandleStickImplCopyWithImpl<$Res>
    extends _$CandleStickCopyWithImpl<$Res, _$CandleStickImpl>
    implements _$$CandleStickImplCopyWith<$Res> {
  __$$CandleStickImplCopyWithImpl(
      _$CandleStickImpl _value, $Res Function(_$CandleStickImpl) _then)
      : super(_value, _then);

  /// Create a copy of CandleStick
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? open = null,
    Object? high = null,
    Object? low = null,
    Object? close = null,
    Object? volume = null,
  }) {
    return _then(_$CandleStickImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      open: null == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double,
      close: null == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandleStickImpl implements _CandleStick {
  const _$CandleStickImpl(
      {required this.timestamp,
      required this.open,
      required this.high,
      required this.low,
      required this.close,
      required this.volume});

  factory _$CandleStickImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandleStickImplFromJson(json);

  @override
  final DateTime timestamp;
  @override
  final double open;
  @override
  final double high;
  @override
  final double low;
  @override
  final double close;
  @override
  final double volume;

  @override
  String toString() {
    return 'CandleStick(timestamp: $timestamp, open: $open, high: $high, low: $low, close: $close, volume: $volume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandleStickImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.close, close) || other.close == close) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, timestamp, open, high, low, close, volume);

  /// Create a copy of CandleStick
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CandleStickImplCopyWith<_$CandleStickImpl> get copyWith =>
      __$$CandleStickImplCopyWithImpl<_$CandleStickImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandleStickImplToJson(
      this,
    );
  }
}

abstract class _CandleStick implements CandleStick {
  const factory _CandleStick(
      {required final DateTime timestamp,
      required final double open,
      required final double high,
      required final double low,
      required final double close,
      required final double volume}) = _$CandleStickImpl;

  factory _CandleStick.fromJson(Map<String, dynamic> json) =
      _$CandleStickImpl.fromJson;

  @override
  DateTime get timestamp;
  @override
  double get open;
  @override
  double get high;
  @override
  double get low;
  @override
  double get close;
  @override
  double get volume;

  /// Create a copy of CandleStick
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CandleStickImplCopyWith<_$CandleStickImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarketSymbol _$MarketSymbolFromJson(Map<String, dynamic> json) {
  return _MarketSymbol.fromJson(json);
}

/// @nodoc
mixin _$MarketSymbol {
  String get symbol => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  double get pipSize => throw _privateConstructorUsedError;
  double get minLotSize => throw _privateConstructorUsedError;
  double get maxLotSize => throw _privateConstructorUsedError;
  double get lotStep => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this MarketSymbol to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarketSymbol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarketSymbolCopyWith<MarketSymbol> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketSymbolCopyWith<$Res> {
  factory $MarketSymbolCopyWith(
          MarketSymbol value, $Res Function(MarketSymbol) then) =
      _$MarketSymbolCopyWithImpl<$Res, MarketSymbol>;
  @useResult
  $Res call(
      {String symbol,
      String name,
      String category,
      double pipSize,
      double minLotSize,
      double maxLotSize,
      double lotStep,
      bool isActive});
}

/// @nodoc
class _$MarketSymbolCopyWithImpl<$Res, $Val extends MarketSymbol>
    implements $MarketSymbolCopyWith<$Res> {
  _$MarketSymbolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarketSymbol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? category = null,
    Object? pipSize = null,
    Object? minLotSize = null,
    Object? maxLotSize = null,
    Object? lotStep = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      pipSize: null == pipSize
          ? _value.pipSize
          : pipSize // ignore: cast_nullable_to_non_nullable
              as double,
      minLotSize: null == minLotSize
          ? _value.minLotSize
          : minLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      maxLotSize: null == maxLotSize
          ? _value.maxLotSize
          : maxLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      lotStep: null == lotStep
          ? _value.lotStep
          : lotStep // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketSymbolImplCopyWith<$Res>
    implements $MarketSymbolCopyWith<$Res> {
  factory _$$MarketSymbolImplCopyWith(
          _$MarketSymbolImpl value, $Res Function(_$MarketSymbolImpl) then) =
      __$$MarketSymbolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String name,
      String category,
      double pipSize,
      double minLotSize,
      double maxLotSize,
      double lotStep,
      bool isActive});
}

/// @nodoc
class __$$MarketSymbolImplCopyWithImpl<$Res>
    extends _$MarketSymbolCopyWithImpl<$Res, _$MarketSymbolImpl>
    implements _$$MarketSymbolImplCopyWith<$Res> {
  __$$MarketSymbolImplCopyWithImpl(
      _$MarketSymbolImpl _value, $Res Function(_$MarketSymbolImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarketSymbol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? category = null,
    Object? pipSize = null,
    Object? minLotSize = null,
    Object? maxLotSize = null,
    Object? lotStep = null,
    Object? isActive = null,
  }) {
    return _then(_$MarketSymbolImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      pipSize: null == pipSize
          ? _value.pipSize
          : pipSize // ignore: cast_nullable_to_non_nullable
              as double,
      minLotSize: null == minLotSize
          ? _value.minLotSize
          : minLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      maxLotSize: null == maxLotSize
          ? _value.maxLotSize
          : maxLotSize // ignore: cast_nullable_to_non_nullable
              as double,
      lotStep: null == lotStep
          ? _value.lotStep
          : lotStep // ignore: cast_nullable_to_non_nullable
              as double,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketSymbolImpl implements _MarketSymbol {
  const _$MarketSymbolImpl(
      {required this.symbol,
      required this.name,
      required this.category,
      required this.pipSize,
      required this.minLotSize,
      required this.maxLotSize,
      required this.lotStep,
      this.isActive = true});

  factory _$MarketSymbolImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketSymbolImplFromJson(json);

  @override
  final String symbol;
  @override
  final String name;
  @override
  final String category;
  @override
  final double pipSize;
  @override
  final double minLotSize;
  @override
  final double maxLotSize;
  @override
  final double lotStep;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'MarketSymbol(symbol: $symbol, name: $name, category: $category, pipSize: $pipSize, minLotSize: $minLotSize, maxLotSize: $maxLotSize, lotStep: $lotStep, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketSymbolImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.pipSize, pipSize) || other.pipSize == pipSize) &&
            (identical(other.minLotSize, minLotSize) ||
                other.minLotSize == minLotSize) &&
            (identical(other.maxLotSize, maxLotSize) ||
                other.maxLotSize == maxLotSize) &&
            (identical(other.lotStep, lotStep) || other.lotStep == lotStep) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, symbol, name, category, pipSize,
      minLotSize, maxLotSize, lotStep, isActive);

  /// Create a copy of MarketSymbol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketSymbolImplCopyWith<_$MarketSymbolImpl> get copyWith =>
      __$$MarketSymbolImplCopyWithImpl<_$MarketSymbolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketSymbolImplToJson(
      this,
    );
  }
}

abstract class _MarketSymbol implements MarketSymbol {
  const factory _MarketSymbol(
      {required final String symbol,
      required final String name,
      required final String category,
      required final double pipSize,
      required final double minLotSize,
      required final double maxLotSize,
      required final double lotStep,
      final bool isActive}) = _$MarketSymbolImpl;

  factory _MarketSymbol.fromJson(Map<String, dynamic> json) =
      _$MarketSymbolImpl.fromJson;

  @override
  String get symbol;
  @override
  String get name;
  @override
  String get category;
  @override
  double get pipSize;
  @override
  double get minLotSize;
  @override
  double get maxLotSize;
  @override
  double get lotStep;
  @override
  bool get isActive;

  /// Create a copy of MarketSymbol
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarketSymbolImplCopyWith<_$MarketSymbolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
