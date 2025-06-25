import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Ensure these import paths are correct for your project
import '../../../providers/voluntariado_provider.dart';
import '../../cells/cards/card_voluntariado.dart';
import '../../molecules/buttons/floating_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

/// Displays the map background.
/// In a real app, this would be an actual map widget.
class VoluntariadoMapBackground extends StatelessWidget {
  const VoluntariadoMapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        'assets/images/map_placeholder.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class MapViewCardsOverlay extends ConsumerWidget {
  const MapViewCardsOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadosAsync = ref.watch(voluntariadosProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end, // Align children to the bottom
      crossAxisAlignment: CrossAxisAlignment.end, // Align children to the right horizontally
      children: [
        // Button positioned above the carousel
        Padding(
          padding: const EdgeInsets.only(right: 24.0, bottom: 16.0), // Match carousel right padding and add bottom padding
          child: AppFloatingButton(
            icon: Icons.navigation, // Replace with your desired icon
            onPressed: () {
              // Add your desired functionality here, e.g., navigating to a new screen
            },
          ),
        ),
        // Spacer to push the button and carousel to the bottom if needed,
        // though `MainAxisAlignment.end` often handles this.
        // const Spacer(), // Uncomment if you need more precise vertical control

        // The carousel content
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              height: 240, // Slightly taller to allow shadow rendering
              child: voluntariadosAsync.when(
                data: (voluntariados) => voluntariados.isNotEmpty
                    ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: voluntariados.length,
                  clipBehavior: Clip.none, // Important: allow overflow for shadows
                  padding: const EdgeInsets.symmetric(horizontal: 24), // match list view padding
                  itemBuilder: (context, index) {
                    final voluntariado = voluntariados[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16), // match bottom list spacing
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 330,
                          maxWidth: 330, // fixed width same as list view
                        ),
                        child: CardVoluntariado(
                          voluntariado: voluntariado,
                          onTap: () => context.go('/voluntariado', extra: voluntariado.id),
                        ),
                      ),
                    );
                  },
                )
                    : const _MapViewEmptyState(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Error: $e', textAlign: TextAlign.center),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MapViewEmptyState extends StatelessWidget {
  const _MapViewEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.neutral0.withOpacity(0.9),
          borderRadius: AppBorderRadius.border4,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          "No hay voluntariados para mostrar en el mapa.",
          style: AppTypography.subtitle01,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}