// test/golden/screens/home_screen_golden_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ser_manos/models/volunteering.dart';
import 'package:ser_manos/models/user.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/volunteering_provider.dart';
import 'package:ser_manos/shared/wireframes/volunteerings/volunteering_page.dart';

import '../../mocks/mocks.mocks.dart';
import '../../utils/test_utils.dart';

Volunteering fakeVol(String id) => Volunteering(
      id: id,
      name: 'Comedor $id',
      type: 'Alimentos',
      vacancies: 5,
      location: const LatLng(0, 0),
      imageUrl: 'https://dummyimage.com/600x400/000/fff&text=$id',
      description: 'Descripción $id',
      summary: 'Resumen $id',
      requirements: 'Requisitos',
      createdAt: DateTime(2025),
      cost: 90.0,
    );

const fakeUser = User(
  id: 'u1',
  nombre: 'Ada',
  apellido: 'Lovelace',
  email: 'ada@lovelace.dev',
  hasSeenOnboarding: true,
);

void main() {
  testGoldens('VolunteeringsPage – list view', (tester) async {
    await loadAppFonts();

    await mockNetworkImagesFor(() async {
      final mockUserService = MockUserService();
      when(mockUserService.toggleLikeVolunteering(any, any))
          .thenAnswer((_) async {});

      final overrides = <Override>[
        volunteeringsProvider.overrideWith(
          (ref) => Stream.value([fakeVol('v1'), fakeVol('v2')]),
        ),
        volunteeringParticipatingProvider
            .overrideWith((ref) => const Stream.empty()),
        currentUserProvider.overrideWith((ref) => Stream.value(fakeUser)),
        authStateProvider.overrideWith((ref) => Stream.value(null)),
        userServiceProvider.overrideWithValue(mockUserService),
      ];

      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [Device.phone])
        ..addScenario(
          name: 'light',
          widget: ProviderScope(
            overrides: overrides,
            child: testAppWithHome(
              home: const VolunteeringsPage(),
              theme: ThemeData.light(),
            ),
          ),
        )
        ..addScenario(
          name: 'dark',
          widget: ProviderScope(
            overrides: overrides,
            child: testAppWithHome(
              home: const VolunteeringsPage(),
              theme: ThemeData.dark(),
            ),
          ),
        );

      await tester.pumpDeviceBuilder(builder);
      await tester.pump(const Duration(milliseconds: 300));

      await screenMatchesGolden(
        tester,
        'volunteerings_page',
        customPump: (tester) async {
          await tester.pump(const Duration(milliseconds: 200));
        },
      );
    });
  });
}
