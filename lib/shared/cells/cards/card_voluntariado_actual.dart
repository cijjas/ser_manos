import 'package:flutter/material.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';

import '../../atoms/icons/app_icons.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

// TODO check what to do with the widget state
class CardVoluntariadoActual extends CardVoluntariado {

  const CardVoluntariadoActual({
    super.key,
    required Voluntariado voluntariado,
    required VoidCallback? onTap,
  }) : super(
    voluntariado: voluntariado,
    onTap: onTap,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      decoration: BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border6,
        boxShadow: AppShadows.shadow2,
        border: Border.all(
          color: AppColors.primary100,
          width: 2.0
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(voluntariado.tipo.toUpperCase(), style: AppTypography.caption),
                          Text(voluntariado.nombre, style: AppTypography.subtitle01)
                        ],
                      )
                    ]
                ),
                const Row(
                  spacing: 16,
                  children: [
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