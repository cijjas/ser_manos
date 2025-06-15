import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ser_manos/services/voluntariado_service.dart';
import 'package:ser_manos/models/voluntariado.dart';

import '../../mocks/firebase_mocks.mocks.dart';

void main() {
  late FakeFirebaseFirestore   fakeDb;
  late MockFirebaseCrashlytics mockCrash;
  late VoluntariadoService     sut;

  setUp(() {
    fakeDb   = FakeFirebaseFirestore();
    mockCrash = MockFirebaseCrashlytics();

    sut = VoluntariadoService(
      firestore:   fakeDb,
      crashlytics: mockCrash,
    );
  });

  Timestamp ts(int year) => Timestamp.fromDate(DateTime(year));

  Future<void> _addVol({
    required String id,
    required String nombre,
    int slots = 3,
  }) {
    return fakeDb.collection('voluntariados').doc(id).set({
      'nombre'        : nombre,
      'tipo'          : 'Ayuda',
      'vacantes'      : slots,
      'availableSlots': slots,
      'location'      : const GeoPoint(0, 0),
      'imageUrl'      : 'img',
      'descripcion'   : 'desc $nombre',
      'resumen'       : 'res',
      'requisitos'    : 'req',
      'createdAt'     : ts(2025),
    });
  }

  // ─────────── Lectores ───────────
  test('watchOne emite voluntariado con id correcto', () async {
    await _addVol(id: 'v1', nombre: 'Comedor');

    final v = await sut.watchOne('v1').first;
    expect(v.id,     'v1');
    expect(v.nombre, 'Comedor');
  });

  test('watchFiltered acota resultados por texto', () async {
    await _addVol(id: 'v1', nombre: 'Comedor');
    await _addVol(id: 'v2', nombre: 'Ropa');

    final list = await sut.watchFiltered('come').first;
    expect(list.length, 1);
    expect(list.first.id, 'v1');
  });

  // ─────────── Vacantes ───────────
  group('decrement / increment slots', () {
    setUp(() async {
      await _addVol(id: 'v1', nombre: 'Comedor', slots: 1);
    });

    test('decrementAvailableSlots éxito ⇒ resta 1', () async {
      final ok = await sut.decrementAvailableSlots('v1');
      expect(ok, isTrue);

      final snap = await fakeDb.doc('voluntariados/v1').get();
      expect(snap.data()!['availableSlots'], 0);
    });

    test('decrement falla sin cupo lanza excepción', () async {
      // 1º llamada: cupo pasa de 1 → 0
      await sut.decrementAvailableSlots('v1');

      // 2º llamada: FakeFirestore re-lanza la Exception del closure
      await expectLater(
            () => sut.decrementAvailableSlots('v1'),
        throwsA(isA<Exception>()),
      );
    });

    test('incrementAvailableSlots suma 1', () async {
      await sut.decrementAvailableSlots('v1'); // queda en 0

      final ok = await sut.incrementAvailableSlots('v1');
      expect(ok, isTrue);

      final snap = await fakeDb.doc('voluntariados/v1').get();
      expect(snap.data()!['availableSlots'], 1);
    });
  });
}
