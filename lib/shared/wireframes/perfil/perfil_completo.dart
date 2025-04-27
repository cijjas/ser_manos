// lib/shared/wireframes/perfil/perfil_completo.dart

import 'package:flutter/material.dart';
import '../../cells/header/header.dart';
import '../../molecules/components/foto_perfil.dart';
import '../../cells/cards/card_informacion.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

/// Página que muestra el perfil completo según el diseño compartido.
class PerfilCompletoPage extends StatelessWidget {
  const PerfilCompletoPage({
    super.key,
    required this.imageUrl,
    required this.role,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.phone,
  });

  final String imageUrl;
  final String role;
  final String name;
  final String email;
  final String birthDate;
  final String gender;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      selectedIndex: 1,
// Fondo neutro para todo el perfil
      body: Container(
        color: AppColors.neutral0,
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
// FOTO DE PERFIL + DATOS PRINCIPALES
              Column(
                children: [
                  FotoPerfil.lg(imageUrl: imageUrl),
                  const SizedBox(height: 24),
                  Text(
                    role.toUpperCase(),
                    style: AppTypography.overline.copyWith(
                      color: AppColors.neutral75,
                      letterSpacing: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: AppTypography.subtitle01.copyWith(
                      color: AppColors.neutral100,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: AppTypography.body01.copyWith(
                      color: AppColors.secondary200,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 32),

// TARJETAS DE INFORMACIÓN (ocupan todo el ancho disponible)
              CardInformacion(
                title: 'Información personal',
                label1: 'Fecha de nacimiento',
                content1: birthDate,
                label2: 'Género',
                content2: gender,
              ),
              const SizedBox(height: 24),
              CardInformacion(
                title: 'Datos de contacto',
                label1: 'Teléfono',
                content1: phone,
                label2: 'E-mail',
                content2: email,
              ),
              const SizedBox(height: 40),

// BOTONES
              AppButton(
                label: 'Editar perfil',
                onPressed: () {},
                type: AppButtonType.filled,
                fillWidth: true,
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Cerrar sesión',
                onPressed: () {},
                type: AppButtonType.tonal,
                fillWidth: true,
                textColor: AppColors.error100,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ejecución de la página de demo
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PerfilCompletoPage(
      imageUrl: 'https://picsum.photos/id/1005/300/300',
      role: 'Voluntario',
      name: 'Juan Cruz Gonzalez',
      email: 'mimail@mail.com',
      birthDate: '10/10/1990',
      gender: 'Hombre',
      phone: '+5491165863216',
    ),
  ));
}
