import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/wireframes/error/error_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/entry_page.dart';
import 'package:ser_manos/shared/wireframes/ingreso/welcome_page.dart';
import 'package:ser_manos/shared/wireframes/novedades/novedades.dart';

import '../constants/app_routes.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../shared/cells/header/header.dart';
import '../shared/wireframes/ingreso/login_page.dart';
import '../shared/wireframes/ingreso/register_page.dart';
import '../shared/wireframes/novedades/novedad_detail.dart';
import '../shared/wireframes/perfil/editar_perfil.dart';
import '../shared/wireframes/perfil/perfil_wrapper.dart';
import '../shared/wireframes/voluntariados/voluntariado_detail.dart';
import '../shared/wireframes/voluntariados/voluntariados_page.dart';
import 'go_router_observer.dart';

int tabIndexFromLocation(String loc) {
  if (loc.startsWith(AppRoutes.homeVolunteering)) return 0;
  if (loc.startsWith(AppRoutes.homeProfile))        return 1;
  return 2; // news
}

final navigatorKey = GlobalKey<NavigatorState>();

/// Notificador para refresh cuando cambia auth / onboarding
final routerRefreshNotifierProvider = Provider((ref) {
  final notifier = ValueNotifier<int>(0);

  ref.listen(authStateProvider, (_, __) => notifier.value++);
  ref.listen(
    currentUserProvider
        .select((u) => u.valueOrNull?.hasSeenOnboarding),
        (prev, next) {
      if (prev != next) notifier.value++;
    },
  );

  return notifier;
});

final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);

  return GoRouter(
    observers: [FirebaseAnalyticsObserver()],
    navigatorKey: navigatorKey,
    restorationScopeId: 'router',
    refreshListenable: refreshNotifier,
    errorBuilder: (_, __) =>
    const ErrorPage(message: 'Página no encontrada'),
    initialLocation: AppRoutes.entry,

    /// --------- REDIRECTS ----------
    redirect: (context, state) {
      final authState       = ref.read(authStateProvider);
      final currentUserAsync= ref.read(currentUserProvider);
      if (authState.isLoading || currentUserAsync.isLoading) return null;

      final isLoggedIn = authState.valueOrNull != null;
      final user       = currentUserAsync.valueOrNull;

      if (isLoggedIn &&
          user != null &&
          !user.hasSeenOnboarding &&
          state.matchedLocation != AppRoutes.welcome) {
        return AppRoutes.welcome;
      }

      if (isLoggedIn &&
          user != null &&
          user.hasSeenOnboarding &&
          state.matchedLocation == AppRoutes.welcome) {
        return AppRoutes.homeVolunteering;
      }

      final isAuthRoute = {
        AppRoutes.entry,
        AppRoutes.login,
        AppRoutes.register,
      }.contains(state.matchedLocation);

      if (isLoggedIn && isAuthRoute) {
        return AppRoutes.homeVolunteering;
      }
      if (!isLoggedIn && !isAuthRoute) {
        return AppRoutes.entry;
      }
      return null;
    },

    routes: [
      GoRoute(
        path: AppRoutes.entry,
        name: RouteNames.entry,
        builder: (_, __) => const EntryPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: RouteNames.login,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: RouteNames.register,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        name: RouteNames.welcome,
        builder: (_, __) => const WelcomePage(),
      ),

      /// ----- HOME + TABS -----
      ShellRoute(
        builder: (context, state, child) {
          final idx = tabIndexFromLocation(state.uri.toString());
          return AppHeader(selectedIndex: idx, body: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.homeProfile,
            name: RouteNames.profileTab,
            pageBuilder: (_, __) =>
            const NoTransitionPage(child: PerfilWrapperPage()),
          ),
          GoRoute(
            path: AppRoutes.homeVolunteering,
            name: RouteNames.volunteeringTab,
            pageBuilder: (_, __) =>
            const NoTransitionPage(child: VoluntariadosPage()),
          ),
          GoRoute(
            path: AppRoutes.homeNews,
            name: RouteNames.newsTab,
            pageBuilder: (_, __) =>
            const NoTransitionPage(child: NewsPage()),
          ),
        ],
      ),

      /// ----- DETALLES -----
      GoRoute(
        path: AppRoutes.volunteering,
        name: RouteNames.volunteeringDetails,
        builder: (_, state) =>
            VoluntariadoDetallePage(voluntariadoId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.news,
        name: RouteNames.newsDetail,
        builder: (_, state) =>
            NovedadDetail(id: state.pathParameters['id']!),
      ),

      /// ----- EDITAR PERFIL -----
      GoRoute(
        path: AppRoutes.homeProfileEdit,
        pageBuilder: (_, __) => CustomTransitionPage(
          child: const EditarPerfilPage(),
          transitionsBuilder: (_, animation, __, child) =>
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