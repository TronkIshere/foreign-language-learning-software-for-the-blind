import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DemoTtsPage extends StatefulWidget {
  const DemoTtsPage({super.key});

  @override
  State<DemoTtsPage> createState() => _DemoTtsPageState();
}

class _DemoTtsPageState extends State<DemoTtsPage> {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speak(String text, String lang) async {
    await _flutterTts.setLanguage(lang);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo Text to Speech"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.record_voice_over),
              label: const Text("Đọc tiếng Việt"),
              onPressed: () {
                _speak("Xin chào, đây là demo phát âm tiếng Việt.", "vi-VN");
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.translate),
              label: const Text("Read English"),
              onPressed: () {
                _speak("Hello, this is a demo of English speech.", "en-US");
              },
            ),
          ],
        ),
      ),
    );
  }
}
