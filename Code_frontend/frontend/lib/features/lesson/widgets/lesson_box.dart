import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';

class LessonBox extends StatelessWidget {
  final String text;
  final TtsService ttsService;

  const LessonBox({super.key, required this.text, required this.ttsService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi(text),
      onDoubleTap: () => _activateUnit(context),
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

  void _activateUnit(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(title: const Text("Kích hoạt"), content: Text("Bạn đã chọn: $text")),
    );
  }
}
