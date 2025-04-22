import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:ser_manos/shared/cells/header/header.dart';
import 'package:ser_manos/shared/samples/header_page.dart';
import 'package:ser_manos/shared/samples/button_demo_page.dart';

void main() {
  debugPaintSizeEnabled = false; // Enables visual debugging
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HeaderPage(),
    );
  }
}

