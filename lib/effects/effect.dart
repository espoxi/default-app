import 'package:flutter/material.dart';

import 'unknown.dart';

abstract class EffectConfig {
  String get name;
  Map<String, dynamic> toJson();
  Widget get editor;
  factory EffectConfig.fromJson(Map<String, dynamic> json) {
    switch (json.keys.first) {
      default:
        return UnknownEffectConfig(json.keys.first, json.values.first);
    }
  }
}
