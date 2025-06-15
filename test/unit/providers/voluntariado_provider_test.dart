// test/unit/providers/voluntariado_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/models/user.dart' as domain;
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';

import '../../mocks/mocks.mocks.dart';

/// Posición fija para los tests (build devuelve T, no Future<T>)
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

/// Container con overrides “listos” (sin loading intermedio)
ProviderContainer makeContainer({
  required MockVoluntariadoService volService,
  required MockUserService userService,
  required auth.User firebaseUser,
  required domain.User domainUser,
}) {
  return ProviderContainer(overrides: [
    // servicios
    voluntariadoServiceProvider.overrideWithValue(volService),
    userServiceProvider       .overrideWithValue(userService),

    // usuario Firebase autenticado
    authStateProvider.overrideWithProvider(
      StreamProvider((_) => Stream.value(firebaseUser)),
    ),

    // currentUserProvider emite ya el domain.User (Stream.value → estado Data inicial)
    currentUserProvider.overrideWith((_) => Stream.value(domainUser)),

    // userLocationProvider build() devuelve T; FutureProvider lo captura como AsyncData
    userLocationProvider.overrideWith((_) => _testPosition),
  ]);
}

void main() {
  group('Voluntariado providers', () {
    late MockVoluntariadoService volService;
    late MockUserService         userService;
    late Voluntariado            vol1;
    late domain.User             domainUser;
    late auth.User               firebaseUser;

    setUp(() {
      volService  = MockVoluntariadoService();
      userService = MockUserService();

      vol1 = Voluntariado(
        id:          'v1',
        nombre:      'Comedor',
        tipo:        'Alimentos',
        vacantes:    3,
        location:    const LatLng(0, 0),
        imageUrl:    'img',
        descripcion: 'desc',
        resumen:     'res',
        requisitos:  'req',
        createdAt:   DateTime(2025),
      );

      domainUser = domain.User(
        id:                'uid1',
        nombre:            'Ada',
        apellido:          'Lovelace',
        email:             'a@b.c',
        hasSeenOnboarding: false,
      );

      firebaseUser = MockUser(uid: 'uid1', email: 'a@b.c');
    });

    test('voluntariadosProvider devuelve lista filtrada', () async {
      // stubea cualquier query/posición
      when(volService.watchFiltered(any, any))
          .thenAnswer((_) => Stream.value([vol1]));

      final container = makeContainer(
        volService:   volService,
        userService:  userService,
        firebaseUser: firebaseUser,
        domainUser:   domainUser,
      );
      addTearDown(container.dispose);

      // dispara cambio de query
      container.read(voluntariadoSearchQueryProvider.notifier).state = 'com';

      // escucha directamente el StreamProvider
      final lista = await container.read(voluntariadosProvider.stream).first;
      expect(lista, [vol1]);
    });

    test('voluntariadoParticipatingProvider emite voluntariado asignado', () async {
      final rel = domain.UserVoluntariado(
        id:     'v1',
        estado: domain.VoluntariadoUserState.accepted,
      );

      when(userService.watchParticipating('uid1'))
          .thenAnswer((_) => Stream.value(rel));
      when(volService.watchOne('v1'))
          .thenAnswer((_) => Stream.value(vol1));

      final container = makeContainer(
        volService:   volService,
        userService:  userService,
        firebaseUser: firebaseUser,
        domainUser:   domainUser,
      );
      addTearDown(container.dispose);

      // precarga para que voluntariadoProvider('v1') esté en caché
      await container.read(voluntariadoProvider('v1').future);

      final v = await container.read(voluntariadoParticipatingProvider.stream).first;
      expect(v, vol1);
    });
  });
}
