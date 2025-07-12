// models/news.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ser_manos/converters/trim_converter.dart';
import '../converters/timestamp_converter.dart';
part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class News with _$News {
  const factory News({
    required String id,
    @JsonKey(name: 'titulo') required String title,
    @JsonKey(name: 'resumen') required String summary,
    @JsonKey(name: 'emisor') required String sender,
    @TrimConverter() @JsonKey(name: 'imagenUrl') required String imageUrl,
    @JsonKey(name: 'descripcion') required String description,
    @TimestampConverter() required DateTime createdAt,
  }) = _News;

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
