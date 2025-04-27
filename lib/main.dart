import 'package:flutter/material.dart';
import 'package:ser_manos/router/app_router.dart';
import 'package:flutter/rendering.dart';
import 'package:ser_manos/shared/wireframes/home/novedades.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}