import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:ser_manos/shared/molecules/input/search_field.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/constants/app_icons.dart';

Widget _appFrame(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? ThemeData.light(),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testGoldens('SearchField – empty vs. with-text', (tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])

    // ────────────────────────────────────────────────────────
      ..addScenario(
        name: 'empty (light)',
        widget: _appFrame(
          const SearchField(
            emptySuffix: AppIcon(
              icon: AppIcons.LISTA,
              color: AppIconsColor.PRIMARY,
            ),
          ),
          theme: ThemeData.light(),
        ),
      )

    // ────────────────────────────────────────────────────────
      ..addScenario(
        name: 'typed text (light)',
        widget: _appFrame(
          SearchField(
            controller: TextEditingController(text: 'comedor'),
            emptySuffix: const AppIcon(
              icon: AppIcons.LISTA,
              color: AppIconsColor.PRIMARY,
            ),
          ),
          theme: ThemeData.light(),
        ),
      )

    // ────────────────────────────────────────────────────────
      ..addScenario(
        name: 'empty (dark)',
        widget: _appFrame(
          const SearchField(
            emptySuffix: AppIcon(
              icon: AppIcons.LISTA,
              color: AppIconsColor.PRIMARY,
            ),
          ),
          theme: ThemeData.dark(useMaterial3: true),
        ),
      );

    await tester.pumpDeviceBuilder(builder);

    await tester.pump(const Duration(milliseconds: 200));

    await screenMatchesGolden(tester, 'search_field_states');
  });
}
