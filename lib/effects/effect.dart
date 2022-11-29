import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'solidcolor.dart';
import 'unknown.dart';

abstract class EffectConfig {
  @JsonKey(ignore: true)
  String get title;

  Map<String, dynamic> toJson();

  Widget get editor;

  Widget get preview;
  factory EffectConfig.fromJson(Map<String, dynamic> json) {
    switch (json.keys.first) {
      case 'solidColor':
        return SolidColorConfig.fromJson(json);
      default:
        return UnknownEffectConfig(json.keys.first, json.values.first);
    }
  }
}
