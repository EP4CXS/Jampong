import 'package:flutter/material.dart';

/// {@template game_button}
/// Common elevated button for the screens in the game.
/// {@endtemplate}
class GameElevatedButton extends StatelessWidget {
  /// {@macro game_button}
  GameElevatedButton({
    required String label,
    VoidCallback? onPressed,
    this.gradient,
    super.key,
  }) : _child = FilledButton(
          onPressed: onPressed,
          child: Text(label),
        );

  /// {@macro game_button}
  GameElevatedButton.icon({
    required String label,
    required Icon icon,
    VoidCallback? onPressed,
    this.gradient,
    super.key,
  }) : _child = FilledButton.icon(
          icon: icon,
          label: Text(label),
          onPressed: onPressed,
        );

  final Widget _child;

  /// The gradient to use for the background.
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 200,
      decoration: BoxDecoration(
        gradient: gradient ??
            const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7C5CFF),
                Color(0xFF5B8CFF),
              ],
            ),
        border: Border.all(color: const Color(0xFF334155)),
        borderRadius: BorderRadius.circular(94),
        boxShadow: const [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Theme(
        data: theme.copyWith(
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(94),
              ),
              padding: const EdgeInsets.symmetric(vertical: 22),
              textStyle: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        child: _child,
      ),
    );
  }
}
