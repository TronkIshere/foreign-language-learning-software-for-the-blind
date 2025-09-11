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
    await _flutterTts.speak(text);
  }

  Future<void> setLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    await _flutterTts.setLanguage(languageCode);
  }

  Future<void> speakVi(String text) async {
    await setLanguage("vi-VN");
    await speak(text);
  }

  Future<void> speakEn(String text) async {
    await setLanguage("en-US");
    await speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
