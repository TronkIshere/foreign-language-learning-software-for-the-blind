import 'package:GreenHexagon/core/service/tts_service.dart';
import 'package:GreenHexagon/features/sub_menu_page/sub_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  final TtsService ttsService = TtsService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: HomeButton(
                text: "TIẾNG ANH",
                ttsService: ttsService,
                onDoubleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubMenuPage(jsonPath: "assets/data/sub_menu/sub_menu_1.json"),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: HomeButton(
                text: "TIẾNG VIỆT",
                ttsService: ttsService,
                onDoubleTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Chức năng sẽ được cập nhật sau")));
                  ttsService.speakVi("Chức năng sẽ được cập nhật sau");
                },
              ),
            ),
            Expanded(
              child: HomeButton(
                text: "THOÁT",
                ttsService: ttsService,
                onDoubleTap: () {
                  SystemNavigator.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String text;
  final TtsService ttsService;
  final VoidCallback onDoubleTap;

  const HomeButton({super.key, required this.text, required this.ttsService, required this.onDoubleTap});

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
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
