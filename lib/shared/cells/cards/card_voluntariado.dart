import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final VoidCallback? onTap;            // NEW (optional)

  const CardVoluntariado({
    super.key,
    required this.type,
    required this.name,
    required this.imgUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: 328,
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
            width: 328,
            height: 138,
            child: Image.network(imgUrl, fit: BoxFit.cover),
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
                    Text(type.toUpperCase(), style: AppTypography.caption),
                    const SizedBox(height: 4),
                    Text(name, style: AppTypography.subtitle01),
                    const VacantsDisplay(initialNumber: 10),
                  ],
                ),
                const Row(
                  children: [
                    AppIcon(icon: AppIcons.FAVORITO_OUTLINE, size: 24, color: AppIconsColor.PRIMARY),
                    SizedBox(width: 16),
                    AppIcon(icon: AppIcons.UBICACION, size: 24, color: AppIconsColor.PRIMARY),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // ⬇︎ only wrap with GestureDetector if an onTap is supplied
    return onTap == null ? card : GestureDetector(onTap: onTap, child: card);
  }
}