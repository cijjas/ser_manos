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
      location:
          const GeoPointConverter().fromJson(json['location'] as GeoPoint),
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
      'location': const GeoPointConverter().toJson(instance.location),
      'descripcion': instance.descripcion,
      'resumen': instance.resumen,
      'notas': instance.notas,
    };
