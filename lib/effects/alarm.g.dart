// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmConfig _$AlarmConfigFromJson(Map<String, dynamic> json) => AlarmConfig(
      alarmType: $enumDecodeNullable(_$AlarmTypeEnumMap, json['alarmType']) ??
          AlarmType.sunrise,
      ringAt: _timeFromJson(json['ringAt'] as String),
    )..range = Range.fromJson(json['range'] as Map<String, dynamic>);

Map<String, dynamic> _$AlarmConfigToJson(AlarmConfig instance) =>
    <String, dynamic>{
      'range': instance.range,
      'alarmType': _$AlarmTypeEnumMap[instance.alarmType]!,
      'ringAt': _timeToJson(instance.ringAt),
    };

const _$AlarmTypeEnumMap = {
  AlarmType.sunrise: 'sunrise',
  AlarmType.silvester: 'silvester',
  AlarmType.strobo: 'strobo',
};
