import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:ser_manos/models/volunteering.dart';
import 'package:ser_manos/shared/cells/cards/volunteering_card.dart';
import 'package:ser_manos/shared/cells/cards/current_volunteering_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import '../../utils/test_utils.dart';

Volunteering fakeVol() => Volunteering(
      id: 'v1',
      name: 'Comedor San José',
      type: 'Alimentos',
      vacancies: 3,
      location: const LatLng(-34.6, -58.4),
      imageUrl: 'https://example.com/stub.png',
      description: 'Ayuda a servir comidas',
      summary: 'Comedor parroquial',
      requirements: 'Ganas de ayudar',
      createdAt: DateTime(2025),
      cost: 20.0,
    );

Widget wrap(Widget child, ThemeData theme) =>
    testApp(child: child, theme: theme);

void main() {
  testGoldens('CardVolunteering widget', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final normal = VolunteeringCard(volunteering: fakeVol());
      final actual =
          CardVolunteeringActual(volunteering: fakeVol(), onTap: () {});

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
      await screenMatchesGolden(tester, 'card_volunteering');
    });
  });
}
