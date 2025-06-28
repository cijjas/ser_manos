// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novedad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NovedadImpl _$$NovedadImplFromJson(Map<String, dynamic> json) =>
    _$NovedadImpl(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      resumen: json['resumen'] as String,
      emisor: json['emisor'] as String,
      imagenUrl: const TrimConverter().fromJson(json['imagenUrl']),
      descripcion: json['descripcion'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$NovedadImplToJson(_$NovedadImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'resumen': instance.resumen,
      'emisor': instance.emisor,
      'imagenUrl': const TrimConverter().toJson(instance.imagenUrl),
      'descripcion': instance.descripcion,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
