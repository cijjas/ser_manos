import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:geocoding/geocoding.dart';

import 'package:ser_manos/models/user.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';
import 'package:ser_manos/shared/wireframes/voluntariados/voluntariado_detail.dart';

import '../../mocks/mocks.mocks.dart';
import '../../utils/test_utils.dart';

class _FakeGeo extends GeocodingPlatform {
  _FakeGeo();
  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) async =>
      [
        const Placemark(
          name: 'Street',
          subLocality: 'Locality',
          locality: 'City',
          administrativeArea: 'State',
          postalCode: '0000',
          country: 'Country',
        )
      ];
}

Voluntariado _fakeVol(String id) => Voluntariado(
      id: id,
      nombre: 'Comedor Solidario',
      tipo: 'Alimentos',
      vacantes: 5,
      location: const LatLng(-34.6, -58.38),
      imageUrl: 'https://dummyimage.com/640x360/000/fff&text=$id',
      descripcion: 'Descripción extensa.',
      resumen: 'Ayudamos a quienes más lo necesitan.',
      requisitos: '* Compromiso\n* Tiempo libre',
      createdAt: DateTime(2025),
    );

const _fakeUser = User(
  id: 'u1',
  nombre: 'Ada',
  apellido: 'Lovelace',
  email: 'ada@lovelace.dev',
  hasSeenOnboarding: true,
);

void main() {
  GeocodingPlatform.instance = _FakeGeo();

  testGoldens('VoluntariadoDetalle – available', (tester) async {
    await loadAppFonts();
    await mockNetworkImagesFor(() async {
      final mockVolService = MockVoluntariadoService();
      when(mockVolService.watchOne('v1'))
          .thenAnswer((_) => Stream.value(_fakeVol('v1')));

      final mockUserService = MockUserService();
      when(mockUserService.watchOne('u1'))
          .thenAnswer((_) => Stream.value(_fakeUser));

      final overrides = <Override>[
        voluntariadoServiceProvider.overrideWithValue(mockVolService),
        userServiceProvider.overrideWithValue(mockUserService),
        authStateProvider.overrideWith((_) => Stream.value(null)),
        currentUserProvider.overrideWith((_) => Stream.value(_fakeUser)),
      ];

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: ProviderScope(
            overrides: overrides,
            child: testAppWithHome(
              home: const VoluntariadoDetallePage(voluntariadoId: 'v1'),
              theme: ThemeData.light(useMaterial3: true),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 300));

      await screenMatchesGolden(
        tester,
        'voluntariado_detail_available',
        customPump: (tester) async =>
            tester.pump(const Duration(milliseconds: 200)),
      );
    });
  });
}
