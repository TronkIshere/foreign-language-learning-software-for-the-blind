import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonDebugPage extends StatefulWidget {
  const JsonDebugPage({super.key});

  @override
  State<JsonDebugPage> createState() => _JsonDebugPageState();
}

class _JsonDebugPageState extends State<JsonDebugPage> {
  String status = "Chưa load";
  String preview = "";
  int byteLength = 0;

  @override
  void initState() {
    super.initState();
    checkJson();
  }

  Future<void> checkJson() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final exists = manifestMap.containsKey('assets/data/unit/unit_page_1.json');

      if (!exists) {
        setState(() {
          status = "❌ Không tìm thấy trong AssetManifest.json";
        });
        return;
      }

      final byteData = await rootBundle.load('assets/data/unit/unit_1.json');
      byteLength = byteData.lengthInBytes;

      String jsonString = utf8.decode(byteData.buffer.asUint8List());
      if (jsonString.startsWith('\uFEFF')) {
        jsonString = jsonString.replaceFirst('\uFEFF', '');
      }

      setState(() {
        status = "✅ Tìm thấy và load thành công";
        preview = jsonString.substring(0, min(200, jsonString.length));
      });
    } catch (e) {
      setState(() {
        status = "⚠️ Lỗi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kiểm tra JSON")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Trạng thái: $status", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Kích thước file: $byteLength bytes"),
            const SizedBox(height: 8),
            const Text("Preview nội dung:"),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(child: Text(preview.isEmpty ? "(Không có dữ liệu)" : preview)),
            ),
          ],
        ),
      ),
    );
  }
}
