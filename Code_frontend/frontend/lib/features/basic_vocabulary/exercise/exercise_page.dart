import 'dart:convert';

import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/basic_vocabulary/exercise/widgets/exercise_back_button.dart';
import 'package:GreenHexagon/features/basic_vocabulary/exercise/widgets/exercise_grid.dart';
import 'package:GreenHexagon/features/basic_vocabulary/exercise/widgets/exercise_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ExercisePage extends StatefulWidget {
  final String jsonPath;
  const ExercisePage({super.key, required this.jsonPath});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  Map<String, dynamic>? data;
  final TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    loadJson(widget.jsonPath);
  }

  Future<void> loadJson(String path) async {
    String jsonString = await rootBundle.loadString(path);
    final jsonData = json.decode(jsonString);
    setState(() {
      data = jsonData;
    });

    final String topicVi = jsonData.keys.firstWhere((k) => k.toString().startsWith("Bài"), orElse: () => "");

    if (topicVi.isNotEmpty) {
      final String topicEn = jsonData[topicVi]?.toString() ?? "";
      await ttsService.speakVi(topicVi);
      await Future.delayed(const Duration(milliseconds: 2000));
      await ttsService.speakEn(topicEn);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String topicVi = data!.keys.firstWhere((k) => k.toString().startsWith("Bài"), orElse: () => "");
    final String topicEn = topicVi.isNotEmpty ? data![topicVi].toString() : "";

    final List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(data!["Nội dung bài học"] ?? []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: ExerciseHeader(topicVi: topicVi, topicEn: topicEn),
            ),
            Flexible(
              flex: 4,
              child: ExerciseGrid(items: items, ttsService: ttsService),
            ),
            Flexible(flex: 1, child: BackButtonSection(ttsService: ttsService)),
          ],
        ),
      ),
    );
  }
}
