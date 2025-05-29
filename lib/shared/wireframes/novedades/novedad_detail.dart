import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/shared/molecules/buttons/app_button.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';
import 'package:ser_manos/providers/novedad_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../cells/header/header_seccion.dart';

class NovedadDetail extends ConsumerWidget {
  final String id;
  const NovedadDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final novedadAsync = ref.watch(novedadByIdProvider(id));

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: novedadAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (novedad) => SingleChildScrollView(
          child: Column(
            children: [
              const AppHeaderSection(title: 'Novedades'),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(novedad.titulo.toUpperCase(), style: AppTypography.overline),
                    const SizedBox(height: 4),
                    Text(novedad.titulo, style: AppTypography.headline02),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        novedad.imagenUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      novedad.resumen,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.primary100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(novedad.descripcion, style: AppTypography.body01),
                    const SizedBox(height: 32),
                    Center(
                      child: Column(
                        children: [
                          const Text("Comparte esta nota", style: AppTypography.headline02),
                          const SizedBox(height: 12),
                          AppButton(
                            label: "Compartir",
                            onPressed: () {
                              final url = 'https://sermanos.app/novedad/${novedad.id}';
                              final text = '${novedad.titulo}\n\n${novedad.resumen}\n\n$url';
                              Share.share(text);
                            },
                            type: AppButtonType.filled,
                          ),
                        ],
                      ),
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
