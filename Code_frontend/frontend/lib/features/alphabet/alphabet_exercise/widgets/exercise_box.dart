import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

class ExerciseBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final TtsService ttsService;

  const ExerciseBox({super.key, required this.title, required this.subtitle, required this.ttsService});

  bool _isEnglish(String text) {
    final englishRegex = RegExp(r'^[a-zA-Z\s]+$');
    return englishRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ttsService.speakVi(title);
        await Future.delayed(const Duration(milliseconds: 1000));

        if (_isEnglish(subtitle)) {
          await ttsService.speakEn(subtitle);
          await Future.delayed(const Duration(milliseconds: 1500));
          await ttsService.spellOutEn(subtitle);
        } else {
          await ttsService.speakVi(subtitle);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            "$title: $subtitle",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
