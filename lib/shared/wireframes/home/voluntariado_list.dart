// voluntariado_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/voluntariado_provider.dart';
import '../../cells/cards/card_voluntariado.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

/// Renders only the vertical list of voluntariado cards.
/// To be used inside a scrollable parent or an Expanded widget with SingleChildScrollView.
class VoluntariadoListItems extends ConsumerWidget {
  const VoluntariadoListItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadosAsync = ref.watch(voluntariadosProvider);

    return voluntariadosAsync.when(
      data: (voluntariados) => voluntariados.isNotEmpty
          ? Column(
        mainAxisSize: MainAxisSize.min, // Take up only necessary space
        children: voluntariados
            .map((v) => Padding(
          padding: const EdgeInsets.only(bottom: 24), // Spacing between cards
          child: CardVoluntariado(
            type: v.tipo,
            name: v.nombre,
            imgUrl: v.imageUrl,
            onTap: () => context.push('/voluntariado', extra: v.id),
          ),
        ))
            .toList(),
      )
          : Container( // Message when no voluntariados are available
        alignment: Alignment.center,
        // Add substantial padding to make the message visible and centered if the list is short/empty
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.neutral0,
            borderRadius: AppBorderRadius.border4,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: const Text(
            "Actualmente no hay voluntariados vigentes. Pronto se irán incorporando nuevos.",
            style: AppTypography.subtitle01,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 64.0), // Padding for loader
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0), // Padding for error
        child: Center(child: Text('Error: $e', textAlign: TextAlign.center)),
      ),
    );
  }
}

// The original `VoluntariadoListView` class (from your third code block) should be
// removed or refactored, as its responsibilities (SearchField, Title, view switching)
// are now handled by `VoluntariadosPage`. `VoluntariadosPage` will use `VoluntariadoListItems` instead.
/*
class VoluntariadoListView extends ConsumerWidget {
  const VoluntariadoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ... original problematic content ...
  }
}
*/