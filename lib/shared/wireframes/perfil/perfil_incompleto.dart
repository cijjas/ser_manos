// lib/shared/wireframes/perfil/perfil_incompleto.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cells/header/header.dart';
import '../../molecules/buttons/short_button.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

/// Pantalla mostrada cuando el voluntario aún no completó su perfil.
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

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      selectedIndex: 1,
      body: Container(
        color: AppColors.neutral0,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
// ───── Bloque central (expandido y centrado) ─────
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/perfil.svg',
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

// ───── Botones pegados abajo ─────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                      onPressed: onLogoutPressed,
                      type: AppButtonType.tonal,
                      textColor: AppColors.error100,
                    ),
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

/// Demo rápida standalone
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PerfilIncompletoPage(
      name: 'Juan Cruz Gonzalez',
      onCompletePressed: _dummy,
      onLogoutPressed: _dummy,
    ),
  ));
}

void _dummy() {}
