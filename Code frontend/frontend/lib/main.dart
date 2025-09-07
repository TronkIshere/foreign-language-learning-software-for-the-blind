import 'package:GreenHexagon/features/demo/demo_tts_page.dart';
import 'package:GreenHexagon/features/demo/esp32_connect_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenHexagon',
      theme: ThemeData.light(),
      home: const Esp32ConnectPage(),
      routes: {'/demo_tts': (_) => const DemoTtsPage(), "/demo_bluetooth": (_) => const Esp32ConnectPage()},
    );
  }
}
