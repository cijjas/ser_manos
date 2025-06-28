// models/novedad.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/timestamp_converter.dart';

part 'novedad.freezed.dart';
part 'novedad.g.dart';

// Enhanced _sanitizeUrl to handle more potential issues
String _sanitizeUrl(String url) {
  // Remove all whitespace characters
  String sanitized = url.replaceAll(RegExp(r'\s+'), '');
  // Optionally, you could add more URL encoding/decoding here if needed
  // For example, if you suspect URL encoding issues:
  // try {
  //   sanitized = Uri.decodeComponent(sanitized);
  // } catch (e) {
  //   // Handle decoding errors if necessary
  // }
  return sanitized;
}

@freezed
class Novedad with _$Novedad {
  const factory Novedad({
    required String id,
    required String titulo,
    required String resumen,
    required String emisor,
    @JsonKey(fromJson: _sanitizeUrl, toJson: _sanitizeUrl)
    required String imagenUrl,
    required String descripcion,
    @TimestampConverter() required DateTime createdAt,
  }) = _Novedad;

  factory Novedad.fromJson(Map<String, dynamic> json) => _$NovedadFromJson(json);
}