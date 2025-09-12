import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  String _currentLanguage = "vi-VN";

  TtsService() {
    _flutterTts.setLanguage(_currentLanguage);
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setVolume(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.stop();
    await Future.delayed(const Duration(milliseconds: 100)); //
    await _flutterTts.speak(text);
  }

  Future<void> setLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    await _flutterTts.setLanguage(languageCode);
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> speakVi(String text) async {
    await setLanguage("vi-VN");
    await speak(text);
  }

  Future<void> speakEn(String text) async {
    await setLanguage("en-US");
    await speak(text);
  }

  Future<void> spellOutEn(String word) async {
    await setLanguage("en-US");
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (char.trim().isEmpty) continue;
      await _flutterTts.speak(char);
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
