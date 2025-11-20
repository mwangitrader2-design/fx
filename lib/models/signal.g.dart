// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradingSignalImpl _$$TradingSignalImplFromJson(Map<String, dynamic> json) =>
    _$TradingSignalImpl(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      type: $enumDecode(_$SignalTypeEnumMap, json['type']),
      strength: $enumDecode(_$SignalStrengthEnumMap, json['strength']),
      status: $enumDecode(_$SignalStatusEnumMap, json['status']),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      primaryTimeframe:
          $enumDecode(_$TimeframeTypeEnumMap, json['primaryTimeframe']),
      confirmationTimeframe:
          $enumDecode(_$TimeframeTypeEnumMap, json['confirmationTimeframe']),
      entryPrice: (json['entryPrice'] as num).toDouble(),
      stopLoss: (json['stopLoss'] as num).toDouble(),
      takeProfit: (json['takeProfit'] as num).toDouble(),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      indicators: (json['indicators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      technicalAnalysis: json['technicalAnalysis'] as Map<String, dynamic>,
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      executedAt: json['executedAt'] == null
          ? null
          : DateTime.parse(json['executedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      notes: json['notes'] as String?,
      isConfirmedOnLowerTimeframe:
          json['isConfirmedOnLowerTimeframe'] as bool? ?? false,
    );

Map<String, dynamic> _$$TradingSignalImplToJson(_$TradingSignalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'type': _$SignalTypeEnumMap[instance.type]!,
      'strength': _$SignalStrengthEnumMap[instance.strength]!,
      'status': _$SignalStatusEnumMap[instance.status]!,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'primaryTimeframe': _$TimeframeTypeEnumMap[instance.primaryTimeframe]!,
      'confirmationTimeframe':
          _$TimeframeTypeEnumMap[instance.confirmationTimeframe]!,
      'entryPrice': instance.entryPrice,
      'stopLoss': instance.stopLoss,
      'takeProfit': instance.takeProfit,
      'confidenceScore': instance.confidenceScore,
      'indicators': instance.indicators,
      'technicalAnalysis': instance.technicalAnalysis,
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'executedAt': instance.executedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'notes': instance.notes,
      'isConfirmedOnLowerTimeframe': instance.isConfirmedOnLowerTimeframe,
    };

const _$SignalTypeEnumMap = {
  SignalType.buy: 'buy',
  SignalType.sell: 'sell',
  SignalType.hold: 'hold',
};

const _$SignalStrengthEnumMap = {
  SignalStrength.weak: 'weak',
  SignalStrength.moderate: 'moderate',
  SignalStrength.strong: 'strong',
  SignalStrength.veryStrong: 'veryStrong',
};

const _$SignalStatusEnumMap = {
  SignalStatus.pending: 'pending',
  SignalStatus.confirmed: 'confirmed',
  SignalStatus.executed: 'executed',
  SignalStatus.expired: 'expired',
  SignalStatus.cancelled: 'cancelled',
};

const _$TimeframeTypeEnumMap = {
  TimeframeType.M1: 'M1',
  TimeframeType.M5: 'M5',
  TimeframeType.M15: 'M15',
  TimeframeType.M30: 'M30',
  TimeframeType.H1: 'H1',
  TimeframeType.H4: 'H4',
  TimeframeType.D1: 'D1',
  TimeframeType.W1: 'W1',
  TimeframeType.MN1: 'MN1',
};

_$SignalConfirmationImpl _$$SignalConfirmationImplFromJson(
        Map<String, dynamic> json) =>
    _$SignalConfirmationImpl(
      signalId: json['signalId'] as String,
      timeframe: $enumDecode(_$TimeframeTypeEnumMap, json['timeframe']),
      isConfirmed: json['isConfirmed'] as bool,
      checkedAt: DateTime.parse(json['checkedAt'] as String),
      indicators: json['indicators'] as Map<String, dynamic>,
      alignmentScore: (json['alignmentScore'] as num).toDouble(),
    );

Map<String, dynamic> _$$SignalConfirmationImplToJson(
        _$SignalConfirmationImpl instance) =>
    <String, dynamic>{
      'signalId': instance.signalId,
      'timeframe': _$TimeframeTypeEnumMap[instance.timeframe]!,
      'isConfirmed': instance.isConfirmed,
      'checkedAt': instance.checkedAt.toIso8601String(),
      'indicators': instance.indicators,
      'alignmentScore': instance.alignmentScore,
    };
