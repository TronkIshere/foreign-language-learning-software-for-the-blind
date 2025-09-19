import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/listening/listening_exercise/listening_exercise_page.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final String? jsonPath;

  const LessonBox({super.key, required this.text, required this.ttsService, required this.jsonPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi(text),
      onDoubleTap: () => _handleDoubleTap(context),
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

  void _handleDoubleTap(BuildContext context) {
    if (jsonPath == null || jsonPath == "false") {
      ttsService.speakVi("Chưa có bài này");
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => ListeningExercisePage(jsonPath: jsonPath!)));
  }
}
