import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


// TODO: SPANISH

/// Estados posibles con respecto al voluntariado
enum VoluntariadoUserState {
  available,  // hay vacantes y el usuario libre
  pending,    // se postuló, espera confirmación
  accepted,   // fue aceptado
  full,       // sin vacantes
  busyOther,  // participa en otro voluntariado
  rejected,  // fue rechazado
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
    required bool hasSeenOnboarding,
    @JsonKey(includeIfNull: false) List<UserVoluntariado>? voluntariados,
    @JsonKey(includeIfNull: false) List<String>? likedVoluntariados,
    @JsonKey(includeIfNull: false) String? telefono,
    @JsonKey(includeIfNull: false) DateTime? fechaNacimiento,
    @JsonKey(includeIfNull: false) String? genero,
    @JsonKey(includeIfNull: false) String? imagenUrl,
    @JsonKey(includeIfNull: false) String? fcmToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}