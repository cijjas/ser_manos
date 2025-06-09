import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/wireframes/error/error_page.dart';
import 'package:ser_manos/shared/wireframes/home/voluntariados_page.dart';

// wireframes / pages
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/home/voluntariado_list.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedades.dart';

import '../models/voluntariado.dart';
import '../providers/auth_provider.dart';
import '../services/notification_service.dart';
import '../shared/cells/header/header.dart';
import '../shared/wireframes/ingreso/login_page.dart';
import '../shared/wireframes/ingreso/register_page.dart';
import '../shared/wireframes/novedades/novedad_detail.dart';
import '../shared/wireframes/perfil/perfil_completo.dart';
import '../shared/wireframes/perfil/editar_perfil.dart';
import '../shared/wireframes/perfil/perfil_wrapper.dart';
import '../shared/wireframes/voluntariados/voluntariado.dart';
import 'go_router_observer.dart';

/// Helper to map current location <--> tab index
int tabIndexFromLocation(String loc) {
  if (loc.startsWith('/home/postularse')) return 0;
  if (loc.startsWith('/home/perfil'))     return 1;
  return 2; // '/home/novedades'
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    observers: [FirebaseAnalyticsObserver()],
    navigatorKey: navigatorKey,
    restorationScopeId: 'router', // TODO check usage
    errorBuilder: (context, state) => const ErrorPage(message: "Página no encontrada"),
    initialLocation: '/',
    redirect: (context, state) {
      // Handle auth state
      final isLoggedIn = authState.valueOrNull != null;

      // If we're still loading auth state, don't redirect yet
      if (authState.isLoading) return null;

      // Auth-related locations
      final isAuthRoute = [
        '/',
        '/login',
        '/register',
      ].contains(state.matchedLocation);

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
        name: "EntryScreen",
        builder: (_, __) => const EntryPage(),
      ),
      GoRoute(
        path: '/login',
        name: "LoginScreen",
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: "RegisterScreen",
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: '/welcome',
        name: "WelcomeScreen",
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
          name: "ProfileTab",
          builder: (_, __) => const PerfilWrapperPage(),


        ),
        GoRoute(
          path: '/home/postularse',
          name: "VolunteeringTab",
          builder: (_, __) => const VoluntariadosPage(),
        ),
        GoRoute(
          path: '/home/novedades',
          name: "NewsTab",
          builder: (_, __) => const NewsPage(),
        ),

        ],
      ),
      GoRoute(
        path: '/voluntariado',
        name: "VolunteeringDetailsScreen",
        builder: (_, state) {
          final voluntariadoId = state.extra is String ? state.extra as String : '';
          if (voluntariadoId.isEmpty) {
            return const ErrorPage(message: 'Missing activity ID');
          }
          return VoluntariadoDetallePage(voluntariadoId: voluntariadoId);
        },
      ),
      GoRoute(
        path: '/novedad/:id',
        name: 'NewsDetailScreen',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NovedadDetail(id: id);   // <-- only the id
        },
      ),

      GoRoute(
        path: '/home/perfil/editar',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const EditarPerfilPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        ),
      ),


    ],
  );
});