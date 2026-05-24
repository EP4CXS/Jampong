import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({
    required this.onResume,
    required this.onRestart,
    required this.onExit,
    super.key,
  });

  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ColoredBox(
      color: const Color(0xAA0F172A),
      child: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Paused',
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GameElevatedButton(
                label: 'Resume',
                onPressed: onResume,
              ),
              const SizedBox(height: 12),
              GameElevatedButton.icon(
                label: 'Restart',
                icon: const Icon(Icons.refresh, size: 16),
                onPressed: onRestart,
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onExit,
                child: const Text('Exit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
