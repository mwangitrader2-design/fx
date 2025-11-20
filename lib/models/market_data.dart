import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_data.freezed.dart';
part 'market_data.g.dart';

@freezed
class MarketData with _$MarketData {
  const factory MarketData({
    required String symbol,
    required DateTime timestamp,
    required double open,
    required double high,
    required double low,
    required double close,
    required double volume,
    double? bid,
    double? ask,
    double? spread,
  }) = _MarketData;

  factory MarketData.fromJson(Map<String, dynamic> json) =>
      _$MarketDataFromJson(json);
}

@freezed
class CandleStick with _$CandleStick {
  const factory CandleStick({
    required DateTime timestamp,
    required double open,
    required double high,
    required double low,
    required double close,
    required double volume,
  }) = _CandleStick;

  factory CandleStick.fromJson(Map<String, dynamic> json) =>
      _$CandleStickFromJson(json);
}

@freezed
class MarketSymbol with _$MarketSymbol {
  const factory MarketSymbol({
    required String symbol,
    required String name,
    required String category,
    required double pipSize,
    required double minLotSize,
    required double maxLotSize,
    required double lotStep,
    @Default(true) bool isActive,
  }) = _MarketSymbol;

  factory MarketSymbol.fromJson(Map<String, dynamic> json) =>
      _$MarketSymbolFromJson(json);
}
