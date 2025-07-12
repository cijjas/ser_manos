// models/news.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ser_manos/converters/trim_converter.dart';
import '../converters/timestamp_converter.dart';

part 'news.freezed.dart';

part 'news.g.dart';

@JsonSerializable()
@freezed
class News with _$News {
  const News({
    required this.id,
    required this.title,
    required this.summary,
    required this.sender,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);

  @override
  final String id;
  @override
  @JsonKey(name: 'titulo')
  final String title;
  @override
  @JsonKey(name: 'resumen')
  final String summary;
  @override
  @JsonKey(name: 'emisor')
  final String sender;
  @override
  @TrimConverter()
  @JsonKey(name: 'imagenUrl')
  final String imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  final String description;
  @override
  @TimestampConverter()
  final DateTime createdAt;
}
