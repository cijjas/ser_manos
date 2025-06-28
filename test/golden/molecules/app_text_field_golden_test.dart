import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'package:ser_manos/shared/molecules/input/app_text_field.dart';

void main() {
  testGoldens('AppTextField – common states', (tester) async {
    await loadAppFonts();

    // ——————————————————— Catálogo de ejemplos ————————————————————
    Widget gallery() => Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vacío'),
            const SizedBox(height: 8),
            const AppTextField(labelText: 'Nombre', hintText: 'Tu nombre'),

            const SizedBox(height: 24),
            const Text('Con texto'),
            const SizedBox(height: 8),
            AppTextField(
              labelText: 'Email',
              hintText: 'tu@email.com',
              controller: TextEditingController(text: 'ada@lovelace.dev'),
            ),

            const SizedBox(height: 24),
            const Text('Deshabilitado'),
            const SizedBox(height: 8),
            const AppTextField(
              labelText: 'Teléfono',
              hintText: '+54...',
              enabled: false,
            ),

            const SizedBox(height: 24),
            const Text('Password'),
            const SizedBox(height: 8),
            const PasswordField(labelText: 'Contraseña', hintText: '******'),
          ],
        ),
      ),
    );

    final light = MaterialApp(
      theme: ThemeData.light(),
      home: Scaffold(body: SingleChildScrollView(child: gallery())),
    );

    final dark = MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(body: SingleChildScrollView(child: gallery())),
    );

    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [const Device(name: 'phone-tall', size: Size(375, 1000))],
      )
      ..addScenario(name: 'light', widget: light)
      ..addScenario(name: 'dark', widget: dark);

    await tester.pumpDeviceBuilder(builder);

    await tester.pump(const Duration(milliseconds: 200));

    await screenMatchesGolden(
      tester,
      'app_text_field_catalogue',
      customPump: (tester) async => tester.pump(const Duration(milliseconds: 100)),
    );
  });
}
