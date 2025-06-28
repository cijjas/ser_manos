// models/novedad.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ser_manos/converters/trim_converter.dart';
import '../converters/timestamp_converter.dart';
part 'novedad.freezed.dart';
part 'novedad.g.dart';

@freezed
class Novedad with _$Novedad {
  const factory Novedad({
    required String id,
    required String titulo,
    required String resumen,
    required String emisor,
    @TrimConverter() required String imagenUrl,
    required String descripcion,
    @TimestampConverter() required DateTime createdAt,
  }) = _Novedad;

  factory Novedad.fromJson(Map<String, dynamic> json) => _$NovedadFromJson(json);
}