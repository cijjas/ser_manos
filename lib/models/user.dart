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
    required this.name,
    required this.surname,
    required this.email,
    required this.hasSeenOnboarding,
    this.volunteerings,
    this.likedVolunteerings,
    this.phoneNumber,
    this.birthDate,
    this.gender,
    this.imageUrl,
    this.fcmToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  final String id;
  @override
  @JsonKey(name: 'nombre')
  final String name;
  @override
  @JsonKey(name: 'apellido')
  final String surname;
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
  @JsonKey(name: 'telefono')
  final String? phoneNumber;
  @override
  @JsonKey(name: 'fechaNacimiento')
  final DateTime? birthDate;
  @override
  @JsonKey(name: 'genero')
  final String? gender;
  @override
  @JsonKey(name: 'imagenUrl')
  final String? imageUrl;
  @override
  final String? fcmToken;
}
