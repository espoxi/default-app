import 'dart:io';

import 'package:espoxiapp/connection.dart';
import 'package:flutter/material.dart';

class IPSettings extends StatelessWidget {
  IPSettings({super.key, this.onSaved = IPSettings.defaultOnSaved});
  Function(String) onSaved;

  static defaultOnSaved(value) {
    Connection().address = InternetAddress(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'IP Address',
        hintText: Connection().address?.address,
      ),
      onSubmitted: onSaved,
    );
  }
}
