// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as String,
      title: json['titulo'] as String,
      summary: json['resumen'] as String,
      sender: json['emisor'] as String,
      imageUrl: const TrimConverter().fromJson(json['imagenUrl']),
      description: json['descripcion'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'titulo': instance.title,
      'resumen': instance.summary,
      'emisor': instance.sender,
      'imagenUrl': const TrimConverter().toJson(instance.imageUrl),
      'descripcion': instance.description,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
