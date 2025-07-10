import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'package:ser_manos/models/user.dart';
import 'package:ser_manos/services/user_service.dart';

import '../../mocks/firebase_mocks.mocks.dart';

void main() {
  late FakeFirebaseFirestore  fakeDb;
  late MockFirebaseAnalytics  mockAnalytics;
  late MockFirebaseCrashlytics mockCrash;
  late UserService            sut;

  // ───────────────── usuario base ─────────────────
  const baseUser = User(
    id: 'u1',
    nombre: 'Ada',
    apellido: 'Lovelace',
    email: 'ada@lovelace.dev',
    hasSeenOnboarding: false,
  );

  setUp(() {
    fakeDb        = FakeFirebaseFirestore();
    mockAnalytics = MockFirebaseAnalytics();
    mockCrash     = MockFirebaseCrashlytics();

    sut = UserService(
      firestore:   fakeDb,
      analytics:   mockAnalytics,
      crashlytics: mockCrash,
    );
  });

  // ─────────────────────── createUser ────────────────────────
  group('createUser', () {
    test('graba documento y emite evento de éxito', () async {
      await sut.createUser(baseUser);

      final snap = await fakeDb.collection('users').doc('u1').get();
      expect(snap.exists, isTrue);

      verify(mockAnalytics.logEvent(
        name: 'user_creation_success',
        parameters: {'source': 'UserService'},
      )).called(1);
    });

    test('registra fallo en Crashlytics + evento de error', () async {
      final mockFs    = MockFirebaseFirestore();
      final mockColl  = MockCollectionReference<Map<String, dynamic>>();
      final mockDoc   = MockDocumentReference<Map<String, dynamic>>();

      when(mockFs.collection('users')).thenReturn(mockColl);
      when(mockColl.doc('u1')).thenReturn(mockDoc);
      when(mockDoc.set(any)).thenThrow(Exception('boom'));

      final failingService = UserService(
        firestore:   mockFs,
        analytics:   mockAnalytics,
        crashlytics: mockCrash,
      );

      await expectLater(() => failingService.createUser(baseUser),
          throwsA(isA<Exception>()));

      verify(mockCrash.recordError(
        any,
        any,
        reason: contains('Failed to create user'),
        fatal: false,
      )).called(1);

      verify(mockAnalytics.logEvent(
        name: 'user_creation_failed',
        parameters: anyNamed('parameters'),
      )).called(1);
    });
  });

  // ─────────────── postulate / withdraw / abandon ───────────────
  group('postulate – withdraw – abandon', () {
    setUp(() async {
      await fakeDb.collection('users').doc('u1').set(baseUser.toJson());
    });

    test('postulate agrega volunteering en estado applied', () async {
      final ok = await sut.postulateToVolunteering(baseUser, 'v1');
      expect(ok, isTrue);

      final doc  = await fakeDb.doc('users/u1').get();
      final user = User.fromJson(doc.data()!);

      expect(user.volunteerings!.first.id, 'v1');
      expect(user.volunteerings!.first.estado,
          VolunteeringUserState.pending);
    });

    test('withdraw pasa a available ⇒ lista vacía', () async {
      await sut.postulateToVolunteering(baseUser, 'v1');
      final appliedSnap = await fakeDb.doc('users/u1').get();
      final appliedUser = User.fromJson(appliedSnap.data()!);

      final ok = await sut.withdrawPostulation(appliedUser, 'v1');
      expect(ok, isTrue);

      final snap = await fakeDb.doc('users/u1').get();
      final user = User.fromJson(snap.data()!);
      expect(user.volunteerings, isEmpty);
    });

    test('abandon falla si estado != accepted y graba Crashlytics', () async {
      await sut.postulateToVolunteering(baseUser, 'v1');
      final snap  = await fakeDb.doc('users/u1').get();
      final user  = User.fromJson(snap.data()!);

      final ok = await sut.abandonVolunteering(user, 'v1');
      expect(ok, isFalse);

      verify(mockCrash.recordError(
        any,
        null,
        reason: contains('state invalid'),
        fatal: false,
      )).called(1);
    });
  });

  // ───────────────────── toggleLike ─────────────────────
  test('toggleLikeVolunteering alterna like/unlike', () async {
    await fakeDb.doc('users/u1').set(baseUser.toJson());

    // Like
    await sut.toggleLikeVolunteering(baseUser, 'v42');
    var snap = await fakeDb.doc('users/u1').get();
    expect((snap.data()!['likedVoluntariados'] as List).contains('v42'), isTrue);

    // Unlike
    await sut.toggleLikeVolunteering(
      baseUser.copyWith(likedVolunteerings: ['v42']),
      'v42',
    );
    snap = await fakeDb.doc('users/u1').get();
    expect((snap.data()!['likedVoluntariados'] as List).contains('v42'), isFalse);
  });
}
