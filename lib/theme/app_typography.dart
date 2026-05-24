import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_dash/theme/app_colors.dart';

class AppTypography {
  const AppTypography._();

  static TextTheme textTheme = AppTextStyles.textTheme.copyWith(
    displayLarge: _baseStyle.copyWith(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
    displayMedium: _baseStyle.copyWith(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 1.15,
    ),
    headlineLarge: _baseStyle.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.2,
    ),
    headlineMedium: _baseStyle.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      height: 1.25,
    ),
    headlineSmall: _baseStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleLarge: _baseStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    titleMedium: _baseStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    bodyLarge: _baseStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.onDarkMuted,
      height: 1.5,
    ),
    bodyMedium: _baseStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onDarkMuted,
      height: 1.5,
    ),
    labelLarge: _baseStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: .2,
      height: 1.2,
    ),
  );

  static const TextStyle _baseStyle = TextStyle(
    fontFamily: 'Google Sans',
    package: AppTextStyles.package,
    color: AppColors.onDark,
  );
}
