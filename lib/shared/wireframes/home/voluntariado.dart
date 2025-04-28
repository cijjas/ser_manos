import 'package:google_maps_flutter/google_maps_flutter.dart';

class Voluntariado {
  final String type;
  final String name;
  final String description;
  final String imageUrl;
  final LatLng position;
  final int vacants;

  const Voluntariado({
    required this.type,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.position,
    this.vacants = 0,
  });
}