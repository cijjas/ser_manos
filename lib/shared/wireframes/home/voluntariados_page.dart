// voluntariados_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

// Ensure these import paths match your project structure.
// These files will contain the refactored/new widgets.
import 'package:ser_manos/shared/wireframes/home/voluntariado_list.dart';

import '../../../providers/voluntariado_provider.dart';
import '../../../services/auth_service.dart';
import '../../cells/cards/card_voluntariado_actual.dart';
import '../../molecules/input/search_field.dart';
import '../../../providers/home_providers.dart';

// It's good practice for pages to not directly depend on specific data providers
// if child widgets handle their own data fetching (like MapViewCardsOverlay & VoluntariadoListItems do).
// import '../../../providers/voluntariado_provider.dart';
import '../../tokens/typography.dart';
import '../../atoms/icons/_app_icon.dart';
import '../../atoms/icons/app_icons.dart';
import 'voluntariado_map_background.dart';

// Import AppColors if needed for SearchField background or text color adjustments
// import '../../tokens/colors.dart';

class VoluntariadosPage extends ConsumerWidget {
  const VoluntariadosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMapView = ref.watch(isMapViewProvider);
    final participatingVoluntariado =
        ref.watch(voluntariadoParticipatingProvider);


    final voluntariadosAsync = ref.watch(voluntariadosProvider);

    // Common UI: SearchField and Title section
    Widget searchAndTitleSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        SearchField(
          hintText: 'Buscar',
          emptySuffix: AppIcon(
            icon: isMapView ? AppIcons.LISTA : AppIcons.MAPA,
            color: AppIconsColor.PRIMARY,
          ),
          onEmptySuffixTap: () {
            ref.read(isMapViewProvider.notifier).state = !isMapView;
          },
          onChanged: (query) {
            // Hook up your search logic here
          },
        ),
        // const SizedBox(height: 32),
        // if (!isMapView) ...[
        //   // if (ref.watch(voluntariadoParticipatingListProvider).isNotEmpty) ...[
        //   //   const Text(
        //   //     "Tu actividad",
        //   //     style: AppTypography.headline01,
        //   //   ),
        //   //   const SizedBox(height: 16),
        //   // ],
        //   // const Text(
        //   //   "Voluntariados",
        //   //   style: AppTypography.headline01,
        //   // ),
        //   const SizedBox(height: 16),
        // ],
      ],
    );

    return Scaffold(
      // Ensures that the map background can go edge-to-edge if desired
      // backgroundColor: isMapView ? Colors.transparent : Theme.of(context).scaffoldBackgroundColor,
      backgroundColor: AppColors.secondary10,
      body: Stack(
        children: [
          // Layer 1: Map Background (only in map view)
          if (isMapView)
            const Positioned.fill(
              // Ensures the background fills the entire Stack
              child: VoluntariadoMapBackground(), // From voluntariado_map.dart
            ),

          // Layer 2: Content (Search, Title, and conditional list/map-cards)
          SafeArea(
            // Ensures content avoids notches and system UI
            child: Padding(
              // Overall padding for the content area
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16), // Top padding within SafeArea
                  searchAndTitleSection,
                  Expanded(
                      child: isMapView
                          // In Map View: Show the overlay cards at the bottom
                          ? const MapViewCardsOverlay() // From voluntariado_map.dart
                          // In List View: Show the scrollable list of items
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  participatingVoluntariado.when(
                                    data: (voluntariado) {
                                      print(voluntariado);
                                      if (voluntariado == null) {
                                        return const SizedBox(); // or another placeholder
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Tu actividad",
                                            style: AppTypography.headline01,
                                          ),
                                          const SizedBox(height: 16),
                                          SingleChildScrollView(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            child: CardVoluntariadoActual(
                                              voluntariado: voluntariado,
                                              onTap: () => context.push(
                                                  '/voluntariado',
                                                  extra: voluntariado.id),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                    error: (e, _) => VoluntariadoError(
                                        message:
                                            "Error al cargar tu actividad." +
                                                e.toString()),
                                    loading: () => const VoluntariadoLoading(),
                                  ),
                                  const Text(
                                    "Voluntariados",
                                    style: AppTypography.headline01,
                                  ),
                                  SizedBox(height: 16),
                                  voluntariadosAsync.when(
                                      data: (voluntariados) => Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 16),
                                            // Padding at the end of the scroll
                                            child: VoluntariadoListItems(
                                              voluntariados: voluntariados,
                                            ), // From voluntariado_list.dart
                                          ),
                                      error: (e, _) => const VoluntariadoError(
                                          message:
                                              "Error al cargar tu actividad."),
                                      loading: () =>
                                          const VoluntariadoLoading()),
                                ],
                              ),
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VoluntariadoError extends StatelessWidget {
  final String message;

  const VoluntariadoError({
    super.key,
    this.message = 'Error al cargar los voluntariados.',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0),
      child: Center(
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

class VoluntariadoLoading extends StatelessWidget {
  const VoluntariadoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 64.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
