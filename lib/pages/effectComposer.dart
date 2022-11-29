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

class EffectState {
  EffectState(
      {required this.config, this.enabled = true, this.expanded = false});
  EffectConfig config;
  bool expanded;
  bool enabled;
}

class _ComposerState extends State<Composer> {
  @override
  void initState() {
    super.initState();
    effects = widget.effects.map((e) => EffectState(config: e)).toList();
  }

  List<EffectState> effects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Composer'),
      ),
      body: ListView(children: [
        ...effects
            .map((effect) => ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        effect.config.title,
                        style: !effect.enabled
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : null,
                      ),
                      if (!effect.expanded)
                        Expanded(child: effect.config.preview),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setState(() => effects.remove(effect)),
                      ),
                    ],
                  ),
                  onExpansionChanged: (value) =>
                      setState(() => effect.expanded = value),
                  children: [
                    effect.config.editor,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () =>
                              setState(() => effect.enabled = !effect.enabled),
                          child: Text(effect.enabled ? 'Disable' : 'Enable'),
                        ),
                      ],
                    ),
                  ],
                ))
            .toList(),
        //TODO: add a button to add a new effect to the stack (choose from dropdown)
      ]),
      endDrawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.onSaved(effects
            .where((element) => element.enabled)
            .map((e) => e.config)
            .toList()),
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
