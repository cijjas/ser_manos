import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ser_manos/providers/auth_provider.dart';

void main() {
  group('isLoggedInProvider', () {
    test('retorna FALSE cuando el usuario está deslogueado (User == null)', () async {
      final container = ProviderContainer(
        overrides: [
          // Stream que emite inmediatamente null
          authStateProvider.overrideWithProvider(
            StreamProvider<User?>((ref) => Stream.value(null)),
          ),
        ],
      );
      addTearDown(container.dispose);

      // Esperamos a que el Stream entregue su primer valor
      await container.read(authStateProvider.future);

      expect(container.read(isLoggedInProvider), isFalse);
    });

    test('retorna TRUE cuando el stream emite un User', () async {
      final mockUser = MockUser(uid: 'abc123', email: 'ada@lovelace.dev');

      final container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWithProvider(
            StreamProvider<User?>((ref) => Stream.value(mockUser)),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.future);

      expect(container.read(isLoggedInProvider), isTrue);
    });

    test('cambia de FALSE → TRUE cuando el stream pasa de null a User', () async {
      final controller = StreamController<User?>();
      final mockUser   = MockUser(uid: 'xyz', email: 'test@test.com');

      final container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWithProvider(
            StreamProvider<User?>((ref) => controller.stream),
          ),
        ],
      );
      addTearDown(() async {
        await controller.close();
        container.dispose();
      });

      // Listener que guarda los cambios de bool
      final history = <bool>[];
      container.listen<bool>(
        isLoggedInProvider,
            (prev, next) => history.add(next),
        fireImmediately: true,
      );

      // Estado inicial: null → false
      expect(history, [false]);

      // Emitimos el usuario
      controller.add(mockUser);

      // Dejamos que el event-loop procese la emisión
      await Future.delayed(Duration.zero);

      expect(container.read(isLoggedInProvider), isTrue);
      expect(history, [false, true]);
    });
  });
}
