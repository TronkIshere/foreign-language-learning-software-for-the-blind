import 'dart:convert';

import 'package:GreenHexagon/features/lesson/lesson_page.dart';
import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SubMenuPage extends StatefulWidget {
  final String jsonPath;
  const SubMenuPage({super.key, required this.jsonPath});

  @override
  State<SubMenuPage> createState() => _SubMenuPageState();
}

class _SubMenuPageState extends State<SubMenuPage> {
  final TtsService ttsService = TtsService();
  Map<String, dynamic> data = {};
  final String lessonAssetPath = "assets/data/lesson/";

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString(widget.jsonPath);
    final jsonData = json.decode(jsonString);
    setState(() {
      data = Map<String, dynamic>.from(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  ...data.entries.map(
                    (entry) => Expanded(
                      child: LessonButton(
                        text: entry.key,
                        ttsService: ttsService,
                        onDoubleTap: () {
                          final lessonPath = "$lessonAssetPath${entry.value}";
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LessonPage(jsonPath: lessonPath)),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: LessonButton(
                      text: "QUAY LẠI",
                      ttsService: ttsService,
                      onDoubleTap: () {
                        Navigator.pushReplacementNamed(context, "/home");
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class LessonButton extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final VoidCallback onDoubleTap;

  const LessonButton({super.key, required this.text, required this.ttsService, required this.onDoubleTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi(text),
      onDoubleTap: onDoubleTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
