  import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
  import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
  import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
  import 'package:ser_manos/shared/tokens/border_radius.dart';

  import '../../molecules/input/search_field.dart';
  import '../../tokens/colors.dart';
  import '../../tokens/typography.dart';
  import 'voluntariado.dart';


  class HomePage extends StatelessWidget {
    final List<Voluntariado> voluntariados = [
      const Voluntariado(
        type: "ACCIÓN SOCIAL",
        name: "Título 1",
        description: "Descripción 1",
        imageUrl: "https://picsum.photos/id/1011/600/400",
        vacants: 3,
        position: LatLng(-34.5628, -58.4562),   // Belgrano (Av. Cabildo y Juramento)
      ),
      const Voluntariado(
        type: "ACCIÓN SOCIAL",
        name: "Título 2",
        description: "Descripción 2",
        imageUrl: "https://picsum.photos/id/1005/600/400",
        vacants: 5,
        position: LatLng(-34.6037, -58.3816),   // Plaza de Mayo / Microcentro
      ),
      const Voluntariado(
        type: "MEDIO AMBIENTE",
        name: "Título 3",
        description: "Descripción 3",
        imageUrl: "https://picsum.photos/id/1028/600/400",
        vacants: 8,
        position: LatLng(-34.5869, -58.4306),   // Parque Tres de Febrero (Palermo)
      ),
      const Voluntariado(
        type: "SALUD",
        name: "Título 4",
        description: "Descripción 4",
        imageUrl: "https://picsum.photos/id/1035/600/400",
        vacants: 4,
        position: LatLng(-34.6158, -58.5033),   // Hospital Santojanni (Mataderos)
      ),
    ];

    HomePage({super.key});

    @override
    Widget build(BuildContext context) {
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
                // filter your list…
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
            if (voluntariados.isNotEmpty)
              ...voluntariados.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CardVoluntariado(
                  type: v.type,
                  name: v.name,
                  imgUrl: v.imageUrl,
                  onTap: () => context.go('/voluntariado', extra: v),
                ),
              ))
            else
              Container(
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
          ],
        ),
      );
    }
  }