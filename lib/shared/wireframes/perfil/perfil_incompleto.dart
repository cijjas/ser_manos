// lib/shared/wireframes/perfil/perfil_incompleto.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ser_manos/constants/app_assets.dart';

import '../../molecules/buttons/short_button.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../cells/modals/confirm_modal.dart';

/// Pantalla mostrada cuando el voluntario no completó su perfil.
class PerfilIncompletoPage extends StatelessWidget {
  const PerfilIncompletoPage({
    super.key,
    required this.name,
    this.role = 'Voluntario',
    required this.onCompletePressed,
    required this.onLogoutPressed,
  });

  final String name;
  final String role;
  final VoidCallback onCompletePressed;
  final VoidCallback onLogoutPressed;

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
    return Container(
      color: AppColors.neutral0,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.profile,
                      width: 120,
                      height: 120,
                      semanticsLabel: 'Avatar placeholder',
                      colorFilter: const ColorFilter.mode(
                        AppColors.secondary100,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 32),
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
                    const SizedBox(height: 16),
                    Text(
                      '¡Completá tu perfil para tener\nacceso a mejores oportunidades!',
                      style: AppTypography.body02.copyWith(
                        color: AppColors.neutral75,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Center(
                    child: ShortButton(
                      label: 'Completar',
                      icon: Icons.add,
                      onPressed: onCompletePressed,
                      variant: ShortButtonVariant.regular,
                    ),
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    label: 'Cerrar sesión',
                    onPressed: () => _showLogoutModal(context),
                    type: AppButtonType.tonal,
                    textColor: AppColors.error100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
