import 'package:flutter/material.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/cells/cards/card_voluntariado.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Row(
                  spacing: 16,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final lat = voluntariado.location.latitude;
                        final lng = voluntariado.location.longitude;
                        final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No se pudo abrir Google Maps')),
                          );
                        }
                      },
                      child: const AppIcon(
                        icon: AppIcons.UBICACION,
                        size: 24,
                        color: AppIconsColor.PRIMARY,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ]
      ),
    );
    return onTap == null ? card : GestureDetector(onTap: onTap, child: card);
  }
}