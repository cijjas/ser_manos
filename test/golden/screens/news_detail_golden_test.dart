import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:ser_manos/models/news.dart';
import 'package:ser_manos/providers/news_provider.dart';
import 'package:ser_manos/shared/wireframes/news/news_detail.dart';

import '../../mocks/mocks.mocks.dart';
import '../../utils/test_utils.dart';

// ───────────────────────── helpers ──────────────────────────
News _fakeNews() => News(
      id: 'n1',
      title: 'Nueva campaña solidaria',
      summary: 'Únete para ayudar a los niños de la zona rural.',
      sender: 'SerManos ONG',
      imageUrl: 'https://dummyimage.com/600x400/000/fff&text=novedad',
      description:
          'Este es el cuerpo completo de la noticia. Aquí iría un texto algo más extenso '
          'describiendo la iniciativa, sus objetivos, cómo colaborar, etc.',
      createdAt: DateTime(2025, 1, 1),
    );

// ───────────────────────── test ─────────────────────────────
void main() {
  testGoldens('NewsDetail – light & dark', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final mockNewsService = MockNewsService();
      when(mockNewsService.watchOne('n1'))
          .thenAnswer((_) => Stream.value(_fakeNews()));

      final overrides = <Override>[
        newsServiceProvider.overrideWithValue(mockNewsService),
      ];

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: ProviderScope(
            overrides: overrides,
            child: testAppWithHome(
              home: const NewsDetail(id: 'n1'),
              theme: ThemeData.light(),
            ),
          ),
        )
        ..addScenario(
          name: 'dark',
          widget: ProviderScope(
            overrides: overrides,
            child: testAppWithHome(
              home: const NewsDetail(id: 'n1'),
              theme: ThemeData.dark(),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 300));

      await screenMatchesGolden(
        tester,
        'news_detail_page',
        customPump: (tester) async =>
            tester.pump(const Duration(milliseconds: 200)),
      );
    });
  });
}
