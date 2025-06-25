import 'package:flutter_test/flutter_test.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('Voluntariado model', () {
    // Datos simulados tal como vendrían de Firestore
    const geo = GeoPoint(-34.6037, -58.3816);          // Obelisco BA
    final ts  = Timestamp.fromDate(DateTime(2024, 5, 1, 10)); // 1-may-2024 10:00

    final firestoreJson = {
      'nombre': 'Comedor San Cayetano',
      'tipo': 'Alimentos',
      'vacantes': 5,
      'location': geo,
      'imageUrl': 'https://example.com/img.png',
      'descripcion': 'Ayuda a servir almuerzos',
      'resumen': 'Comedor comunitario',
      'requisitos': 'Buena onda y compromiso',
      'createdAt': ts,
    };

    test('fromJson convierte GeoPoint y Timestamp correctamente', () {
      final v = Voluntariado.fromJson('v123', firestoreJson);

      expect(v.id, 'v123');
      expect(v.location, const LatLng(-34.6037, -58.3816)); // GeoPoint a LatLng
      expect(v.createdAt, ts.toDate());                     // Timestamp a DateTime
      expect(v.vacantes, 5);
    });

    test('toJson lleva LatLng y DateTime de vuelta a GeoPoint/Timestamp', () {
      final v       = Voluntariado.fromJson('v123', firestoreJson);
      final encoded = v.toJson();

      // Ubicación vuelve a ser GeoPoint
      expect(encoded['location'], isA<GeoPoint>());
      final encGeo = encoded['location'] as GeoPoint;
      expect(encGeo.latitude,  -34.6037);
      expect(encGeo.longitude, -58.3816);

      // Fecha vuelve a Timestamp
      expect(encoded['createdAt'], isA<Timestamp>());
      final encTs = encoded['createdAt'] as Timestamp;
      expect(encTs, ts);

      // Campo escalar de muestra
      expect(encoded['nombre'], 'Comedor San Cayetano');
    });

    test('round-trip mantiene igualdad', () {
      final original = Voluntariado.fromJson('v123', firestoreJson);
      final v2       = Voluntariado.fromJson('v123', original.toJson());

      expect(v2, equals(original));
    });

    test('copyWith no muta la instancia original', () {
      final base     = Voluntariado.fromJson('v123', firestoreJson);
      final modified = base.copyWith(vacantes: 0); // sin plazas

      expect(base.vacantes, 5);
      expect(modified.vacantes, 0);
      expect(base, isNot(modified));
    });
  });
}
