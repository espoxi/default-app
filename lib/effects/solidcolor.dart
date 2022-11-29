import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

@JsonSerializable()
class SolidColorConfig implements EffectConfig {
  static String name = 'solidColor';

  Color color;

  @override
  Map<String, dynamic> toJson() => {name: json};
  @override
  Widget get editor => const Text('Unsupported effect, can\'t edit');

  @override
  Widget get preview => throw UnimplementedError();
}

@JsonSerializable()
class Color {
  Color(this.red, this.green, this.blue);
  num red;
  num green;
  num blue;
}
