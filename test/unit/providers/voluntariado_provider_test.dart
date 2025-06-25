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

/// Posición fija usada en los tests (se devuelve directamente, no Future)
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

/// Helper para crear un ProviderContainer con todas las dependencias mockeadas
ProviderContainer makeContainer({
  required MockVoluntariadoService volService,
  required MockUserService userService,
  required auth.User firebaseUser,
  required domain.User domainUser,
}) {
  return ProviderContainer(overrides: [
    // Servicios mock
    voluntariadoServiceProvider.overrideWithValue(volService),
    userServiceProvider.overrideWithValue(userService),

    // Usuario autenticado (Firebase)
    authStateProvider.overrideWithProvider(
      StreamProvider((_) => Stream.value(firebaseUser)),
    ),

    // Usuario dominio (ya resuelto)
    currentUserProvider.overrideWith((_) => Stream.value(domainUser)),

    // Posición de usuario (sin Future)
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

      domainUser = const domain.User(
        id:                'uid1',
        nombre:            'Ada',
        apellido:          'Lovelace',
        email:             'a@b.c',
        hasSeenOnboarding: false,
      );

      firebaseUser = MockUser(uid: 'uid1', email: 'a@b.c');
    });

    test('voluntariadosProvider devuelve lista filtrada', () async {
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
      container.read(voluntariadoSearchQueryProvider.notifier).state = 'com';

      final lista = await container.read(voluntariadosProvider.stream).first;
      expect(lista, [vol1]);
    });
  });
}
