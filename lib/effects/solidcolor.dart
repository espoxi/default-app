import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

part 'solidcolor.g.dart';

@JsonSerializable()
class SolidColorConfig implements EffectConfig {
  SolidColorConfig({required this.color});

  static String name = 'solidColor';

  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  Color color;

  @override
  Map<String, dynamic> toJson() => {
        name: {_$SolidColorConfigToJson(this)}
      };
  factory SolidColorConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$SolidColorConfigFromJson(json);

  @override
  Widget get editor => const Text('Unsupported effect, can\'t edit');

  @override
  Widget get preview => ColorPicker(
        pickerColor: color,
        paletteType: PaletteType.hueWheel,
        onColorChanged: (Color value) {
          color = (value);
        },
      );

  @override
  String get title => "Solid Base Color";
}

@JsonSerializable()
class APIColor {
  APIColor(this.red, this.green, this.blue);
  num red;
  num green;
  num blue;
  factory APIColor.fromColor(Color color) {
    return APIColor(color.red / 255, color.green / 255, color.blue / 255);
  }
  Color toColor() {
    return Color.fromARGB(
        255, (red * 255).toInt(), (green * 255).toInt(), (blue * 255).toInt());
  }

  Map<String, dynamic> toJson() => _$APIColorToJson(this);
  factory APIColor.fromJson(Map<String, dynamic> json) =>
      _$APIColorFromJson(json);
}

Color _colorFromJson(dynamic json) {
  return APIColor.fromJson(json).toColor();
}

Map<String, dynamic> _colorToJson(Color color) {
  return APIColor.fromColor(color).toJson();
}
