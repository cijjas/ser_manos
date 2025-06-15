import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/models/user.dart' as domain;
import 'package:mockito/mockito.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('Voluntariado providers', () {
    late MockVoluntariadoService volService;
    late MockUserService userService;

    late Voluntariado vol1;
    late domain.User domainUser;
    late auth.User firebaseUser;

    setUp(() {
      volService = MockVoluntariadoService();
      userService = MockUserService();

      vol1 = Voluntariado(
        id: 'v1',
        nombre: 'Comedor',
        tipo: 'Alimentos',
        vacantes: 3,
        location: const LatLng(0, 0),
        imageUrl: 'img',
        descripcion: 'desc',
        resumen: 'res',
        requisitos: 'req',
        createdAt: DateTime(2025),
      );

      domainUser = domain.User(
        id: 'uid1',
        nombre: 'Ada',
        apellido: 'Lovelace',
        email: 'a@b.c',
        hasSeenOnboarding: false,
      );

      firebaseUser = MockUser(uid: 'uid1', email: 'a@b.c');
    });

    ProviderContainer makeContainer() {
      return ProviderContainer(overrides: [
        voluntariadoServiceProvider.overrideWithValue(volService),
        userServiceProvider.overrideWithValue(userService),
        authStateProvider.overrideWithProvider(
          StreamProvider((_) => Stream.value(firebaseUser)),
        ),
      ]);
    }

    test('voluntariadosProvider devuelve lista filtrada', () async {
      when(volService.watchFiltered('com'))
          .thenAnswer((_) => Stream.value([vol1]));

      final container = makeContainer();
      addTearDown(container.dispose);

      container.read(voluntariadoSearchQueryProvider.notifier).state = 'com';
      final list = await container.read(voluntariadosProvider.future);

      expect(list, [vol1]);
    });

    test('voluntariadoParticipatingProvider emite voluntariado asignado', () async {
      // relación usuario-voluntariado que emitirá UserService.watchParticipating
      final rel = domain.UserVoluntariado(
        id: 'v1',
        estado: domain.VoluntariadoUserState.accepted,
      );

      // STUBS ────────────────
      when(userService.watchOne('uid1'))
          .thenAnswer((_) => Stream.value(domainUser));

      when(userService.watchParticipating('uid1'))
          .thenAnswer((_) => Stream.value(rel));

      when(volService.watchOne('v1'))
          .thenAnswer((_) => Stream.value(vol1));

      final container = makeContainer();
      addTearDown(container.dispose);

      await container.read(authStateProvider.future);
      await container.read(currentUserProvider.future);
      await container.read(voluntariadoProvider('v1').future);

      final v =
      await container.read(voluntariadoParticipatingProvider.future);

      expect(v, vol1);
    });


  });
}
