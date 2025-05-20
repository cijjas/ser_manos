import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// wireframes / pages
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/home/home_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedades.dart';

import '../models/voluntariado.dart';
import '../providers/auth_provider.dart';
import '../shared/cells/header/header.dart';
import '../shared/wireframes/ingreso/login_page.dart';
import '../shared/wireframes/ingreso/register_page.dart';
import '../shared/wireframes/novedades/novedad_detail.dart';
import '../shared/wireframes/perfil/perfil_completo.dart';
import '../shared/wireframes/voluntariados/voluntariado.dart';

/// Helper to map current location <--> tab index
int tabIndexFromLocation(String loc) {
  if (loc.startsWith('/home/postularse')) return 0;
  if (loc.startsWith('/home/perfil'))     return 1;
  return 2; // '/home/novedades'
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Handle auth state
      final isLoggedIn = authState.valueOrNull != null;

      // If we're still loading auth state, don't redirect yet
      if (authState.isLoading) return null;

      // Auth-related locations
      final isAuthRoute =
          state.matchedLocation == '/'
          || state.matchedLocation == '/login'
          || state.matchedLocation == '/register';

      // If user is logged in but on auth page, redirect to home
      if (isLoggedIn && isAuthRoute) {
        return '/home/postularse';
      }

      // If user is not logged in and tries to access protected pages, redirect to login
      if (!isLoggedIn && !isAuthRoute) {
        return '/';
      }

      return null;
    },
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
              print('state.extra: ${state.extra}');
              final voluntariadoId = state.extra! as String;
              return VoluntariadoDetallePage(voluntariadoId: voluntariadoId);
            },
          ),
          GoRoute(
            path: '/home/novedades',
            builder: (_, __) => NewsPage(),
          ),

        ],
      ),
      GoRoute(
        path: '/novedad/:id',
        name: 'novedad',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NovedadDetail(id: id);   // <-- only the id
        },
      ),
    ],
  );
});


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [


  ],
);