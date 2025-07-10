// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VolunteeringImpl _$$VolunteeringImplFromJson(Map<String, dynamic> json) =>
    _$VolunteeringImpl(
      id: json['id'] as String,
      name: json['nombre'] as String,
      type: json['tipo'] as String,
      vacancies: (json['vacantes'] as num).toInt(),
      location:
          const GeoPointConverter().fromJson(json['location'] as GeoPoint),
      imageUrl: const TrimConverter().fromJson(json['imageUrl']),
      description: json['descripcion'] as String,
      summary: json['resumen'] as String,
      requirements: json['requisitos'] as String,
      cost: (json['costo'] as num).toDouble(),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$VolunteeringImplToJson(_$VolunteeringImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'tipo': instance.type,
      'vacantes': instance.vacancies,
      'location': const GeoPointConverter().toJson(instance.location),
      'imageUrl': const TrimConverter().toJson(instance.imageUrl),
      'descripcion': instance.description,
      'resumen': instance.summary,
      'requisitos': instance.requirements,
      'costo': instance.cost,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
