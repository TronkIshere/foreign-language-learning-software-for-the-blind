import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

class ExerciseBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String ttsKey;
  final String ttsValue;
  final TtsService ttsService;

  const ExerciseBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ttsKey,
    required this.ttsValue,
    required this.ttsService,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ttsService.speakVi(ttsKey);
      },
      onDoubleTap: () async {
        if (subtitle.isNotEmpty) {
          await ttsService.speakEn(ttsValue);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(2),
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
