// voluntariado_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/user.dart';
import '../../../models/voluntariado.dart';
import '../../cells/cards/card_voluntariado.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

class VoluntariadoListItems extends ConsumerWidget {
  final List<Voluntariado> voluntariados;
  final void Function(String id)? onLikeTap;
  final User? user;

  const VoluntariadoListItems({
    super.key,
    required this.voluntariados,
    required this.user,
    this.onLikeTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return voluntariados.isNotEmpty
          ? Column(
        mainAxisSize: MainAxisSize.min, 
        children: voluntariados
            .map((v) => Padding(
          padding: const EdgeInsets.only(bottom: 24), 
          child: CardVoluntariado(
            voluntariado: v,
            onTap: () => context.push('/voluntariado', extra: v.id),
            onLikeTap: onLikeTap != null
                ? (id) => onLikeTap!(id)
                : null,
            isLiked: user?.likedVoluntariados?.any((id) => id == v.id) ?? false,
          ),
        ))
            .toList(),
      )
          : Container( 
        alignment: Alignment.center,
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
      );
  }
}