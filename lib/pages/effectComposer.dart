import 'package:espoxiapp/widgets/mainDrawer.dart';
import 'package:flutter/material.dart';

import '../effects/effect.dart';

class Composer extends StatefulWidget {
  final Function(List<EffectConfig>) onSaved;
  final List<EffectConfig> effects;
  const Composer({super.key, required this.onSaved, this.effects = const []});

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  @override
  void initState() {
    super.initState();
    effects = widget.effects;
  }

  List<EffectConfig> effects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Composer'),
      ),
      body: ListView(
        children: effects
            .map(
              (effect) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  //TODO: add a reorder possibility
                  //TODO: make beautiful
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(effect.title),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              setState(() => effects.remove(effect)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      endDrawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onSaved(effects),
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
