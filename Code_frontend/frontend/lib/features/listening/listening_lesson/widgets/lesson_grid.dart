import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

import 'lesson_box.dart';

class LessonGrid extends StatelessWidget {
  final List<Map<String, dynamic>> lessons;
  final TtsService ttsService;
  final String basePath;

  const LessonGrid({super.key, required this.lessons, required this.ttsService, required this.basePath});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double itemHeight = constraints.maxHeight / 4;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: itemHeight),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            String title = lessons[index].keys.first;
            dynamic value = lessons[index].values.first;

            String? path;
            if (value != null && value != false) {
              path = value.toString().startsWith("assets/") ? value.toString() : "$basePath${value.toString()}";
            }

            return LessonBox(text: title, ttsService: ttsService, jsonPath: path);
          },
        );
      },
    );
  }
}
