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

@Freezed(toJson: true)
class UserVolunteering with _$UserVolunteering {
  const factory UserVolunteering({
    required String id,
    required VolunteeringUserState estado,
  }) = _UserVolunteering;

  factory UserVolunteering.fromJson(Map<String, dynamic> json) =>
      _$UserVolunteeringFromJson(json);
}

@Freezed(toJson: true)
class User with _$User {
  const factory User({
    required String id,
    required String nombre,
    required String apellido,
    required String email,
    required bool hasSeenOnboarding,
    @JsonKey(name: 'voluntariados') List<UserVolunteering>? volunteerings,
    @JsonKey(name: 'likedVoluntariados') List<String>? likedVolunteerings,
    String? telefono,
    DateTime? fechaNacimiento,
    String? genero,
    String? imagenUrl,
    String? fcmToken,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}