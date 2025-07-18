import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

import 'package:ser_manos/models/volunteering.dart';
import 'package:ser_manos/models/user.dart' as domain;
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/volunteering_provider.dart';

import '../../mocks/mocks.mocks.dart';

final _testPosition = Position(
  latitude: 0,
  longitude: 0,
  timestamp: DateTime(2025),
  accuracy: 0,
  altitude: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
  altitudeAccuracy: 0,
  floor: null,
  isMocked: true,
);

ProviderContainer makeContainer({
  required MockVolunteeringService volService,
  required MockUserService userService,
  required auth.User firebaseUser,
  required domain.User domainUser,
}) {
  return ProviderContainer(overrides: [
    // Servicios mock
    volunteeringServiceProvider.overrideWithValue(volService),
    userServiceProvider.overrideWithValue(userService),

    // Usuario autenticado (Firebase)
    // authStateProvider.overrideWithProvider(
    //   StreamProvider((_) => Stream.value(firebaseUser)),
    // ),

    authStateProvider.overrideWith((ref) => Stream.value(firebaseUser)), // firebaseUser is of type auth.User

    // Usuario dominio (ya resuelto)
    currentUserProvider.overrideWith((_) => Stream.value(domainUser)),

    // Posición de usuario (sin Future)
    userLocationProvider.overrideWith((_) => _testPosition),
  ]);
}

void main() {
  group('Volunteering providers', () {
    late MockVolunteeringService volService;
    late MockUserService         userService;
    late Volunteering            vol1;
    late domain.User             domainUser;
    late auth.User               firebaseUser;

    setUp(() {
      volService  = MockVolunteeringService();
      userService = MockUserService();

      vol1 = Volunteering(
        id:          'v1',
        name:        'Comedor',
        type:        'Alimentos',
        vacancies:   3,
        location:    const LatLng(0, 0),
        imageUrl:    'img',
        description: 'desc',
        summary:     'res',
        requirements:'req',
        createdAt:   DateTime(2025),
        cost:        10.0,
      );

      domainUser = const domain.User(
        id:                'uid1',
        name:            'Ada',
        surname:          'Lovelace',
        email:             'a@b.c',
        hasSeenOnboarding: false,
      );

      firebaseUser = MockUser(uid: 'uid1', email: 'a@b.c');
    });

    test('volunteeringsProvider devuelve lista filtrada', () async {
      // Stub para cualquier query y ubicación
      when(volService.watchFiltered(any, any))
          .thenAnswer((_) => Stream.value([vol1]));

      final container = makeContainer(
        volService:   volService,
        userService:  userService,
        firebaseUser: firebaseUser,
        domainUser:   domainUser,
      );
      addTearDown(container.dispose);

      // Cambiamos la query
      container.read(volunteeringSearchQueryProvider.notifier).state = 'com';

      final lista = await container.read(volunteeringsProvider.future);
      expect(lista, [vol1]);
    });
  });
}
