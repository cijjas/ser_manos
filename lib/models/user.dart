import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


/// Estados posibles con respecto al voluntariado
enum VoluntariadoUserState {
  available,  // hay vacantes y el usuario libre
  applied,    // se postuló, espera confirmación
  accepted,   // fue aceptado
  full,       // sin vacantes
  busyOther,  // participa en otro voluntariado
}

@Freezed(toJson: true)
class UserVoluntariado with _$UserVoluntariado {
  const factory UserVoluntariado({
    required String id,
    required VoluntariadoUserState estado,
  }) = _UserVoluntariado;

  factory UserVoluntariado.fromJson(Map<String, dynamic> json) =>
      _$UserVoluntariadoFromJson(json);
}

@Freezed(toJson: true)
class User with _$User {
  const factory User({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    bool? hasSeenOnboarding,
    List<UserVoluntariado>? voluntariados,
    String? telefono,
    DateTime? fechaNacimiento,
    String? genero,
    String? imagenUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}