import 'package:flutter_test/flutter_test.dart';
import 'package:ser_manos/models/novedad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('Novedad model', () {
    final ts = Timestamp.fromDate(DateTime(2025, 1, 10, 14)); // 10-ene-2025 14 hs

    final json = {
      'id'        : 'n1',
      'titulo'    : 'Nueva colecta de abrigo',
      'resumen'   : 'Se necesitan frazadas para el invierno',
      'emisor'    : 'Fundación Manos',
      'imagenUrl' : 'https://example.com/abrigos.png',
      'descripcion':
      'Estamos lanzando una colecta de frazadas y ropa de abrigo…',
      'createdAt' : ts,
    };

    test('fromJson convierte Timestamp a DateTime', () {
      final n = Novedad.fromJson(json);

      expect(n.id, 'n1');
      expect(n.createdAt, ts.toDate());
      expect(n.titulo, contains('colecta'));
    });

    test('toJson vuelve a Timestamp y mantiene valores', () {
      final encoded = Novedad.fromJson(json).toJson();

      expect(encoded['createdAt'], isA<Timestamp>());
      expect(encoded['titulo'], 'Nueva colecta de abrigo');
    });

    test('round-trip y copyWith', () {
      final original = Novedad.fromJson(json);
      final round    = Novedad.fromJson(original.toJson());

      expect(round, equals(original));

      final mod = original.copyWith(titulo: 'Título actualizado');
      expect(mod.titulo, 'Título actualizado');
      expect(original, isNot(mod));
    });
  });
}
