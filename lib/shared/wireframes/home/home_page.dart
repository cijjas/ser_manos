import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';

import '../../../providers/voluntariado_provider.dart';
import '../../molecules/input/search_field.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadosAsync = ref.watch(voluntariadosProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -- Search Field --
          SearchField(
            hintText: 'Buscar',
            emptySuffix: const AppIcon(
              icon: AppIcons.MAPA,
              color: AppIconsColor.PRIMARY,
            ),
            onChanged: (query) {
              // filter logic if needed
            },
          ),
          const SizedBox(height: 32),

          // -- Title --
          const Text(
            "Voluntariados",
            style: AppTypography.headline01,
          ),
          const SizedBox(height: 16),

          // -- Cards list --
          voluntariadosAsync.when(
            data: (voluntariados) => voluntariados.isNotEmpty
                ? Column(
              children: voluntariados.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CardVoluntariado(
                  type: v.tipo,
                  name: v.nombre,
                  imgUrl: v.imageUrl,
                  onTap: () => context.go('/voluntariado', extra: v.id),
                ),
              )).toList(),
            )
                : Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.neutral0,
                borderRadius: AppBorderRadius.border4,
              ),
              child: const Text(
                "Actualmente no hay voluntariados vigentes. Pronto se irán incorporando nuevos.",
                style: AppTypography.subtitle01,
                textAlign: TextAlign.center,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}