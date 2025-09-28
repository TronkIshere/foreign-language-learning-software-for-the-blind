import 'package:GreenHexagon/core/service/braille_map.dart';
import 'package:GreenHexagon/core/service/esp32_bluetooth_service.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  final Esp32BluetoothService _esp32 = Esp32BluetoothService();
  String _currentLanguage = "vi-VN";

  TtsService() {
    _flutterTts.setLanguage(_currentLanguage);
    _flutterTts.setSpeechRate(0.5);
    _flutterTts.setVolume(1.0);
  }

  Future<void> speak(String text) async {
    await _flutterTts.stop();
    await Future.delayed(const Duration(milliseconds: 100));
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

    if (_esp32.connection == null || !_esp32.connection!.isConnected) {
      await _esp32.connect();
    }

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (char.trim().isEmpty) continue;
      await _flutterTts.speak(char);

      if (brailleMap.containsKey(char.toLowerCase())) {
        await _esp32.sendBraille(brailleMap[char.toLowerCase()]!);
        print(char);
      }

      await Future.delayed(const Duration(milliseconds: 2000));
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
