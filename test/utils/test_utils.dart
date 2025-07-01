import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ser_manos/generated/l10n/app_localizations.dart';

/// Creates a properly localized MaterialApp for testing.
///
/// This wrapper ensures that widgets using AppLocalizations work correctly
/// in tests by providing the necessary localization delegates and supported locales.
Widget testApp({
  required Widget child,
  ThemeData? theme,
  Locale? locale,
}) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('es', ''),
      Locale('en', ''),
    ],
    locale: locale ?? const Locale('es', ''), // Default to Spanish
    theme: theme ?? ThemeData.light(useMaterial3: true),
    home: Scaffold(
      body: Center(child: child),
    ),
  );
}

/// Creates a properly localized MaterialApp for testing with custom home.
///
/// This version allows specifying a custom home widget instead of wrapping
/// the child in a Scaffold with Center.
Widget testAppWithHome({
  required Widget home,
  ThemeData? theme,
  Locale? locale,
}) {
  return MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('es', ''),
      Locale('en', ''),
    ],
    locale: locale ?? const Locale('es', ''), // Default to Spanish
    theme: theme ?? ThemeData.light(useMaterial3: true),
    home: home,
  );
}
