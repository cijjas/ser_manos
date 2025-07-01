import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:ser_manos/models/novedad.dart';
import 'package:ser_manos/shared/cells/cards/card_novedades.dart';
import '../../utils/test_utils.dart';

Widget _frame(Widget w, {ThemeData? theme}) => testApp(
      child: w,
      theme: theme,
    );

Novedad fakeNews(String id) => Novedad(
      id: id,
      titulo: 'New spaces for volunteering',
      resumen:
          'Discover the latest opportunities we’ve opened for community work.',
      emisor: 'SerManos',
      imagenUrl: 'https://dummyimage.com/300x400/ccc/aaa&text=news',
      descripcion: 'Long **markdown** body …',
      createdAt: DateTime(2025, 6, 1),
    );

void main() {
  testGoldens('CardNovedades widget', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: _frame(CardNovedades(novedad: fakeNews('n1'))),
        )
        ..addScenario(
          name: 'dark',
          widget: _frame(
            CardNovedades(novedad: fakeNews('n1')),
            theme: ThemeData.dark(useMaterial3: true),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 200)); // fonts-settle

      await screenMatchesGolden(tester, 'card_novedades');
    });
  });
}
