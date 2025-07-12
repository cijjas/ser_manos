// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVolunteering _$UserVolunteeringFromJson(Map<String, dynamic> json) =>
    UserVolunteering(
      id: json['id'] as String,
      estado: $enumDecode(_$VolunteeringUserStateEnumMap, json['estado']),
    );

Map<String, dynamic> _$UserVolunteeringToJson(UserVolunteering instance) =>
    <String, dynamic>{
      'id': instance.id,
      'estado': _$VolunteeringUserStateEnumMap[instance.estado]!,
    };

const _$VolunteeringUserStateEnumMap = {
  VolunteeringUserState.available: 'available',
  VolunteeringUserState.pending: 'pending',
  VolunteeringUserState.accepted: 'accepted',
  VolunteeringUserState.full: 'full',
  VolunteeringUserState.busyOther: 'busyOther',
  VolunteeringUserState.busyOtherPending: 'busyOtherPending',
  VolunteeringUserState.rejected: 'rejected',
  VolunteeringUserState.completed: 'completed',
};

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      email: json['email'] as String,
      hasSeenOnboarding: json['hasSeenOnboarding'] as bool,
      volunteerings: (json['voluntariados'] as List<dynamic>?)
          ?.map((e) => UserVolunteering.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedVolunteerings: (json['likedVoluntariados'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      telefono: json['telefono'] as String?,
      fechaNacimiento: json['fechaNacimiento'] == null
          ? null
          : DateTime.parse(json['fechaNacimiento'] as String),
      genero: json['genero'] as String?,
      imagenUrl: json['imagenUrl'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'email': instance.email,
      'hasSeenOnboarding': instance.hasSeenOnboarding,
      'voluntariados': instance.volunteerings,
      'likedVoluntariados': instance.likedVolunteerings,
      'telefono': instance.telefono,
      'fechaNacimiento': instance.fechaNacimiento?.toIso8601String(),
      'genero': instance.genero,
      'imagenUrl': instance.imagenUrl,
      'fcmToken': instance.fcmToken,
    };
