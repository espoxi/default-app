// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HueShiftConfig _$HueShiftConfigFromJson(Map<String, dynamic> json) =>
    HueShiftConfig(
      degrees_per_led: (json['degrees_per_led'] as num).toDouble(),
      degrees_per_second: (json['degrees_per_second'] as num).toDouble(),
    )..range = Range.fromJson(json['range'] as Map<String, dynamic>);

Map<String, dynamic> _$HueShiftConfigToJson(HueShiftConfig instance) =>
    <String, dynamic>{
      'degrees_per_second': instance.degrees_per_second,
      'degrees_per_led': instance.degrees_per_led,
      'range': instance.range,
    };
