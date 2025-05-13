import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ser_manos/converters/geoPoint_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../converters/geoPoint_converter.dart';

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
// required bool isLiked, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
    @GeoPointConverter() required LatLng location,
//    required VoluntariadoStatus estado, // TODO, esto depende del usuario, no? No deberia estar dentro de la clase User?
    required String descripcion,
    required String resumen,
    String? notas,
  }) = _Voluntariado;

  factory Voluntariado.fromJson(Map<String, dynamic> json) =>
      _$VoluntariadoFromJson(json);
}
