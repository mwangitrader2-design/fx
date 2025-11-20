// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketDataImpl _$$MarketDataImplFromJson(Map<String, dynamic> json) =>
    _$MarketDataImpl(
      symbol: json['symbol'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      bid: (json['bid'] as num?)?.toDouble(),
      ask: (json['ask'] as num?)?.toDouble(),
      spread: (json['spread'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MarketDataImplToJson(_$MarketDataImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'timestamp': instance.timestamp.toIso8601String(),
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
      'bid': instance.bid,
      'ask': instance.ask,
      'spread': instance.spread,
    };

_$CandleStickImpl _$$CandleStickImplFromJson(Map<String, dynamic> json) =>
    _$CandleStickImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
    );

Map<String, dynamic> _$$CandleStickImplToJson(_$CandleStickImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
    };

_$MarketSymbolImpl _$$MarketSymbolImplFromJson(Map<String, dynamic> json) =>
    _$MarketSymbolImpl(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      pipSize: (json['pipSize'] as num).toDouble(),
      minLotSize: (json['minLotSize'] as num).toDouble(),
      maxLotSize: (json['maxLotSize'] as num).toDouble(),
      lotStep: (json['lotStep'] as num).toDouble(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$MarketSymbolImplToJson(_$MarketSymbolImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'category': instance.category,
      'pipSize': instance.pipSize,
      'minLotSize': instance.minLotSize,
      'maxLotSize': instance.maxLotSize,
      'lotStep': instance.lotStep,
      'isActive': instance.isActive,
    };
