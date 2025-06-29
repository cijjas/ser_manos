import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/buttons/short_button.dart';

void main() {
  testGoldens('Buttons – catalogue', (tester) async {
    await loadAppFonts();

    // ── Galería de ejemplos ───────────────────────────────────────────────
    Widget gallery() => Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AppButton', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          AppButton(label: 'Filled-enabled', onPressed: () {}),
          const SizedBox(height: 8),
          const AppButton(label: 'Filled-disabled', onPressed: null),
          const SizedBox(height: 8),
          const AppButton(label: 'Filled-loading', onPressed: null, isLoading: true),
          const SizedBox(height: 16),
          AppButton(label: 'Tonal-enabled', onPressed: () {}, type: AppButtonType.tonal),
          const SizedBox(height: 8),
          const AppButton(label: 'Tonal-disabled', onPressed: null, type: AppButtonType.tonal),
          const SizedBox(height: 8),
          const AppButton(label: 'Tonal-loading', onPressed: null, type: AppButtonType.tonal, isLoading: true),

          const Divider(height: 32),
          const Text('ShortButton', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          ShortButton(label: 'Regular', icon: Icons.check, onPressed: () {}),
          const SizedBox(height: 8),
          const ShortButton(label: 'Regular-loading', icon: Icons.check, onPressed: null, isLoading: true),
          const SizedBox(height: 8),
          ShortButton(label: 'Compact', icon: Icons.add, onPressed: () {}, variant: ShortButtonVariant.compact),
          const SizedBox(height: 8),
          const ShortButton(label: 'Compact-disabled', icon: Icons.add, onPressed: null, variant: ShortButtonVariant.compact),

          const Divider(height: 32),
          const Text('AppFloatingButton', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
        ],
      ),
    );

    final light = MaterialApp(theme: ThemeData.light(), home: Scaffold(body: SingleChildScrollView(child: gallery())));
    final dark  = MaterialApp(theme: ThemeData.dark(),  home: Scaffold(body: SingleChildScrollView(child: gallery())));

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          const Device(name: 'phone-tall', size: Size(375, 1000)), // 1 000 px de alto
        ],
      )
      ..addScenario(name: 'light', widget: light)
      ..addScenario(name: 'dark',  widget: dark);

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(
      tester,
      'buttons_catalogue',
      customPump: (tester) async {
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));
      },
    );
  });
}

void _noop() {}
