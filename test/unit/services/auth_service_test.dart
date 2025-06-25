import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mockito/mockito.dart';
import 'package:ser_manos/services/auth_service.dart';

import '../../mocks/firebase_mocks.mocks.dart';

void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseAnalytics mockAnalytics;
  late MockFirebaseCrashlytics mockCrash;
  late AuthService sut;

  const email = 'ada@lovelace.dev';
  const pass  = '123456';

  setUp(() {
    mockAuth      = MockFirebaseAuth();
    mockAnalytics = MockFirebaseAnalytics();
    mockCrash     = MockFirebaseCrashlytics();

    sut = AuthService(
      auth:        mockAuth,
      analytics:   mockAnalytics,
      crashlytics: mockCrash,
    );
  });

  group('register()', () {
    test('éxito: retorna credencial y registra sign_up', () async {
      final cred = MockUserCredential();
      when(mockAuth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      )).thenAnswer((_) async => cred);

      final result = await sut.register(email, pass);

      expect(result, cred);
      verify(mockAnalytics.logEvent(
        name: 'sign_up',
        parameters: {'method': 'email'},
      )).called(1);
    });
  });

  group('signIn()', () {
    test('error NO crítico relanza, sin crashlytics', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      )).thenThrow(
        auth.FirebaseAuthException(code: 'wrong-password', message: 'bad'),
      );

      await expectLater(
            () => sut.signIn(email, pass),
        throwsA(isA<auth.FirebaseAuthException>()),
      );

      verifyNever(mockCrash.recordError(any, any));
      verify(mockAnalytics.logEvent(
        name: 'auth_error',
        parameters: {
          'stage': 'sign_in',
          'method': 'email',
          'error_code': 'wrong-password',
        },
      )).called(1);
    });

    test('error crítico ⇒ Crashlytics + auth_error', () async {
      when(mockAuth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      )).thenThrow(
        auth.FirebaseAuthException(code: 'internal-error', message: 'boom'),
      );

      await expectLater(
            () => sut.signIn(email, pass),
        throwsA(isA<auth.FirebaseAuthException>()),
      );

      verify(mockCrash.recordError(
        any,
        any,
        reason: contains('Unexpected FirebaseAuthException'),
        fatal: false,
      )).called(1);

      verify(mockAnalytics.logEvent(
        name: 'auth_error',
        parameters: {
          'stage': 'sign_in',
          'method': 'email',
          'error_code': 'internal-error',
        },
      )).called(1);
    });
  });

  test('signOut delega en FirebaseAuth.signOut', () async {
    when(mockAuth.signOut()).thenAnswer((_) async => {});

    await sut.signOut();

    verify(mockAuth.signOut()).called(1);
  });
}
