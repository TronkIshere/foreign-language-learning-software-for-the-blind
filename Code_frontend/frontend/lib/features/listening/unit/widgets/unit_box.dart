import 'package:GreenHexagon/features/listening/exercise/exercise_page.dart';
import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';

class UnitBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final String jsonPath;

  const UnitBox({super.key, required this.text, required this.ttsService, required this.jsonPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi(text),
      onDoubleTap: () => _openExercisePage(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _openExercisePage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ExercisePage(jsonPath: jsonPath)));
  }
}
