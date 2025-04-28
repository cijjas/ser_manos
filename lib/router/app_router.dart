import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// wireframes / pages
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/home/home.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedades.dart';

import '../shared/cells/header/header.dart';
import '../shared/wireframes/home/voluntariado.dart';
import '../shared/wireframes/home/voluntariado-map.dart';
import '../shared/wireframes/ingreso/login_page.dart';
import '../shared/wireframes/ingreso/register_page.dart';
import '../shared/wireframes/perfil/perfil_completo.dart';

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
      builder: (_, __) => const EntryPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (_, __) => const RegisterPage(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (_, __) => const WelcomePage(),
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
          path: '/home/perfil',
          builder: (_, __) => const PerfilCompletoPage(
            imageUrl: 'https://picsum.photos/id/1005/300/300',
            role: 'Voluntario',
            name: 'Juan Cruz Gonzalez',
            email: 'mimail@mail.com',
            birthDate: '10/10/1990',
            gender: 'Hombre',
            phone: '+5491165863216',
          ),
        ),
        GoRoute(
          path: '/home/postularse',
          builder: (_, __) => HomePage(),
        ),
        GoRoute(
          path: '/voluntariado',
          builder: (_, state) {
            final voluntariado = state.extra! as Voluntariado;
            return VoluntariadoMapPage(voluntariado: voluntariado);
          },
        ),
        GoRoute(
          path: '/home/novedades',
          builder: (_, __) => NewsPage(),
        ),
      ],
    ),
  ],
);