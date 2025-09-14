import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:flutter/material.dart';

class PaginationButton extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final VoidCallback onDoubleTap;

  const PaginationButton({super.key, required this.text, required this.ttsService, required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => ttsService.speakVi(text),
        onDoubleTap: onDoubleTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.black,
          ),
          child: Center(
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
