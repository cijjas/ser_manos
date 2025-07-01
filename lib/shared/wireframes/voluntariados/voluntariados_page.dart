// voluntariados_page.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/wireframes/voluntariados/voluntariado_list.dart';
import 'package:ser_manos/utils/app_strings.dart';

import '../../../constants/app_routes.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/voluntariado_provider.dart';
import '../../cells/cards/card_voluntariado_actual.dart';
import '../../molecules/input/search_field.dart';
import '../../tokens/typography.dart';

class VoluntariadosPage extends ConsumerWidget {
  const VoluntariadosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: AppColors.secondary10,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SearchAndToggleViewHeader(),
            ),
            Expanded(
              child: SingleChildScrollView(
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
      ),
    );
  }
}

class SearchAndToggleViewHeader extends ConsumerStatefulWidget {
  const SearchAndToggleViewHeader({super.key});

  @override
  ConsumerState<SearchAndToggleViewHeader> createState() =>
      _SearchAndToggleViewHeaderState();
}

class _SearchAndToggleViewHeaderState
    extends ConsumerState<SearchAndToggleViewHeader> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(voluntariadoSearchQueryProvider.notifier).state = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField(
      hintText: context.strings.searchHint,
      onChanged: _onSearchChanged,
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
      skipLoadingOnRefresh: true,
      data: (voluntariado) {
        if (voluntariado == null) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.strings.yourActivity, style: AppTypography.headline01),
            const SizedBox(height: 16),
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: CardVoluntariadoActual(
                voluntariado: voluntariado,
                onTap: () => context.pushNamed(
                  RouteNames.volunteeringDetails,
                  pathParameters: {'id': voluntariado.id},
                ),
              ),
            ),
          ],
        );
      },
      error: (e, _) => VoluntariadoError(
          message: "Error al cargar tu actividad.\n${e.toString()}"),
      loading: () => const SizedBox(),
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
      skipLoadingOnRefresh: true,
      data: (voluntariados) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.strings.volunteering, style: AppTypography.headline01),
          const SizedBox(height: 16),
          VoluntariadoListItems(
              voluntariados: voluntariados,
              isSearching: isSearching,
              user: user,
              onLikeTap: (id) => onLikeTap(ref, id)),
          const SizedBox(height: 16),
        ],
      ),
      error: (e, _) {
        ref.invalidate(voluntariadosProvider);
        return const VoluntariadoError(
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
