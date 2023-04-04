// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

part 'hue.g.dart';

@JsonSerializable()
class HueShiftConfig with WithRange, ChangeNotifier implements EffectConfig {
  static const String name = 'HueShift';

  HueShiftConfig(
      {required this.degrees_per_led, required this.degrees_per_second});

  double degrees_per_second;
  double degrees_per_led;

  @override
  Map<String, dynamic> toJson() => {name: _$HueShiftConfigToJson(this)};
  factory HueShiftConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$HueShiftConfigFromJson(json);

  @override
  //Thats ugly, see #3
  Widget editor(BuildContext context) => _HueShiftEditor(
        degrees_per_led: degrees_per_led,
        degrees_per_second: degrees_per_second,
        onValueChanged: (double degrees_per_led, double degrees_per_second) {
          this.degrees_per_led = degrees_per_led;
          this.degrees_per_second = degrees_per_second;
        },
      );

  @override
  Widget get preview => const SizedBox.shrink();

  @override
  String get title => "Hue Shifter";
}

class _HueShiftEditor extends StatefulWidget {
  const _HueShiftEditor(
      {super.key,
      required this.degrees_per_second,
      required this.degrees_per_led,
      required this.onValueChanged});
  final double degrees_per_second;
  final double degrees_per_led;

  final void Function(double degrees_per_second, double degrees_per_led)
      onValueChanged;

  @override
  State<_HueShiftEditor> createState() => __HueShiftEditorState();
}

class __HueShiftEditorState extends State<_HueShiftEditor> {
  double _degrees_per_second = 0;
  double _degrees_per_led = 0;

  @override
  void initState() {
    super.initState();
    _degrees_per_second = widget.degrees_per_second;
    _degrees_per_led = widget.degrees_per_led;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text("°/LED: ${_degrees_per_led.round().toString()}"),
          ),
          Slider(
            value: _degrees_per_led,
            min: -100,
            max: 100,
            label: "°/LED: ${_degrees_per_led.round().toString()}",
            onChanged: (double value) {
              setState(() {
                _degrees_per_led = value;
              });
              widget.onValueChanged(
                _degrees_per_led,
                _degrees_per_second,
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text("°/s: ${_degrees_per_second.round().toString()}"),
          ),
          Slider(
            value: _degrees_per_second,
            min: -200,
            max: 200,
            label: "°/s: ${_degrees_per_second.round().toString()}",
            onChanged: (double value) {
              setState(() {
                _degrees_per_second = value;
              });
              widget.onValueChanged(
                _degrees_per_led,
                _degrees_per_second,
              );
            },
          ),
        ],
      ),
    );
  }
}
