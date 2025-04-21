// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.neutral0,
  primaryColor: AppColors.primary100,

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary100,
    brightness: Brightness.light,

    // PRIMARY
    primary: AppColors.primary100,
    onPrimary: AppColors.neutral0,
    primaryContainer: AppColors.primary10,
    onPrimaryContainer: AppColors.primary100,

    // SECONDARY
    secondary: AppColors.secondary100,
    onSecondary: AppColors.neutral0,
    secondaryContainer: AppColors.secondary25,
    onSecondaryContainer: AppColors.secondary100,

    // ERROR
    error: AppColors.error100,
    onError: AppColors.neutral0,
    onErrorContainer: AppColors.error100,

    // BACKGROUND & SURFACE
    surface: AppColors.neutral0,
    onSurface: AppColors.neutral100,
    surfaceContainerHighest: AppColors.neutral10,
    onSurfaceVariant: AppColors.neutral75,

    // OUTLINE
    outline: AppColors.neutral25,
    outlineVariant: AppColors.neutral10,

    // INVERSE (used for bottom sheets, etc.)
    inverseSurface: AppColors.neutral100,
    onInverseSurface: AppColors.neutral0,
    inversePrimary: AppColors.primary10,

    // OTHER OPTIONALS
    surfaceTint: AppColors.primary100,
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