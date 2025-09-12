import 'dart:convert';

import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  Map<String, dynamic>? data;
  final TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data/exercise/exercise_page.json');
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

    final String topic = data!["Chủ đề"]?.toString() ?? "";
    final String unit = data!["Unit"]?.toString() ?? "";
    final List<Map<String, dynamic>> items = List<Map<String, dynamic>>.from(data!["Nội dung bài học"] ?? []);
    final List<Map<String, dynamic>> pagination = List<Map<String, dynamic>>.from(data!["Phân trang"] ?? []);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.black,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bài...: $topic",
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(unit, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),

            // Grid (2 columns x 3 rows)
            Flexible(
              flex: 4,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // We want exactly 3 rows inside this Flexible area
                  final double itemHeight = constraints.maxHeight / 3;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: itemHeight,
                    ),
                    itemCount: items.length.clamp(0, 6),
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> entry = items[index];
                      final String title = entry.keys.first.toString();
                      final String subtitle = entry.values.first.toString();
                      return ExerciseBox(
                        title: title,
                        subtitle: subtitle,
                        ttsService: ttsService,
                        onActivate: () {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(title: const Text("Kích hoạt"), content: Text("Bạn đã chọn: $title")),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),

            // Quay lại button (full width)
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  // speak the button label in Vietnamese
                  ttsService.speakVi("Quay lại");
                },
                onDoubleTap: () {
                  String route = "/lesson";
                  if (pagination.length > 2) {
                    final key = pagination[2].keys.first;
                    final val = pagination[2].values.first;
                    if (val is String && val.isNotEmpty) {
                      route = val;
                    }
                  }
                  Navigator.pushReplacementNamed(context, route);
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text("QUAY LẠI", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Single box in the grid
class ExerciseBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final TtsService ttsService;
  final VoidCallback onActivate;

  const ExerciseBox({
    super.key,
    required this.title,
    required this.subtitle,
    required this.ttsService,
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ttsService.speakVi("$title: $subtitle"),
      onDoubleTap: onActivate,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            "$title: $subtitle",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
