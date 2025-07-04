import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../models/voluntariado.dart';
import '../../../constants/app_icons.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

class CardVoluntariado extends StatelessWidget {
  final VoidCallback? onTap;
  final void Function(String id)? onLikeTap;
  final Voluntariado voluntariado;
  final bool isLiked;

  const CardVoluntariado({
    super.key,
    required this.voluntariado,
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
              voluntariado.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                FirebaseCrashlytics.instance.recordError(
                  error,
                  stackTrace,
                  reason: 'Failed to load voluntariado card image',
                  information: [
                    'Voluntariado ID: ${voluntariado.id}',
                    'Image URL: ${voluntariado.imageUrl}'
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(voluntariado.tipo.toUpperCase(),
                        style: AppTypography.overline),
                    Text(voluntariado.nombre, style: AppTypography.subtitle01),
                    const SizedBox(height: 4),
                    VacantsDisplay(number: voluntariado.vacantes),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (onLikeTap != null) {
                            onLikeTap!(voluntariado.id);
                          }
                        },
                        child: AppIcon(
                          icon: isLiked ? AppIcons.favorito : AppIcons.favoritoOutline,
                          size: 24,
                          color: AppIconsColor.primary,
                        )),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                          voluntariado.location.latitude,
                          voluntariado.location.longitude,
                        );
                      },
                      child: const AppIcon(
                        icon: AppIcons.ubicacion,
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
