import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/basic_vocabulary/unit/unit_page.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final String jsonPath;

  const LessonBox({super.key, required this.text, required this.ttsService, required this.jsonPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi(text),
      onDoubleTap: () => _openUnitPage(context),
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

  void _openUnitPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UnitPage(jsonPath: jsonPath)));
  }
}
