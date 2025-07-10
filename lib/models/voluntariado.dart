import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ser_manos/converters/geopoint_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/converters/trim_converter.dart';

import '../converters/timestamp_converter.dart';


part 'voluntariado.freezed.dart';

part 'voluntariado.g.dart';

enum VoluntariadoStatus {
  postulado,
  participando,
  participandoOtro,
  noVacantes,
  none,
}

@freezed
class Voluntariado with _$Voluntariado {
  const Voluntariado._();
  const factory Voluntariado({
    required String id,
    @JsonKey(name: 'nombre') required String name,
    @JsonKey(name: 'tipo') required String type,
    @JsonKey(name: 'vacantes') required int vacancies,
    @GeoPointConverter() @JsonKey(name: 'location') required LatLng location,
    @TrimConverter() @JsonKey(name: 'imageUrl') required String imageUrl,
    @JsonKey(name: 'descripcion') required String description,
    @JsonKey(name: 'resumen') required String summary,
    @JsonKey(name: 'requisitos') required String requirements,
    @JsonKey(name: 'costo') required double cost,
    @TimestampConverter() @JsonKey(name: 'createdAt') required DateTime createdAt,
  }) = _Voluntariado;

  factory Voluntariado.fromJson(String id, Map<String, dynamic> json) => _$VoluntariadoFromJson({
    'id': id,
    ...json,
  });
}
