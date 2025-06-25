// lib/shared/wireframes/perfil/perfil_completo.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/app_routes.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/components/foto_perfil.dart';
import '../../cells/cards/card_informacion.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class PerfilCompletoPage extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const PerfilCompletoPage({
    super.key,
    required this.imageUrl,
    required this.role,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.onLogoutPressed,
  });

  final String imageUrl;
  final String role;
  final String name;
  final String email;
  final String birthDate;
  final String gender;
  final String phone;



  void _showLogoutModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmApplicationModal(
          title: '¿Estás seguro que quieres cerrar sesión?',
          message: '',
          confirmLabel: 'Cerrar sesión',
          cancelLabel: 'Cancelar',
          onConfirm: () {
            Navigator.pop(context);
            onLogoutPressed();
          },
          onCancel: () => Navigator.pop(context),
          actionType: ActionType.logout,
        )
    );
  }

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
                    FotoPerfil.lg(
                      imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      role.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.neutral75,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      email,
                      style: AppTypography.body01.copyWith(
                        color: AppColors.secondary200,
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 32),

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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    AppButton(
                      label: 'Editar perfil',
                      onPressed: () {
                        context.push(AppRoutes.homeProfileEdit);
                      },
                      type: AppButtonType.filled,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: 'Cerrar sesión',
                      onPressed: () => _showLogoutModal(context),
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
