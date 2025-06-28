import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:ser_manos/shared/molecules/components/vacants.dart';

Widget _frame(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? ThemeData.light(useMaterial3: true),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testGoldens('VacantsDisplay – with/without vacancies', (tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])

      ..addScenario(
        name: 'has-vacancies',
        widget: _frame(const VacantsDisplay(number: 3)),
      )

      ..addScenario(
        name: 'no-vacancies',
        widget: _frame(const VacantsDisplay(number: 0)),
      );

    await tester.pumpDeviceBuilder(builder);
    await tester.pump(const Duration(milliseconds: 200)); // settle fonts

    await screenMatchesGolden(tester, 'vacants_display_states');
  });
}
