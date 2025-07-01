import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:ser_manos/shared/molecules/status_bar/status_bar.dart';
import '../../utils/test_utils.dart';

Widget _frame(StatusBar bar, {ThemeData? theme}) => testAppWithHome(
      home: Scaffold(appBar: bar, body: const SizedBox.expand()),
      theme: theme,
    );

void main() {
  testGoldens('StatusBar variants', (tester) async {
    await loadAppFonts();

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])
      ..addScenario(
        name: 'light-noShadow',
        widget: _frame(
          const StatusBar(style: StatusBarStyle.light),
        ),
      )
      ..addScenario(
        name: 'dark-noShadow',
        widget: _frame(
          const StatusBar(style: StatusBarStyle.dark),
          theme: ThemeData.dark(useMaterial3: true),
        ),
      )
      ..addScenario(
        name: 'blue-shadow',
        widget: _frame(
          const StatusBar(
            style: StatusBarStyle.blue,
            hasShadow: true,
          ),
        ),
      );

    await tester.pumpDeviceBuilder(builder);
    await tester.pump(const Duration(milliseconds: 150)); // settle fonts

    await screenMatchesGolden(tester, 'status_bar_variants');
  });
}
