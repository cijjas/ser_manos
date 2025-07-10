import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado_actual.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import '../../utils/test_utils.dart';

Voluntariado fakeVol() => Voluntariado(
      id: 'v1',
      nombre: 'Comedor San José',
      tipo: 'Alimentos',
      vacantes: 3,
      location: const LatLng(-34.6, -58.4),
      imageUrl: 'https://example.com/stub.png',
      descripcion: 'Ayuda a servir comidas',
      resumen: 'Comedor parroquial',
      requisitos: 'Ganas de ayudar',
      createdAt: DateTime(2025),
      costo: 20.0,
    );

Widget wrap(Widget child, ThemeData theme) =>
    testApp(child: child, theme: theme);

void main() {
  testGoldens('CardVoluntariado widget', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final normal = CardVoluntariado(voluntariado: fakeVol());
      final actual =
          CardVoluntariadoActual(voluntariado: fakeVol(), onTap: () {});

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        // light
        ..addScenario(
          name: 'normal_light',
          widget: wrap(normal, ThemeData.light()),
        )
        ..addScenario(
          name: 'actual_light',
          widget: wrap(actual, ThemeData.light()),
        )
        // dark
        ..addScenario(
          name: 'normal_dark',
          widget: wrap(normal, ThemeData.dark()),
        )
        ..addScenario(
          name: 'actual_dark',
          widget: wrap(actual, ThemeData.dark()),
        );

      await tester.pumpDeviceBuilder(builder);
      await screenMatchesGolden(tester, 'card_voluntariado');
    });
  });
}
