import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:ser_manos/providers/auth_provider.dart';
import 'package:ser_manos/providers/user_provider.dart';
import 'package:ser_manos/models/user.dart' as domain;          // 👈 alias
import 'package:mockito/mockito.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  group('User providers', () {
    late MockUserService mockUserService;
    late auth.User firebaseUser;
    late domain.User domainUser;

    setUp(() {
      mockUserService = MockUserService();
      firebaseUser    = MockUser(uid: 'uid1', email: 'a@b.c');
      domainUser      = const domain.User(
        id: 'uid1',
        nombre: 'Ada',
        apellido: 'Lovelace',
        email: 'a@b.c',
        hasSeenOnboarding: false,
      );
    });

    ProviderContainer makeContainer(Stream<auth.User?> authStream) {
      return ProviderContainer(overrides: [
        userServiceProvider.overrideWithValue(mockUserService),
        authStateProvider.overrideWith(
          (_) => authStream,
        ),
      ]);
    }

    test('currentUserProvider emite user del servicio', () async {
      when(mockUserService.watchOne('uid1'))
          .thenAnswer((_) => Stream.value(domainUser));

      final container = makeContainer(Stream.value(firebaseUser));
      addTearDown(container.dispose);
      await container.read(authStateProvider.future);

      final user = await container.read(currentUserProvider.future);
      expect(user, equals(domainUser));
    });

    test('markOnboardingCompleteProvider actualiza y devuelve nuevo user', () async {
      final updated = domainUser.copyWith(hasSeenOnboarding: true);

      when(mockUserService.watchOne('uid1'))
          .thenAnswer((_) => Stream.value(domainUser));
      when(mockUserService.updateUser(any)).thenAnswer((_) async => updated);

      final container = makeContainer(Stream.value(firebaseUser));
      addTearDown(container.dispose);

      await container.read(authStateProvider.future);
      await container.read(currentUserProvider.future);

      final result = await container.read(markOnboardingCompleteProvider.future);
      expect(result?.hasSeenOnboarding, isTrue);
      verify(mockUserService.updateUser(updated)).called(1);
    });
  });
}
