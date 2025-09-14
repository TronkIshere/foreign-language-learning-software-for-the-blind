import 'dart:convert';

import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/listening/listening_lesson/widgets/lesson_grid.dart';
import 'package:GreenHexagon/features/listening/listening_lesson/widgets/pagination_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListeningLessonPage extends StatefulWidget {
  final String jsonPath;
  const ListeningLessonPage({super.key, required this.jsonPath});

  @override
  State<ListeningLessonPage> createState() => _ListeningLessonPageState();
}

class _ListeningLessonPageState extends State<ListeningLessonPage> {
  Map<String, dynamic>? data;
  String? basePath;
  final TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    loadJson(widget.jsonPath);
  }

  Future<void> loadJson(String path) async {
    setState(() {
      data = null;
      basePath = null;
    });

    String jsonString = await rootBundle.loadString(path);
    final jsonData = json.decode(jsonString);

    setState(() {
      data = jsonData;
      basePath = jsonData["basePath"];
    });
  }

  String? resolvePath(dynamic value) {
    if (value == null || value == false || (value is String && value.isEmpty)) {
      return null;
    }
    if (value is String) {
      if (value.startsWith("assets/")) {
        return value;
      } else if (basePath != null) {
        return "$basePath$value";
      }
      return value;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    List<Map<String, dynamic>> lessons = List<Map<String, dynamic>>.from(data!["Nội dung bài học"]);
    List<Map<String, dynamic>> pagination = List<Map<String, dynamic>>.from(data!["Phân trang"]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: LessonGrid(lessons: lessons, ttsService: ttsService, basePath: basePath ?? ""),
            ),
            Flexible(
              flex: 1,
              child: PaginationRow(
                pagination: pagination,
                ttsService: ttsService,
                onExit: () => Navigator.pop(context),
                onNavigate: (String? newPath, String actionText) {
                  final resolved = resolvePath(newPath);
                  if (resolved == null) {
                    ttsService.speak("Không thể $actionText");
                  } else {
                    loadJson(resolved);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
