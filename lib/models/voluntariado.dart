import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../converters/latlng_converter.dart';

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
    required bool isLiked,
    @LatLngConverter() required LatLng location,
    required VoluntariadoStatus estado,
    required String descripcion,
    required String resumen,
    String? notas,
  }) = _Voluntariado;

  factory Voluntariado.fromJson(Map<String, dynamic> json) =>
      _$VoluntariadoFromJson(json);
}
