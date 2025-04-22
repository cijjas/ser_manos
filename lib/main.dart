import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ser_manos/shared/samples/card_test_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso.dart';

void main() {
  debugPaintSizeEnabled = true; // Enables visual debugging
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IngresoPage(),
    );
  }
}
