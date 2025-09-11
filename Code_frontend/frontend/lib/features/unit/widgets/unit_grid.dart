import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';

import 'unit_box.dart';

class UnitGrid extends StatelessWidget {
  final List<Map<String, dynamic>> lessons;
  final TtsService ttsService;

  const UnitGrid({super.key, required this.lessons, required this.ttsService});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemHeight = constraints.maxHeight / 4;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: itemHeight),
          itemCount: 8,
          itemBuilder: (context, index) {
            String text = index < lessons.length ? lessons[index].keys.first.toString() : "Unit ${index + 1}";
            return UnitBox(text: text, ttsService: ttsService);
          },
        );
      },
    );
  }
}
