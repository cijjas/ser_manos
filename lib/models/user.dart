import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    String? telefono,
    DateTime? fechaNacimiento,
    String? genero,
    String? imagenUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}