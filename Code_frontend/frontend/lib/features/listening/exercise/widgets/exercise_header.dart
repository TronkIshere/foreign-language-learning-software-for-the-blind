import 'package:flutter/material.dart';

class ExerciseHeader extends StatelessWidget {
  final String topicVi;
  final String topicEn;

  const ExerciseHeader({super.key, required this.topicVi, required this.topicEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.black,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              topicVi,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(topicEn, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
