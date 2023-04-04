// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmConfig _$AlarmConfigFromJson(Map<String, dynamic> json) => AlarmConfig(
      alarm_type: $enumDecodeNullable(_$AlarmTypeEnumMap, json['alarm_type']) ??
          AlarmType.Sunrise,
      ringAt: _timeFromJson(json['at_ms_since_1970'] as int),
    )..range = Range.fromJson(json['range'] as Map<String, dynamic>);

Map<String, dynamic> _$AlarmConfigToJson(AlarmConfig instance) =>
    <String, dynamic>{
      'range': instance.range,
      'alarm_type': _$AlarmTypeEnumMap[instance.alarm_type]!,
      'at_ms_since_1970': _timeToJson(instance.ringAt),
    };

const _$AlarmTypeEnumMap = {
  AlarmType.Sunrise: 'Sunrise',
  AlarmType.Silvester: 'Silvester',
  AlarmType.Strobo: 'Strobo',
};
