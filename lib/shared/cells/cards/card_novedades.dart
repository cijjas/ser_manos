import 'package:flutter/material.dart';
import 'package:ser_manos/shared/tokens/border_radius.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';

class CardNovedades extends StatelessWidget {
  final String type;
  final String name;
  final String description;
  final String imgUrl;

  const CardNovedades({
    super.key,
    required this.type,
    required this.name,
    required this.description,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow2,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Image
          SizedBox(
            width: 118,
            height: 156,
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Right side: Texts and Button
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,    // <-- important!!
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.toUpperCase(),
                    style: AppTypography.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    style: AppTypography.subtitle01,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTypography.body02,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12), // <-- instead of Spacer()
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppButton(
                      label: 'Leer más',
                      onPressed: () => debugPrint('Leer más tapped'),
                      type: AppButtonType.tonal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}