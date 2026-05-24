import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_dash/procedural/procedural.dart';

class LivesLabel extends StatelessWidget {
  const LivesLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ValueListenableBuilder<int>(
        valueListenable: proceduralLives,
        builder: (context, lives, _) {
          return TraslucentBackground(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            gradient: const [
              Color(0xFFFEE2E2),
              Color(0xFFFECACA),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Lives $lives',
                style: textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF7F1D1D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
