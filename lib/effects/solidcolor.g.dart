// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solidcolor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidColorConfig _$SolidColorConfigFromJson(Map<String, dynamic> json) =>
    SolidColorConfig(
      color:
          json['color'] == null ? Colors.black : _colorFromJson(json['color']),
    );

Map<String, dynamic> _$SolidColorConfigToJson(SolidColorConfig instance) =>
    <String, dynamic>{
      'color': _colorToJson(instance.color),
    };

APIColor _$APIColorFromJson(Map<String, dynamic> json) => APIColor(
      json['red'] as num,
      json['green'] as num,
      json['blue'] as num,
    );

Map<String, dynamic> _$APIColorToJson(APIColor instance) => <String, dynamic>{
      'red': instance.red,
      'green': instance.green,
      'blue': instance.blue,
    };
