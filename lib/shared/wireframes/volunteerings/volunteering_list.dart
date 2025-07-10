import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/app_routes.dart';
import '../../../models/user.dart';
import '../../../models/volunteering.dart';
import '../../../utils/app_strings.dart';
import '../../cells/cards/volunteering_card.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';

class VolunteeringListItems extends ConsumerWidget {
  final List<Volunteering> volunteerings;
  final void Function(String id)? onLikeTap;
  final User? user;
  final bool isSearching;

  const VolunteeringListItems({
    super.key,
    required this.volunteerings,
    required this.user,
    this.onLikeTap,
    this.isSearching = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return volunteerings.isNotEmpty
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: volunteerings
                .map(
                  (v) => Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: VolunteeringCard(
                      volunteering: v,
                      onTap: () => context.pushNamed(
                        RouteNames.volunteeringDetails,
                        pathParameters: {'id': v.id},
                      ),
                      onLikeTap:
                          onLikeTap != null ? (id) => onLikeTap!(id) : null,
                      isLiked:
                          user?.likedVolunteerings?.contains(v.id) ?? false,
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
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                isSearching
                    ? context.strings.noVolunteeringForSearch
                    : context.strings.noVolunteeringAvailable,
                style: AppTypography.subtitle01,
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
