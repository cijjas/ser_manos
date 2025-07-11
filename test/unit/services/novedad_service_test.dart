import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:ser_manos/services/news_service.dart';
import 'package:ser_manos/models/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';

void main() {
  late FakeFirebaseFirestore fakeDb;
  late NewsService        sut;

  setUp(() {
    fakeDb = FakeFirebaseFirestore();
    sut    = NewsService(firestore: fakeDb);
  });

  Timestamp ts(int year) => Timestamp.fromDate(DateTime(year));

  test('getAll devuelve orden DESC por createdAt', () async {
    await fakeDb.collection('novedades').doc('n1').set({
      'id'        : 'n1',
      'titulo'    : 'antigua',
      'resumen'   : 'r',
      'emisor'    : 'e',
      'imagenUrl' : 'img',
      'descripcion': 'd',
      'createdAt' : ts(2023),
    });

    await fakeDb.collection('novedades').doc('n2').set({
      'id'        : 'n2',
      'titulo'    : 'nueva',
      'resumen'   : 'r',
      'emisor'    : 'e',
      'imagenUrl' : 'img',
      'descripcion': 'd',
      'createdAt' : ts(2025),
    });

    final list = await sut.getAll();
    expect(list.map((n) => n.id), ['n2', 'n1']);
  });

  test('watchAll emite lista al agregarse un documento', () async {
    final stream = sut.watchAll();

    await fakeDb.collection('novedades').doc('n3').set({
      'id'        : 'n3',
      'titulo'    : 'n3',
      'resumen'   : 'r',
      'emisor'    : 'e',
      'imagenUrl' : 'img',
      'descripcion': 'd',
      'createdAt' : Timestamp.now(),
    });

    expectLater(stream, emits(isA<List<News>>()));
  });

  test('watchOne emite actualización del documento', () async {
    await fakeDb.collection('novedades').doc('n4').set({
      'id'        : 'n4',
      'titulo'    : 'init',
      'resumen'   : 'r',
      'emisor'    : 'e',
      'imagenUrl' : 'img',
      'descripcion': 'd',
      'createdAt' : Timestamp.now(),
    });

    final q = StreamQueue<News>(sut.watchOne('n4'));

    final first = await q.next.timeout(const Duration(seconds: 1));
    expect(first.title, 'init');

    // actualizamos
    await fakeDb.doc('novedades/n4').update({'titulo': 'upd'});

    final updated = await q.next.timeout(const Duration(seconds: 1));
    expect(updated.title, 'upd');

    await q.cancel();
  });
}
