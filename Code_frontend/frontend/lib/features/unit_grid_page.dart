import 'dart:convert';

import 'package:GreenHexagon/features/service/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class UnitGridPage extends StatefulWidget {
  const UnitGridPage({super.key});

  @override
  State<UnitGridPage> createState() => _UnitGridPageState();
}

class _UnitGridPageState extends State<UnitGridPage> {
  Map<String, dynamic>? data;
  final TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data/unit/unit_page_1.json');
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

    List<Map<String, dynamic>> lessons = List<Map<String, dynamic>>.from(data!["Nội dung bài học"]);
    List<Map<String, dynamic>> pagination = List<Map<String, dynamic>>.from(data!["Phân trang"]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double itemHeight = constraints.maxHeight / 4;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: itemHeight,
                    ),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      String text = index < lessons.length
                          ? lessons[index].values.first.toString()
                          : "Unit ${index + 1}";
                      return _buildUnitBox(text);
                    },
                  );
                },
              ),
            ),

            Flexible(
              flex: 1,
              child: Row(
                children: [
                  _buildPaginationButton(pagination[0].keys.first.toUpperCase()),
                  _buildExitButton(),
                  _buildPaginationButton(pagination[1].keys.first.toUpperCase()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaginationButton(String text) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ttsService.speak(text);
        },
        onDoubleTap: () {
          _onPaginationTap(text);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.black,
          ),
          child: Center(
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  Widget _buildExitButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ttsService.speak("QUAY LẠI");
        },
        onDoubleTap: () {
          _onExitTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.black,
          ),
          child: const Center(
            child: Text("QUAY LẠI", style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
    );
  }

  void _onPaginationTap(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(title: Text("Chọn phân trang"), content: Text("Bạn đã chọn: $text")),
    );
  }

  void _onExitTap() {
    Navigator.pop(context);
  }

  Widget _buildUnitBox(String text) {
    return GestureDetector(
      onTap: () {
        ttsService.speak(text);
      },
      onDoubleTap: () {
        _activateUnit(text);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _activateUnit(String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(title: Text("Kích hoạt"), content: Text("Bạn đã chọn: $text")),
    );
  }
}
