import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';

import '../../../models/voluntariado.dart';
import '../../atoms/icons/app_icons.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

// TODO check what to do with the widget state
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
            child: Image.network(voluntariado.imageUrl, fit: BoxFit.cover),
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
                        style: AppTypography.caption),
                    const SizedBox(height: 4),
                    Text(voluntariado.nombre, style: AppTypography.subtitle01),
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
                          icon: isLiked ? AppIcons.FAVORITO : AppIcons.FAVORITO_OUTLINE,
                          size: 24,
                          color: AppIconsColor.PRIMARY,
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
                        icon: AppIcons.UBICACION,
                        size: 24,
                        color: AppIconsColor.PRIMARY,
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
