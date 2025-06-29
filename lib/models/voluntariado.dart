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
  const factory Voluntariado({
    required String id,
    required String nombre,
    required String tipo,
    required int vacantes,
    @GeoPointConverter() required LatLng location,
    @TrimConverter() required String imageUrl,
    required String descripcion,
    required String resumen,
    required String requisitos,
    @TimestampConverter() required DateTime createdAt,
  }) = _Voluntariado;

  factory Voluntariado.fromJson(String id, Map<String, dynamic> json) =>
      _$VoluntariadoFromJson({
        "id": id,
        ...json,
      });
}
