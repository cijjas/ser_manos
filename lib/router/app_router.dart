import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/wireframes/error/error_page.dart';
import 'package:ser_manos/shared/wireframes/home/voluntariados_page.dart';

// wireframes / pages
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedades.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../services/notification_service.dart';
import '../shared/cells/header/header.dart';
import '../shared/wireframes/ingreso/login_page.dart';
import '../shared/wireframes/ingreso/register_page.dart';
import '../shared/wireframes/novedades/novedad_detail.dart';
import '../shared/wireframes/perfil/editar_perfil.dart';
import '../shared/wireframes/perfil/perfil_wrapper.dart';
import '../shared/wireframes/voluntariados/voluntariado_detail.dart';
import 'go_router_observer.dart';

/// Helper to map current location <--> tab index
int tabIndexFromLocation(String loc) {
  if (loc.startsWith('/home/postularse')) return 0;
  if (loc.startsWith('/home/perfil'))     return 1;
  return 2; // '/home/novedades'
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerRefreshNotifierProvider = Provider((ref) {
  final notifier = ValueNotifier<int>(0);

  // Listen to authentication state changes (login/logout)
  ref.listen(authStateProvider, (_, __) {
    notifier.value++;
  });

  // Listen to changes in the user's onboarding status
  ref.listen(
    currentUserProvider.select((userAsync) => userAsync.valueOrNull?.hasSeenOnboarding),
        (previous, next) {
      if (previous != next) {
        notifier.value++;
      }
    },
  );

  return notifier;
});

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);

  return GoRouter(
    observers: [FirebaseAnalyticsObserver()],
    navigatorKey: _rootNavigatorKey,
    restorationScopeId: 'router',
    // --- MODIFIED: Use the refreshListenable parameter ---
    refreshListenable: refreshNotifier,
    errorBuilder: (context, state) => const ErrorPage(message: "Página no encontrada"),
    initialLocation: '/',
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final currentUserAsync = ref.read(currentUserProvider);

      if (authState.isLoading || currentUserAsync.isLoading) return null;
      final isLoggedIn = authState.valueOrNull != null;
      final user = currentUserAsync.valueOrNull;

      // Guard: force onboarding once
      if (isLoggedIn &&
          user != null &&
          !(user.hasSeenOnboarding) &&
          state.matchedLocation != '/welcome') {
        return '/welcome';
      }
      // Guard: keep finished users out of /welcome
      if (isLoggedIn &&
          user != null &&
          (user.hasSeenOnboarding) &&
          state.matchedLocation == '/welcome') {
        return '/home/postularse';
      }
      // Auth-related locations
      final isAuthRoute = [
        '/',
        '/login',
        '/register',
      ].contains(state.matchedLocation);

      if (isLoggedIn && currentUserAsync is AsyncLoading) {
        return null; // Don't redirect yet
      }

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
        path: '/voluntariado/:id',
        name: "VolunteeringDetailsScreen",
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return VoluntariadoDetallePage(voluntariadoId: id);
        },
      ),

      GoRoute(
        path: '/novedad/:id',
        name: 'NewsDetailScreen',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return NovedadDetail(id: id);
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