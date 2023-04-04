// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'effect.dart';

part 'alarm.g.dart';

enum AlarmType {
  Sunrise,
  Silvester,
  Strobo,
}

extension AlarmTypeExtension on AlarmType {
  String get name {
    switch (this) {
      case AlarmType.Sunrise:
        return "Sunrise";
      case AlarmType.Silvester:
        return "Silvester";
      case AlarmType.Strobo:
        return "Strobo";
    }
  }
}

DateTime _timeFromJson(int time) => DateTime.fromMillisecondsSinceEpoch(time);
int _timeToJson(DateTime time) => time.millisecondsSinceEpoch;

@JsonSerializable()
class AlarmConfig with WithRange implements EffectConfig {
  static const String name = 'Alarm';

  AlarmConfig({this.alarm_type = AlarmType.Sunrise, required this.ringAt});

  AlarmType alarm_type;

  @JsonKey(
    name: "at_ms_since_1970",
    fromJson: _timeFromJson,
    toJson: _timeToJson,
  )
  DateTime ringAt;

  @override
  Map<String, dynamic> toJson() => {name: _$AlarmConfigToJson(this)};
  factory AlarmConfig.fromInternalJson(Map<String, dynamic> json) =>
      _$AlarmConfigFromJson(json);

  @override
  Widget editor(BuildContext context) => Column(
        children: [
          DropdownButton<AlarmType>(
              value: alarm_type,
              onChanged: (AlarmType? newValue) {
                alarm_type = newValue!;
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
              text,
              TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
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
  Widget get preview => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: text,
        ),
      );

  Widget get text =>
      Text('${weekDayNames[ringAt.weekday]}  ${ringAt.hour}:${ringAt.minute}');

  @override
  String get title => "Alarm";
}

const weekDayNames = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
