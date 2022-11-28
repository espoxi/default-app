import 'package:espoxiapp/common/persistence.dart';
import 'package:espoxiapp/config.dart';
import 'package:espoxiapp/data/wifi.dart';
import 'package:espoxiapp/pages/loading.dart';
import 'package:flutter/material.dart';

import 'home.dart';

const WIFICREDENTIALPATH = 'wificredentials';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieve(Credentials.fromJson, WIFICREDENTIALPATH),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            switch (snapshot.data) {
              case null:
                return ActualSetupPage();
              default:
                return const HomePage();
            }
          } else {
            return const LoadingPage();
          }
        });
  }
}

class ActualSetupPage extends StatefulWidget {
  const ActualSetupPage({super.key});

  @override
  State<ActualSetupPage> createState() => _ActualSetupPageState();
}

class _ActualSetupPageState extends State<ActualSetupPage> {
  bool isConnectedToCorrectNetwork = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Container(
                height: isConnectedToCorrectNetwork ? 0 : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "please turn on your espoxi and connect to its wifi"),
                    Text(
                        "its name should be something like ${WIFI_CREDS.ssid}"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isConnectedToCorrectNetwork = true;
                  });
                },
                child: const Text("I'm done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
