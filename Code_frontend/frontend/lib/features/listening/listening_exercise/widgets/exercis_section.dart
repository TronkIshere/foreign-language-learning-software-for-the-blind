import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

import 'exercise_box.dart';

class ExerciseSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String ttsKey;
  final String ttsValue;
  final TtsService ttsService;
  final int flex;

  const ExerciseSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ttsKey,
    required this.ttsValue,
    required this.ttsService,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: ExerciseBox(
          title: title,
          subtitle: subtitle,
          ttsKey: ttsKey,
          ttsValue: ttsValue,
          ttsService: ttsService,
        ),
      ),
    );
  }
}
