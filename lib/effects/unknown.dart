import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

class UnknownEffectConfig implements EffectConfig {
  const UnknownEffectConfig(this.name, this.json);
  final String name;
  final dynamic json;

  @override
  Map<String, dynamic> toJson() => {name: json};
  @override
  Widget get editor => const Text('Unsupported effect, can\'t edit');
}
