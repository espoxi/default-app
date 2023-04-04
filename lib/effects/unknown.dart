import 'package:flutter/material.dart';
import 'effect.dart';

class UnknownEffectConfig with WithRange implements EffectConfig {
  UnknownEffectConfig(this.name, this.json);
  final String name;
  final dynamic json;

  @override
  Map<String, dynamic> toJson() => {name: json};
  @override
  Widget editor(BuildContext context) =>
      const Text('Unsupported effect, can\'t edit');

  @override
  Widget get preview => const SizedBox.shrink();

  @override
  String get title => "unsupported effect: $name";
}
