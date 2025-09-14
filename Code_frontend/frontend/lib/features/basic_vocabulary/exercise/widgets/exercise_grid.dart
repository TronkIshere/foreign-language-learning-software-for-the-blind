import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/basic_vocabulary/exercise/widgets/exercise_box.dart';
import 'package:flutter/material.dart';

class ExerciseGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final TtsService ttsService;

  const ExerciseGrid({super.key, required this.items, required this.ttsService});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemHeight = constraints.maxHeight / 3;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: itemHeight),
          itemCount: items.length.clamp(0, 6),
          itemBuilder: (context, index) {
            final Map<String, dynamic> entry = items[index];
            final String title = entry.keys.first.toString();
            final String subtitle = entry.values.first.toString();
            return ExerciseBox(title: title, subtitle: subtitle, ttsService: ttsService);
          },
        );
      },
    );
  }
}
