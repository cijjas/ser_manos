// lib/shared/wireframes/voluntariado/voluntariado_detalle_fixed.dart

import 'package:flutter/material.dart';
import 'package:ser_manos/shared/molecules/components/vacants.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

/// Versión *fija* de la pantalla de detalle de voluntariado.
/// No incluye la sección inferior (postular / retirar / etc.).
class VoluntariadoDetallePage extends StatelessWidget {
  const VoluntariadoDetallePage({
    super.key,
    required this.imageUrl,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.activityDescription,
    required this.address,
    required this.requirements,
    required this.availability,
    required this.vacants,
  });

  final String imageUrl;
  final String type; // Acción social, etc.
  final String title;
  final String subtitle; // pequeño párrafo azul
  final String activityDescription;
  final String address;
  final List<String> requirements;
  final List<String> availability;
  final int vacants;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ───── Imagen de cabecera con botón back ─────
              Stack(
                children: [
                  SizedBox(
                    height: media.size.width * 0.6,
                    width: double.infinity,
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.neutral0),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type.toUpperCase(),
                      style: AppTypography.overline.copyWith(color: AppColors.neutral75),
                    ),
                    const SizedBox(height: 4),
                    Text(title, style: AppTypography.headline01.copyWith(color: AppColors.neutral100)),
                    const SizedBox(height: 16),
                    Text(
                      subtitle,
                      style: AppTypography.body01.copyWith(color: AppColors.secondary200),
                    ),

                    const SizedBox(height: 32),

                    Text('Sobre la actividad', style: AppTypography.headline02.copyWith(color: AppColors.neutral100)),
                    const SizedBox(height: 8),
                    Text(activityDescription, style: AppTypography.body01),

                    const SizedBox(height: 32),

                    // ───── Ubicación (sin mapa interactivo) ─────
                    _LocationCard(address: address),

                    const SizedBox(height: 32),

                    Text('Participar del voluntariado', style: AppTypography.headline02.copyWith(color: AppColors.neutral100)),
                    const SizedBox(height: 16),

                    Text('Requisitos', style: AppTypography.subtitle01),
                    const SizedBox(height: 8),
                    _BulletList(lines: requirements),
                    const SizedBox(height: 16),

                    Text('Disponibilidad', style: AppTypography.subtitle01),
                    const SizedBox(height: 8),
                    _BulletList(lines: availability),

                    const SizedBox(height: 24),
                    VacantsDisplay(initialNumber: vacants),

                    const SizedBox(height: 64), // espacio para la futura sección variable
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

// ──────────────────────────────────────────────────────────────────────
/// Card simplificada con título "Ubicación", imagen placeholder y dirección.
class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondary10,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
            child: Text('Ubicación', style: AppTypography.headline02),
          ),
          // Placeholder del mapa (200 px)
          Container(
            height: 200,
            color: AppColors.neutral25,
            alignment: Alignment.center,
            child: const Icon(Icons.map, size: 64, color: AppColors.neutral50),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dirección', style: AppTypography.overline.copyWith(color: AppColors.neutral75)),
                const SizedBox(height: 4),
                Text(address, style: AppTypography.body01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
class _BulletList extends StatelessWidget {
  const _BulletList({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: AppTypography.body01),
                Expanded(child: Text(line, style: AppTypography.body01)),
              ],
            ),
          ),
      ],
    );
  }
}

/// Demo minimal para probar la parte fija
void main() {
runApp(const MaterialApp(
debugShowCheckedModeBanner: false,
home: VoluntariadoDetallePage(
imageUrl: 'https://picsum.photos/id/1032/800/400',
type: 'Acción Social',
title: 'Un Techo para mi País',
subtitle: 'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
activityDescription: 'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.',
address: 'Echeverría 3560, Capital Federal.',
requirements: ['Mayor de edad.', 'Poder levantar cosas pesadas.'],
availability: ['Mayor de edad.', 'Poder levantar cosas pesadas.'],
vacants: 10,
),
));
}
