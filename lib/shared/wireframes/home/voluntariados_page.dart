// voluntariados_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

// Ensure these import paths match your project structure.
// These files will contain the refactored/new widgets.
import 'package:ser_manos/shared/wireframes/home/voluntariado_list.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/voluntariado_provider.dart';
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

class VoluntariadosPage extends ConsumerWidget {
  const VoluntariadosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMapView = ref.watch(isMapViewProvider);

    return Scaffold(
      backgroundColor: AppColors.secondary10,
      body: Stack(
        children: [
          if (isMapView)
            const Positioned.fill(child: VoluntariadoMapBackground()),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: SearchAndToggleViewHeader(),
                ),
                Expanded(
                  child: isMapView
                      ? const MapViewCardsOverlay()
                      : const SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              ParticipatingVoluntariadoSection(),
                              VoluntariadosListSection(),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchAndToggleViewHeader extends ConsumerWidget {
  const SearchAndToggleViewHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMapView = ref.watch(isMapViewProvider);

    return SearchField(
      emptySuffix: const AppIcon(
        icon: AppIcons.LISTA,
        color: AppIconsColor.PRIMARY,
      ),
      // emptySuffix: const SizedBox.shrink(),
      hintText: 'Buscar',
      // Map/List
      // emptySuffix: AppIcon(
      //   icon: isMapView ? AppIcons.LISTA : AppIcons.MAPA,
      //   color: AppIconsColor.PRIMARY,
      // ),
      // onEmptySuffixTap: () {
      //   ref.read(isMapViewProvider.notifier).state = !isMapView;
      // },
      onChanged: (query) {
        ref.read(voluntariadoSearchQueryProvider.notifier).state = query;
      },
    );
  }
}

class ParticipatingVoluntariadoSection extends ConsumerWidget {
  const ParticipatingVoluntariadoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participatingVoluntariado =
        ref.watch(voluntariadoParticipatingProvider);

    return participatingVoluntariado.when(
      data: (voluntariado) {
        if (voluntariado == null) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tu actividad", style: AppTypography.headline01),
            const SizedBox(height: 16),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: CardVoluntariadoActual(
                voluntariado: voluntariado,
                onTap: () => context.push('/voluntariado/${voluntariado.id}'),
              ),
            ),
          ],
        );
      },
      error: (e, _) => VoluntariadoError(
          message: "Error al cargar tu actividad.\n${e.toString()}"),
      loading: () => const VoluntariadoLoading(),
    );
  }
}

class VoluntariadosListSection extends ConsumerWidget {
  const VoluntariadosListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadosAsync = ref.watch(voluntariadosProvider);
    final user = ref.watch(currentUserProvider).value;
    final query = ref.watch(voluntariadoSearchQueryProvider);
    final isSearching = query.trim().isNotEmpty;

    Future<void> onLikeTap(WidgetRef ref, String voluntariadoId) async {
      if (user == null) {
        return;
      }
      await ref
          .read(userServiceProvider)
          .toggleLikeVoluntariado(user, voluntariadoId);
    }

    return voluntariadosAsync.when(
      data: (voluntariados) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Voluntariados", style: AppTypography.headline01),
          const SizedBox(height: 16),
          VoluntariadoListItems(
            voluntariados: voluntariados,
            onLikeTap: (id) => onLikeTap(ref, id),
            user: user,
            isSearching: isSearching,
          ),
          const SizedBox(height: 16),
        ],
      ),
      error: (e, _) {
        ref.invalidate(voluntariadosProvider);
        return VoluntariadoError(
            message: "Error al cargar los voluntariados.");
      },
      loading: () => const VoluntariadoLoading(),
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
