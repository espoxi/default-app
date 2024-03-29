import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

part 'invert.g.dart';

@JsonSerializable()
class InversionConfig with WithRange, ChangeNotifier implements EffectConfig {
  static const String name = 'Invert';

  InversionConfig();

  @override
  Map<String, dynamic> toJson() => {name: _$InversionConfigToJson(this)};
  factory InversionConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$InversionConfigFromJson(json);

  @override
  Widget editor(BuildContext context) => const SizedBox.shrink();

  @override
  Widget get preview => const SizedBox.shrink();

  @override
  String get title => "Inverter";
}
