import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:geocoding/geocoding.dart';

import 'package:ser_manos/models/user.dart';
import 'package:ser_manos/models/volunteering.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/volunteering_provider.dart';
import 'package:ser_manos/shared/wireframes/volunteerings/volunteering_detail.dart';

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

Volunteering _fakeVol(String id) => Volunteering(
      id: id,
      name: 'Comedor Solidario',
      type: 'Alimentos',
      vacancies: 5,
      location: const LatLng(-34.6, -58.38),
      imageUrl: 'https://dummyimage.com/640x360/000/fff&text=$id',
      description: 'Descripción extensa.',
      summary: 'Ayudamos a quienes más lo necesitan.',
      requirements: '* Compromiso\n* Tiempo libre',
      createdAt: DateTime(2025),
      cost: 1000.0,
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

  testGoldens('VolunteeringDetalle – available', (tester) async {
    await loadAppFonts();
    await mockNetworkImagesFor(() async {
      final mockVolService = MockVolunteeringService();
      when(mockVolService.watchOne('v1'))
          .thenAnswer((_) => Stream.value(_fakeVol('v1')));

      final mockUserService = MockUserService();
      when(mockUserService.watchOne('u1'))
          .thenAnswer((_) => Stream.value(_fakeUser));

      final overrides = <Override>[
        volunteeringServiceProvider.overrideWithValue(mockVolService),
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
              home: const VolunteeringDetallePage(volunteeringId: 'v1'),
              theme: ThemeData.light(useMaterial3: true),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 300));

      await screenMatchesGolden(
        tester,
        'volunteering_detail_available',
        customPump: (tester) async =>
            tester.pump(const Duration(milliseconds: 200)),
      );
    });
  });
}
