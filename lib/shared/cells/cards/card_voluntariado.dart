import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final Voluntariado voluntariado;


  const CardVoluntariado({
    super.key,
    required this.voluntariado,
    this.onTap,
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
                    Text(voluntariado.tipo.toUpperCase(), style: AppTypography.caption),
                    const SizedBox(height: 4),
                    Text(voluntariado.nombre, style: AppTypography.subtitle01),
                    VacantsDisplay(number: voluntariado.vacantes),

                  ],
                ),
                Row(
                  children: [
                    const AppIcon(
                      icon: AppIcons.FAVORITO_OUTLINE,
                      size: 24,
                      color: AppIconsColor.PRIMARY,
                    ),
                    const SizedBox(width: 16),
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
