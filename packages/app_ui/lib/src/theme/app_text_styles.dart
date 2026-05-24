import 'package:flutter/material.dart';

/// Text styles used in the app.
class AppTextStyles {
  /// Creates a [AppTextStyles].
  const AppTextStyles();

  /// Package name
  static const package = 'app_ui';

  /// Creates a [TextTheme] from the text styles.
  static TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  static const TextStyle _commonStyle = TextStyle(
    fontFamily: 'Google Sans',
    color: Color(0xFFF8FAFC),
    package: package,
    decorationColor: Color(0xFFF8FAFC),
  );

  /// Display large text style.
  static TextStyle get displayLarge => _commonStyle.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
      );

  /// Display medium text style.
  static TextStyle get displayMedium => _commonStyle.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w700,
      );

  /// Display small text style.
  static TextStyle get displaySmall => _commonStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  /// Headline large text style.
  static TextStyle get headlineLarge => _commonStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );

  /// Headline medium text style.
  static TextStyle get headlineMedium => _commonStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      );

  /// Headline small text style.
  static TextStyle get headlineSmall => _commonStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      );

  /// Title large text style.
  static TextStyle get titleLarge => _commonStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  /// Title medium text style.
  static TextStyle get titleMedium => _commonStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  /// Title small text style.
  static TextStyle get titleSmall => _commonStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  /// Body large text style.
  static TextStyle get bodyLarge => _commonStyle.copyWith(
        fontSize: 16,
        color: const Color(0xFFCBD5E1),
        height: 1.5,
      );

  /// Body medium text style.
  static TextStyle get bodyMedium => _commonStyle.copyWith(
        fontSize: 14,
        color: const Color(0xFFCBD5E1),
      );

  /// Body small text style.
  static TextStyle get bodySmall => _commonStyle.copyWith(
        fontSize: 12,
        color: const Color(0xFFCBD5E1),
      );

  /// Label large text style.
  static TextStyle get labelLarge => _commonStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  /// Label medium text style.
  static TextStyle get labelMedium => _commonStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  /// Label small text style.
  static TextStyle get labelSmall => _commonStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );
}
