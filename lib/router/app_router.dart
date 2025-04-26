import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// wireframes / pages
import 'package:ser_manos/shared/wireframes/ingreso/ingreso.dart';
import 'package:ser_manos/shared/wireframes/home/home.dart';
import 'package:ser_manos/shared/wireframes/home/novedades.dart';

import '../shared/cells/header/header.dart';
import '../shared/wireframes/ingreso/iniciar_sesion.dart';
import '../shared/wireframes/ingreso/registro.dart';

/// Helper to map current location <--> tab index
int tabIndexFromLocation(String loc) {
  if (loc.startsWith('/home/postularse')) return 0;
  if (loc.startsWith('/home/perfil'))     return 1;
  return 2; // '/home/novedades'
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const IngresoPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const RegisterPage(),
    ),


    /// ---------------- HOME + three tabs ----------------
    ShellRoute(
      builder: (context, state, child) {
        final idx = tabIndexFromLocation(state.uri.toString());
        return AppHeader(
          selectedIndex: idx,
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home/postularse',
          builder: (_, __) => HomePage(),
        ),
        GoRoute(
          path: '/home/perfil',
          builder: (_, __) => const Placeholder(),
        ),
        GoRoute(
          path: '/home/novedades',
          builder: (_, __) => NewsPage(),
        ),
      ],
    ),
  ],
);