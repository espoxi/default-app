import 'dart:io';

import 'package:espoxiapp/connection.dart';
import 'package:flutter/material.dart';

class IPSettings extends StatelessWidget {
  const IPSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'IP Address',
        hintText: Connection().address?.address,
      ),
      onSubmitted: (value) => Connection().address = InternetAddress(value),
    );
  }
}
