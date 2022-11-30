import 'package:espoxiapp/connection.dart';
import 'package:espoxiapp/effects/solidcolor.dart';
import 'package:espoxiapp/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';

import '../effects/effect.dart';
import 'effectComposer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espoxi'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FutureBuilder(
                        future: Connection().getEffects(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Composer(
                            effects: snapshot.data ?? [],
                            onSaved: (configs) {
                              var blackBackground =
                                  SolidColorConfig(color: Colors.black);
                              blackBackground.range = Range(start: 0, end: 100);
                              configs.insert(
                                0,
                                blackBackground,
                              );
                              Connection().setEffects(configs);
                            },
                          );
                        }),
                  ),
                ),
            child: const Text('go to composer')),
      ),
      drawer: const MainDrawer(),
    );
  }
}
