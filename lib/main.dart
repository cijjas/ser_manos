import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';

import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Voluntariado App',
      routerConfig: _router,
      theme: appTheme,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: AppButton.filled(
          label: 'Go to Login',
          onPressed: () => context.go('/login'),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: AppButton.tonal(
          label: 'Back to Home',
          onPressed: () => context.go('/'),
        ),
      ),
    );
  }
}