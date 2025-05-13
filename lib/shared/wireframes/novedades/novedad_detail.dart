import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../cells/header/header_seccion.dart';
import 'novedad.dart';

class NovedadDetail extends StatelessWidget {
  final Novedad novedad;

  const NovedadDetail({super.key, required this.novedad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeaderSection(title: 'Novedades'),

          // main scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(novedad.type.toUpperCase(), style: AppTypography.overline),
                  const SizedBox(height: 4),
                  Text(novedad.name, style: AppTypography.headline02),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      novedad.imgUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    novedad.description,
                    style: AppTypography.subtitle01.copyWith(
                      color: AppColors.primary100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aquí iría el cuerpo completo del contenido...',
                    style: AppTypography.body01,
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        const Text("Comparte esta nota",
                            style: AppTypography.headline02),
                        const SizedBox(height: 12),
                        AppButton(
                          label: "Compartir",
                          onPressed: () => context.go('/share'),
                          type: AppButtonType.filled,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
