import 'package:espoxiapp/effects/hue.dart';
import 'package:espoxiapp/effects/strobo.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'solidcolor.dart';
import 'unknown.dart';
import 'invert.dart';

part 'effect.g.dart';

@JsonSerializable()
class Range {
  Range({required this.start, required this.end});
  int start;
  int end;

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);
  Map<String, dynamic> toJson() => _$RangeToJson(this);
}

mixin WithRange {
  Range range = Range(start: 0, end: 10);
}

abstract class EffectConfig with WithRange {
  String get title;

  Map<String, dynamic> toJson();

  Widget get editor;

  Widget get preview;
  factory EffectConfig.fromJson(Map<String, dynamic> json) {
    var innerJson = json.values.first;
    switch (json.keys.first) {
      case SolidColorConfig.name:
        return SolidColorConfig.fromInternalJson(innerJson);
      case HueShiftConfig.name:
        return HueShiftConfig.fromInternalJson(innerJson);
      case InversionConfig.name:
        return InversionConfig.fromInternalJson(innerJson);
      case StroboConfig.name:
        return StroboConfig.fromInternalJson(innerJson);
      default:
        return UnknownEffectConfig(json.keys.first, innerJson);
    }
  }

  factory EffectConfig.fromName(String name) {
    switch (name) {
      case SolidColorConfig.name:
        return SolidColorConfig();
      case HueShiftConfig.name:
        return HueShiftConfig(degrees_per_led: 0, degrees_per_second: 0);
      case InversionConfig.name:
        return InversionConfig();
      case StroboConfig.name:
        return StroboConfig(frequency_hz: 1.0);
      default:
        return UnknownEffectConfig(name, null);
    }
  }
}

List<String> get allEffectNames => [
      SolidColorConfig.name,
      HueShiftConfig.name,
      InversionConfig.name,
      StroboConfig.name,
    ];
