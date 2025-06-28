import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_routes.dart';
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
  final bool isSearching;

  const VoluntariadoListItems({
    super.key,
    required this.voluntariados,
    required this.user,
    this.onLikeTap,
    this.isSearching = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return voluntariados.isNotEmpty
        ? Column(
      mainAxisSize: MainAxisSize.min,
      children: voluntariados
          .map(
            (v) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: CardVoluntariado(
            voluntariado: v,
            onTap: () => context.pushNamed(
              RouteNames.volunteeringDetails,
              pathParameters: {'id': v.id},
            ),
            onLikeTap: onLikeTap != null ? (id) => onLikeTap!(id) : null,
            isLiked: user?.likedVoluntariados?.contains(v.id) ?? false,
          ),
        ),
      )
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
            ),
          ],
        ),
        child: Text(
          isSearching
              ? "No hay voluntariados vigentes para tu búsqueda."
              : "Actualmente no hay voluntariados vigentes. Pronto se irán incorporando nuevos.",
          style: AppTypography.subtitle01,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
