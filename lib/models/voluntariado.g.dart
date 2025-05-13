// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voluntariado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoluntariadoImpl _$$VoluntariadoImplFromJson(Map<String, dynamic> json) =>
    _$VoluntariadoImpl(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      tipo: json['tipo'] as String,
      vacantes: (json['vacantes'] as num).toInt(),
      isLiked: json['isLiked'] as bool,
      location: const LatLngConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      estado: $enumDecode(_$VoluntariadoStatusEnumMap, json['estado']),
      descripcion: json['descripcion'] as String,
      resumen: json['resumen'] as String,
      notas: json['notas'] as String?,
    );

Map<String, dynamic> _$$VoluntariadoImplToJson(_$VoluntariadoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'tipo': instance.tipo,
      'vacantes': instance.vacantes,
      'isLiked': instance.isLiked,
      'location': const LatLngConverter().toJson(instance.location),
      'estado': _$VoluntariadoStatusEnumMap[instance.estado]!,
      'descripcion': instance.descripcion,
      'resumen': instance.resumen,
      'notas': instance.notas,
    };

const _$VoluntariadoStatusEnumMap = {
  VoluntariadoStatus.postulado: 'postulado',
  VoluntariadoStatus.participando: 'participando',
  VoluntariadoStatus.participandoOtro: 'participandoOtro',
  VoluntariadoStatus.noVacantes: 'noVacantes',
  VoluntariadoStatus.none: 'none',
};
