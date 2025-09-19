import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/basic_vocabulary/unit/unit_page.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final String? jsonPath; // cho phép null

  const LessonBox({super.key, required this.text, required this.ttsService, required this.jsonPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (jsonPath == null) {
          ttsService.speakVi("Chưa có bài này");
        } else {
          ttsService.speakVi(text);
        }
      },
      onDoubleTap: () {
        if (jsonPath != null) {
          _openUnitPage(context);
        } else {
          ttsService.speakVi("Chưa có bài này");
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
          ),
        ),
      ),
    );
  }

  void _openUnitPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => UnitPage(jsonPath: jsonPath!)));
  }
}
