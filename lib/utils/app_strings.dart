import 'package:flutter/material.dart';
import 'package:ser_manos/generated/l10n/app_localizations.dart';

/// Utility class to provide easy access to localized strings throughout the app.
/// 
/// Usage:
/// ```dart
/// Text(AppStrings.of(context).loginPageTitle)
/// ```
class AppStrings {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

/// Extension on BuildContext to make accessing localized strings even easier.
/// 
/// Usage:
/// ```dart
/// Text(context.strings.loginPageTitle)
/// ```
extension AppStringsExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
