import 'package:espoxiapp/connection.dart';
import 'package:espoxiapp/pages/setup.dart';
import 'package:flutter/material.dart';

import 'widgets/settings/settings.dart';

void main() async {
  await Connection().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const SetupPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
