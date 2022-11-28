import 'package:espoxiapp/widgets/settings/ip.dart';
import 'package:flutter/material.dart';

import 'ip.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IPSettings(),
          ),
        ],
      ),
    );
  }
}
