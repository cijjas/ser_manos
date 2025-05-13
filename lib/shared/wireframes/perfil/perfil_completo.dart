import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // FOTO DE PERFIL + DATOS PRINCIPALES
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
              ),

              const SizedBox(height: 32),

              // TARJETAS DE INFORMACIÓN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
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
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // BOTONES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    AppButton(
                      label: 'Editar perfil',
                      onPressed: () {},
                      type: AppButtonType.filled,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Cerrar sesión',
                      onPressed: () {},
                      type: AppButtonType.tonal,
                      textColor: AppColors.error100,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}