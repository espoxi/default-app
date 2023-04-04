import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'effect.dart';

part 'alarm.g.dart';

enum AlarmType {
  sunrise,
  silvester,
  strobo,
}

extension AlarmTypeExtension on AlarmType {
  String get name {
    switch (this) {
      case AlarmType.sunrise:
        return "Sunrise";
      case AlarmType.silvester:
        return "Silvester";
      case AlarmType.strobo:
        return "Strobo";
    }
  }
}

DateTime _timeFromJson(String time) =>
    DateTime.fromMillisecondsSinceEpoch(int.parse(time));
String _timeToJson(DateTime time) => time.millisecondsSinceEpoch.toString();

@JsonSerializable()
class AlarmConfig with WithRange implements EffectConfig {
  static const String name = 'Alarm';

  AlarmConfig({this.alarmType = AlarmType.sunrise, required this.ringAt});

  AlarmType alarmType;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime ringAt;

  @override
  Map<String, dynamic> toJson() => {name: _$AlarmConfigToJson(this)};
  factory AlarmConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$AlarmConfigFromJson(json);

  @override
  Widget editor(BuildContext context) => Column(
        children: [
          Text("Alarm"),
          DropdownButton<AlarmType>(
              value: alarmType,
              onChanged: (AlarmType? newValue) {
                alarmType = newValue!;
              },
              items: AlarmType.values
                  .map<DropdownMenuItem<AlarmType>>((AlarmType value) {
                return DropdownMenuItem<AlarmType>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList()),
          Row(
            children: [
              preview,
              TextButton(
                onPressed: () {
                  DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime.now(),
                    maxTime: DateTime.now().add(const Duration(days: 365)),
                    // onChanged: (date) {

                    // },
                    onConfirm: (date) {
                      ringAt = date;
                    },
                    currentTime: DateTime.now(),
                  );
                },
                child: const Text(
                  "change",
                ),
              ),
            ],
          ),
        ],
      );

  @override
  Widget get preview =>
      Text('${ringAt.weekday}  ${ringAt.hour}:${ringAt.minute}');

  @override
  String get title => "Alarm";
}
