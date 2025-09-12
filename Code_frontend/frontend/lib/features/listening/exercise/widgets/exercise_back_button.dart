import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';

class BackButtonSection extends StatelessWidget {
  final TtsService ttsService;

  const BackButtonSection({super.key, required this.ttsService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ttsService.speakVi("Quay lại");
      },
      onDoubleTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: const Center(
          child: Text("QUAY LẠI", style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}
