import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/cells/cards/volunteering_card.dart';

import '../../../constants/app_icons.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

class CardVolunteeringActual extends VolunteeringCard {

  const CardVolunteeringActual({
    super.key,
    required super.volunteering,
    required super.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card =  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary5,
        borderRadius: AppBorderRadius.border6,
        boxShadow: AppShadows.shadow2,
        border: Border.all(
            color: AppColors.primary100,
            width: 2.0
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(volunteering.type.toUpperCase(), style: AppTypography.caption),
                          Text(
                            volunteering.name,
                            style: AppTypography.subtitle01,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final lat = volunteering.location.latitude;
                        final lng = volunteering.location.longitude;
                        MapsLauncher.launchCoordinates(lat, lng);
                      },
                      child: const AppIcon(
                        icon: AppIcons.location,
                        size: 24,
                        color: AppIconsColor.primary,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    return onTap == null ? card : GestureDetector(onTap: onTap, child: card);
  }
}
