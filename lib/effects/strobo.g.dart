// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strobo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StroboConfig _$StroboConfigFromJson(Map<String, dynamic> json) => StroboConfig(
      frequency_hz: (json['frequency_hz'] as num).toDouble(),
    )..range = Range.fromJson(json['range'] as Map<String, dynamic>);

Map<String, dynamic> _$StroboConfigToJson(StroboConfig instance) =>
    <String, dynamic>{
      'frequency_hz': instance.frequency_hz,
      'range': instance.range,
    };
