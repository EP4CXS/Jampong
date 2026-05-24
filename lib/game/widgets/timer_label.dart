import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_dash/procedural/procedural.dart';

class TimerLabel extends StatelessWidget {
  const TimerLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: ValueListenableBuilder<int>(
        valueListenable: proceduralTimerSeconds,
        builder: (context, seconds, _) {
          final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
          final remaining = (seconds % 60).toString().padLeft(2, '0');
          return TraslucentBackground(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
            gradient: const [
              Color(0xFFE0E7FF),
              Color(0xFFC7D2FE),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Time $minutes:$remaining',
                style: textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1E293B),
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
