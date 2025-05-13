// lib/utils/converters/latlng_converter.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json['lat'] as double, json['lng'] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng latLng) => {
    'lat': latLng.latitude,
    'lng': latLng.longitude,
  };
}
