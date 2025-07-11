import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoPointConverter implements JsonConverter<LatLng, GeoPoint> {
  const GeoPointConverter();

  @override
  LatLng fromJson(GeoPoint geoPoint) {
    return LatLng(geoPoint.latitude, geoPoint.longitude);
  }

  @override
  GeoPoint toJson(LatLng latLng) {
    return GeoPoint(latLng.latitude, latLng.longitude);
  }
}
