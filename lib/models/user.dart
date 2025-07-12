import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';


enum VolunteeringUserState {
  available,
  pending,
  accepted,
  full,
  busyOther,
  busyOtherPending,
  rejected,
  completed
}

@JsonSerializable()
@freezed
class UserVolunteering with _$UserVolunteering {
  UserVolunteering({
    required this.id,
    required this.estado,
  });

  factory UserVolunteering.fromJson(Map<String, dynamic> json) =>
      _$UserVolunteeringFromJson(json);
  Map<String, dynamic> toJson() => _$UserVolunteeringToJson(this);


  @override
  final String id;
  @override
  final VolunteeringUserState estado;
}

@JsonSerializable()
@freezed
class User with _$User {
  const User({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.hasSeenOnboarding,
    this.volunteerings,
    this.likedVolunteerings,
    this.telefono,
    this.fechaNacimiento,
    this.genero,
    this.imagenUrl,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  final String id;
  @override
  final String nombre;
  @override
  final String apellido;
  @override
  final String email;
  @override
  final bool hasSeenOnboarding;
  @override
  @JsonKey(name: 'voluntariados')
  final List<UserVolunteering>? volunteerings;
  @override
  @JsonKey(name: 'likedVoluntariados')
  final List<String>? likedVolunteerings;
  @override
  final String? telefono;
  @override
  final DateTime? fechaNacimiento;
  @override
  final String? genero;
  @override
  final String? imagenUrl;
  @override
  final String? fcmToken;
}
