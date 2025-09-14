import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/alphabet/alphabet_exercise/alphabet_exercise_page.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final String? jsonPath;

  const LessonBox({super.key, required this.text, required this.ttsService, required this.jsonPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (jsonPath == null) {
          await ttsService.speakVi("Bài này chưa có");
        } else {
          final parts = text.split(":");
          if (parts.length > 1) {
            final String title = parts[0].trim();
            final String content = parts[1].trim();

            await ttsService.speakVi("$title:");
            await Future.delayed(const Duration(milliseconds: 800));

            final RegExp letterRegex = RegExp(r'[A-Z]');
            final match = letterRegex.firstMatch(content);
            if (match != null) {
              String firstLetter = match.group(0)!;
              await ttsService.speakEn(firstLetter);
            }
          } else {
            await ttsService.speakVi(text);
          }
        }
      },
      onDoubleTap: () {
        if (jsonPath == null) {
          ttsService.speakVi("Bài này chưa có");
        } else {
          _openUnitPage(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _openUnitPage(BuildContext context) {
    if (jsonPath != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AlphabetExercisePage(jsonPath: jsonPath!)));
    }
  }
}
