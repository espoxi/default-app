import 'package:espoxiapp/effects/hue.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'solidcolor.dart';
import 'unknown.dart';

abstract class EffectConfig {
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
      default:
        return UnknownEffectConfig(name, null);
    }
  }
}

List<String> get allEffectNames => [SolidColorConfig.name, HueShiftConfig.name];
