// test/golden/screens/novedad_detail_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:ser_manos/models/novedad.dart';
import 'package:ser_manos/providers/novedad_provider.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedad_detail.dart';

import '../../mocks/mocks.mocks.dart'; // MockNovedadService

// ───────────────────────── helpers ──────────────────────────
Novedad _fakeNovedad() => Novedad(
  id: 'n1',
  titulo: 'Nueva campaña solidaria',
  resumen: 'Únete para ayudar a los niños de la zona rural.',
  emisor: 'SerManos ONG',
  imagenUrl: 'https://dummyimage.com/600x400/000/fff&text=novedad',
  descripcion:
  'Este es el cuerpo completo de la noticia. Aquí iría un texto algo más extenso '
      'describiendo la iniciativa, sus objetivos, cómo colaborar, etc.',
  createdAt: DateTime(2025, 1, 1),
);

// ───────────────────────── test ─────────────────────────────
void main() {
  testGoldens('NovedadDetail – light & dark', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final mockNovedadService = MockNovedadService();
      when(mockNovedadService.watchOne('n1'))
          .thenAnswer((_) => Stream.value(_fakeNovedad()));

      final overrides = <Override>[
        novedadServiceProvider.overrideWithValue(mockNovedadService),
      ];

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: ProviderScope(
            overrides: overrides,
            child: MaterialApp(
              theme: ThemeData.light(),
              home: const NovedadDetail(id: 'n1'),
            ),
          ),
        )
        ..addScenario(
          name: 'dark',
          widget: ProviderScope(
            overrides: overrides,
            child: MaterialApp(
              theme: ThemeData.dark(),
              home: const NovedadDetail(id: 'n1'),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 300));

      await screenMatchesGolden(
        tester,
        'novedad_detail_page',
        customPump: (tester) async => tester.pump(const Duration(milliseconds: 200)),
      );
    });
  });
}
