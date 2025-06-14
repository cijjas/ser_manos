// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserVoluntariadoImpl _$$UserVoluntariadoImplFromJson(
        Map<String, dynamic> json) =>
    _$UserVoluntariadoImpl(
      id: json['id'] as String,
      estado: $enumDecode(_$VoluntariadoUserStateEnumMap, json['estado']),
    );

Map<String, dynamic> _$$UserVoluntariadoImplToJson(
        _$UserVoluntariadoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'estado': _$VoluntariadoUserStateEnumMap[instance.estado]!,
    };

const _$VoluntariadoUserStateEnumMap = {
  VoluntariadoUserState.available: 'available',
  VoluntariadoUserState.applied: 'applied',
  VoluntariadoUserState.accepted: 'accepted',
  VoluntariadoUserState.full: 'full',
  VoluntariadoUserState.busyOther: 'busyOther',
};

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      email: json['email'] as String,
      hasSeenOnboarding: json['hasSeenOnboarding'] as bool?,
      voluntariados: (json['voluntariados'] as List<dynamic>?)
          ?.map((e) => UserVoluntariado.fromJson(e as Map<String, dynamic>))
          .toList(),
      likedVoluntariados: (json['likedVoluntariados'] as List<dynamic>?)
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

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'email': instance.email,
      if (instance.hasSeenOnboarding case final value?)
        'hasSeenOnboarding': value,
      if (instance.voluntariados case final value?) 'voluntariados': value,
      if (instance.likedVoluntariados case final value?)
        'likedVoluntariados': value,
      if (instance.telefono case final value?) 'telefono': value,
      if (instance.fechaNacimiento?.toIso8601String() case final value?)
        'fechaNacimiento': value,
      if (instance.genero case final value?) 'genero': value,
      if (instance.imagenUrl case final value?) 'imagenUrl': value,
      if (instance.fcmToken case final value?) 'fcmToken': value,
    };
