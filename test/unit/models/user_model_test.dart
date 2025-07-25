import 'package:flutter_test/flutter_test.dart';
import 'package:ser_manos/models/user.dart';

void main() {
  group('User model (sin modificar modelo)', () {
    const srcJson = {
      'id': 'u123',
      'nombre': 'Ada',
      'apellido': 'Lovelace',
      'email': 'ada@lovelace.dev',
      'hasSeenOnboarding': true,
      'telefono': '+54110000000',
      'fechaNacimiento': '1990-12-10T00:00:00.000',
      'genero': 'F',
      'imagenUrl': 'https://example.com/avatar.png',
      'fcmToken': 'abc123',
      'voluntariados': [
        {'id': 'v1', 'estado': 'accepted'}
      ],
      'likedVoluntariados': ['v1', 'v2'],
    };

    test('fromJson crea la instancia con todos los campos', () {
      final user = User.fromJson(srcJson);

      expect(user.id, 'u123');
      expect(user.volunteerings, isNotNull);
      expect(user.volunteerings!.first.id, 'v1');
      expect(user.volunteerings!.first.estado.name, 'accepted');
    });

    test('toJson conserva valores escalares y lista de objetos', () {
      final user    = User.fromJson(srcJson);
      final encoded = user.toJson();

      expect(encoded['email'],             'ada@lovelace.dev');
      expect(encoded['hasSeenOnboarding'], true);

      final vols = encoded['voluntariados'] as List;
      expect(vols.length, 1);
      expect(vols.first, isA<UserVolunteering>());
      expect((vols.first as UserVolunteering).id, 'v1');
    });

    test('campos opcionales pueden ser null y se mantienen en toJson', () {
      const minimalJson = {
        'id': 'u124',
        'nombre': 'Linus',
        'apellido': 'Torvalds',
        'email': 'linus@kernel.org',
        'hasSeenOnboarding': false,
      };

      final user    = User.fromJson(minimalJson);
      final encoded = user.toJson();

      // getters
      expect(user.phoneNumber, isNull);
      expect(user.hasSeenOnboarding, isFalse);

      // la clave existe y su valor es null
      expect(encoded.containsKey('telefono'), isTrue);
      expect(encoded['telefono'], isNull);

      // otro campo opcional
      expect(encoded.containsKey('genero'), isTrue);
      expect(encoded['genero'], isNull);

      expect(encoded['hasSeenOnboarding'], false);
    });

    test('copyWith mantiene inmutabilidad', () {
      final original = User.fromJson(srcJson);
      final updated  = original.copyWith(name: 'Grace');

      expect(original.name, 'Ada');
      expect(updated.name,  'Grace');
      expect(original, isNot(updated));
    });
  });
}
