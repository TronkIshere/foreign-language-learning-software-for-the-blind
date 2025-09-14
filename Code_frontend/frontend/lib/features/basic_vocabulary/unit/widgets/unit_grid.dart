import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

import 'unit_box.dart';

class UnitGrid extends StatelessWidget {
  final List<Map<String, dynamic>> lessons;
  final TtsService ttsService;
  final String basePath;

  const UnitGrid({super.key, required this.lessons, required this.ttsService, required this.basePath});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemHeight = constraints.maxHeight / 4;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: itemHeight),
          itemCount: 8,
          itemBuilder: (context, index) {
            if (index < lessons.length) {
              final String text = lessons[index].keys.first.toString();
              final dynamic value = lessons[index].values.first;

              String? jsonPath;
              if (value != false) {
                jsonPath = "$basePath$value";
              }

              return UnitBox(text: text, ttsService: ttsService, jsonPath: jsonPath);
            } else {
              return UnitBox(text: "Unit ${index + 1}", ttsService: ttsService, jsonPath: null);
            }
          },
        );
      },
    );
  }
}
