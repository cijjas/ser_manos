// voluntariados_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

// Ensure these import paths match your project structure.
// These files will contain the refactored/new widgets.
import 'package:ser_manos/shared/wireframes/home/voluntariado_list.dart';

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
        const SizedBox(height: 32),
        if (!isMapView) ...[
          const Text(
            "Voluntariados",
            style: AppTypography.headline01,
          ),
          const SizedBox(height: 16),
        ],
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
            const Positioned.fill( // Ensures the background fills the entire Stack
              child: VoluntariadoMapBackground(), // From voluntariado_map.dart
            ),

          // Layer 2: Content (Search, Title, and conditional list/map-cards)
          SafeArea( // Ensures content avoids notches and system UI
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
                        : const SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 16), // Padding at the end of the scroll
                      child: VoluntariadoListItems(), // From voluntariado_list.dart
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