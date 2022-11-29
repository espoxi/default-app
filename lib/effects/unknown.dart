import 'package:flutter/material.dart';
import 'effect.dart';

class UnknownEffectConfig implements EffectConfig {
  const UnknownEffectConfig(this.name, this.json);
  final String name;
  final dynamic json;

  @override
  Map<String, dynamic> toJson() => {name: json};
  @override
  Widget get editor => const Text('Unsupported effect, can\'t edit');

  @override
  Widget get preview => const SizedBox.shrink();

  @override
  String get title => "unsupported effect: $name";
}
