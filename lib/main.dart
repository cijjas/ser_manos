import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/molecules/components/vacants.dart';
import 'package:flutter/foundation.dart';
import 'package:ser_manos/shared/molecules/tabs/tab.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/colors.dart';

void main() {
  debugPaintSizeEnabled = false; // Enables visual debugging
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
        /*child: AppButton.filled(
          label: 'Go to Login',
          onPressed: () => context.go('/login'),
        ),*/
        child: AppTab(label: "Test", onTap: () => {print("Tab")}, isSelected: false,),
        // child: CardVoluntariado(type: 'Acción Social', name: 'Un Techo para mi País', imgUrl: 'https://picsum.photos/300/200'),

       // child: AppIcon(icon: AppIcons.MOSTRAR, color: AppIconsColor.PRIMARY)
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