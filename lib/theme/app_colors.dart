import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF5B8CFF);
  static const Color secondary = Color(0xFF7C5CFF);
  static const Color accent = Color(0xFF2ED3B7);
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1E293B);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);
  static const Color onDark = Color(0xFFF8FAFC);
  static const Color onDarkMuted = Color(0xFFCBD5E1);
  static const Color outline = Color(0xFF334155);

  static const ColorScheme colorScheme = ColorScheme.dark(
    primary: primary,
    secondary: secondary,
    tertiary: accent,
    surface: surface,
    error: error,
    onPrimary: onDark,
    onSecondary: onDark,
    onSurface: onDark,
    onError: onDark,
  );
}
