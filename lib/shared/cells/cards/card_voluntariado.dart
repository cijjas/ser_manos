import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';

import '../../atoms/icons/app_icons.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/shadow.dart';

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
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
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
              fit: BoxFit.fill,
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
                        Text(type.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
                        Text(name, style: Theme.of(context).textTheme.titleMedium)
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