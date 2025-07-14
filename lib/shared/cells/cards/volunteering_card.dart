import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../models/volunteering.dart';
import '../../../constants/app_icons.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

class VolunteeringCard extends StatelessWidget {
  final VoidCallback? onTap;
  final void Function(String id)? onLikeTap;
  final Volunteering volunteering;
  final bool isLiked;

  const VolunteeringCard({
    super.key,
    required this.volunteering,
    this.isLiked = false,
    this.onTap,
    this.onLikeTap
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow2,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 138,
            child: Image.network(
              volunteering.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                FirebaseCrashlytics.instance.recordError(
                  error,
                  stackTrace,
                  reason: 'Failed to load volunteering card image',
                  information: [
                    'Volunteering ID: ${volunteering.id}',
                    'Image URL: ${volunteering.imageUrl}'
                  ],
                  fatal: false,
                );
                return Container(
                  color: AppColors.neutral10,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(volunteering.type.toUpperCase(),
                          style: AppTypography.overline),
                      Text(
                        volunteering.name,
                        style: AppTypography.subtitle01,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      VacantsDisplay(number: volunteering.vacancies),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (onLikeTap != null) {
                            onLikeTap!(volunteering.id);
                          }
                        },
                        child: AppIcon(
                          icon: isLiked ? AppIcons.favorite : AppIcons.favoriteOutline,
                          size: 24,
                          color: AppIconsColor.primary,
                        )),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                          volunteering.location.latitude,
                          volunteering.location.longitude,
                        );
                      },
                      child: const AppIcon(
                        icon: AppIcons.location,
                        size: 24,
                        color: AppIconsColor.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return onTap == null ? card : GestureDetector(onTap: onTap, child: card);
  }
}
