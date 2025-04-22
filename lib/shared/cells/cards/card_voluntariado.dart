import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';

import '../../atoms/icons/app_icons.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

// TODO check what to do with the widget state
class CardVoluntariado extends StatelessWidget {
  final String type;
  final String name;
  final String imgUrl;

  const CardVoluntariado({
    super.key,
    required this.type,
    required this.name,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow2,
      ),
      clipBehavior: Clip.antiAlias,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 328,
            height: 138, // Set the desired height
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type.toUpperCase(), style: AppTypography.caption),
                        Text(name, style: AppTypography.subtitle01)
                      ],
                    ),
                    const VacantsDisplay(initialNumber: 10),
                  ]
                ),
                const Row(
                  spacing: 16,
                  children: [
                    AppIcon(icon: AppIcons.FAVORITO_OUTLINE, size: 24, color: AppIconsColor.PRIMARY),
                    AppIcon(icon: AppIcons.UBICACION, size: 24, color: AppIconsColor.PRIMARY),
                  ],
                )
              ],
            ),
          ),
        ]
      ),
    );
  }
}