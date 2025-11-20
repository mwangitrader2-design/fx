import 'package:freezed_annotation/freezed_annotation.dart';
import 'timeframe.dart';

part 'signal.freezed.dart';
part 'signal.g.dart';

enum SignalType {
  buy,
  sell,
  hold
}

enum SignalStrength {
  weak,
  moderate,
  strong,
  veryStrong
}

enum SignalStatus {
  pending,
  confirmed,
  executed,
  expired,
  cancelled
}

@freezed
class TradingSignal with _$TradingSignal {
  const factory TradingSignal({
    required String id,
    required String symbol,
    required SignalType type,
    required SignalStrength strength,
    required SignalStatus status,
    required DateTime generatedAt,
    required TimeframeType primaryTimeframe,
    required TimeframeType confirmationTimeframe,
    required double entryPrice,
    required double stopLoss,
    required double takeProfit,
    required double confidenceScore,
    required List<String> indicators,
    required Map<String, dynamic> technicalAnalysis,
    DateTime? confirmedAt,
    DateTime? executedAt,
    DateTime? expiresAt,
    String? notes,
    @Default(false) bool isConfirmedOnLowerTimeframe,
  }) = _TradingSignal;

  factory TradingSignal.fromJson(Map<String, dynamic> json) =>
      _$TradingSignalFromJson(json);
}

@freezed
class SignalConfirmation with _$SignalConfirmation {
  const factory SignalConfirmation({
    required String signalId,
    required TimeframeType timeframe,
    required bool isConfirmed,
    required DateTime checkedAt,
    required Map<String, dynamic> indicators,
    required double alignmentScore,
  }) = _SignalConfirmation;

  factory SignalConfirmation.fromJson(Map<String, dynamic> json) =>
      _$SignalConfirmationFromJson(json);
}
