import 'dart:convert';

import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/listening/listening_exercise/widgets/exercis_section.dart';
import 'package:GreenHexagon/features/listening/listening_exercise/widgets/exercise_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListeningExercisePage extends StatefulWidget {
  final String jsonPath;
  const ListeningExercisePage({super.key, required this.jsonPath});

  @override
  State<ListeningExercisePage> createState() => _ListeningExercisePageState();
}

class _ListeningExercisePageState extends State<ListeningExercisePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final String topicVi = data!.keys.firstWhere((k) => k.toString().startsWith("Bài"), orElse: () => "");
    final String topicEn = topicVi.isNotEmpty ? data![topicVi].toString() : "";

    final lessonContent = (data!["Nội dung bài học"] is Map<String, dynamic>)
        ? Map<String, dynamic>.from(data!["Nội dung bài học"])
        : <String, dynamic>{};

    final String translationKey = lessonContent.keys.isNotEmpty ? lessonContent.keys.first : "";
    final String translationValue = translationKey.isNotEmpty ? lessonContent[translationKey] : "";

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            ExerciseSection(
              title: "CHỦ ĐỀ BÀI NGHE",
              subtitle: topicVi,
              ttsKey: "chủ đề bài nghe",
              ttsValue: topicVi,
              ttsService: ttsService,
            ),

            ExerciseSection(
              title: "BÀI NGHE (NHẤP VÀO ĐỂ NGHE)",
              subtitle: topicEn,
              ttsKey: "bài nghe",
              ttsValue: topicEn,
              ttsService: ttsService,
            ),

            ExerciseSection(
              title: "BẢN DỊCH TIẾNG VIỆT",
              subtitle: "$translationKey: $translationValue",
              ttsKey: "bản dịch tiếng việt",
              ttsValue: "$translationKey $translationValue",
              ttsService: ttsService,
            ),

            Flexible(flex: 1, child: ExerciseBackButton(ttsService: ttsService)),
          ],
        ),
      ),
    );
  }
}
