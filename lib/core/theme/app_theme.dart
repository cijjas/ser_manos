// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.neutral0,
  primaryColor: AppColors.primary100,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary100,
    primary: AppColors.primary100,
    secondary: AppColors.secondary100,
    error: AppColors.error100,
    background: AppColors.neutral0,
  ),
  textTheme: const TextTheme(
    displayLarge: AppTypography.headline01,
    displayMedium: AppTypography.headline02,
    titleMedium: AppTypography.subtitle01,
    bodyLarge: AppTypography.body01,
    bodyMedium: AppTypography.body02,
    labelLarge: AppTypography.button,
    bodySmall: AppTypography.caption,
    labelSmall: AppTypography.overline,
  ),
);