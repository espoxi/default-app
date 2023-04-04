import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'effect.dart';

part 'strobo.g.dart';

@JsonSerializable()
class StroboConfig with WithRange implements EffectConfig {
  static const String name = 'Strobo';

  StroboConfig({required this.frequency_hz});

  double frequency_hz;

  @override
  Map<String, dynamic> toJson() => {name: _$StroboConfigToJson(this)};
  factory StroboConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$StroboConfigFromJson(json);

  @override
  //Thats ugly, see #3
  Widget editor(BuildContext context) => _StroboEditor(
        frequency_hz: frequency_hz,
        onValueChanged: (double frequency_hz) {
          this.frequency_hz = frequency_hz;
        },
      );

  @override
  Widget get preview => const SizedBox.shrink();

  @override
  String get title => "Strobo";
}

class _StroboEditor extends StatefulWidget {
  const _StroboEditor(
      {super.key, required this.frequency_hz, required this.onValueChanged});
  final double frequency_hz;

  final void Function(double frequency_hz) onValueChanged;

  @override
  State<_StroboEditor> createState() => __StroboEditorState();
}

class __StroboEditorState extends State<_StroboEditor> {
  double _frequency_hz = 0;

  @override
  void initState() {
    super.initState();
    _frequency_hz = widget.frequency_hz;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Frequency (~${_frequency_hz.round()} Hz)"),
          Slider(
            value: _frequency_hz,
            min: 0.001,
            max: 10,
            label: _frequency_hz.toString(),
            onChanged: (double value) {
              setState(() {
                _frequency_hz = value;
              });
              widget.onValueChanged(_frequency_hz);
            },
          ),
        ],
      ),
    );
  }
}
