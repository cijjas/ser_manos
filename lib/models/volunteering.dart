import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ser_manos/converters/geopoint_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/converters/trim_converter.dart';

import '../converters/timestamp_converter.dart';


part 'volunteering.freezed.dart';

part 'volunteering.g.dart';

enum VoluntariadoStatus {
  postulado,
  participando,
  participandoOtro,
  noVacantes,
  none,
}

@JsonSerializable()
@freezed
class Volunteering with _$Volunteering {
  const Volunteering({
    required this.id,
    required this.name,
    required this.type,
    required this.vacancies,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.summary,
    required this.requirements,
    required this.cost,
    required this.createdAt,
  });

  factory Volunteering.fromJson(String id, Map<String, dynamic> json) => _$VolunteeringFromJson({
    'id': id,
    ...json,
  });
  Map<String, dynamic> toJson() => _$VolunteeringToJson(this);

  @override
  final String id;
  @override
  @JsonKey(name: 'nombre')
  final String name;
  @override
  @JsonKey(name: 'tipo')
  final String type;
  @override
  @JsonKey(name: 'vacantes')
  final int vacancies;
  @override
  @GeoPointConverter()
  @JsonKey(name: 'location')
  final LatLng location;
  @override
  @TrimConverter()
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @override
  @JsonKey(name: 'descripcion')
  final String description;
  @override
  @JsonKey(name: 'resumen')
  final String summary;
  @override
  @JsonKey(name: 'requisitos')
  final String requirements;
  @override
  @JsonKey(name: 'costo')
  final double cost;
  @override
  @TimestampConverter()
  final DateTime createdAt;
}
