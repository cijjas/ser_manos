import 'package:flutter/material.dart';


class AppShadows {
  const AppShadows._(); // no‑instantiation

  static const List<BoxShadow> sombra1 = [
    // Layer 1: 15 % opacity, light blur
    BoxShadow(
      color: Color(0x26000000), // #000000 15 %
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
    ),
    // Layer 2: 30 % opacity, very subtle
    BoxShadow(
      color: Color(0x4C000000), // #000000 30 %
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// **Sombra 2** — 2‑layer, medium elevation.
  static const List<BoxShadow> sombra2 = [
    BoxShadow(
      color: Color(0x26000000), // #000000 15 %
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: Color(0x4C000000), // #000000 30 %
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  /// **Sombra 3** — highest elevation preset.
  static const List<BoxShadow> sombra3 = [
    BoxShadow(
      color: Color(0x4C000000), // #000000 30 %
      offset: Offset(0, 4),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x26000000), // #000000 15 %
      offset: Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 6,
    ),
  ];
}
