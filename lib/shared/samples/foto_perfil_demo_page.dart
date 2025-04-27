import 'package:flutter/material.dart';
import '../cells/header/header.dart';
import '../molecules/components/foto_perfil.dart';

/// Página de prueba para ver los dos tamaños de avatar.
class FotoPerfilDemoPage extends StatelessWidget {
  const FotoPerfilDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppHeader(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FotoPerfil.lg(
              imageUrl: 'https://picsum.photos/id/1011/300/300',
            ),
            SizedBox(height: 24),
            FotoPerfil.sm(
              imageUrl: 'https://picsum.photos/id/1025/300/300',
            ),
            SizedBox(height: 24),
            FotoPerfil.sm(
              imageUrl: 'https://bad.domain/not_found.jpg', // prueba estado error
            ),
          ],
        ),
      ),
    );
  }
}

/// Para lanzar rápidamente la demo:
void main() => runApp(const _DemoApp());

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foto Perfil Demo',
      theme: ThemeData(useMaterial3: true),
      home: const FotoPerfilDemoPage(),
    );
  }
}
