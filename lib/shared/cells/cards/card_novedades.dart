import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';
import '../../tokens/border_radius.dart';
import '../../wireframes/novedades/novedad.dart';

class CardNovedades extends StatelessWidget {
  final Novedad novedad;

  const CardNovedades({super.key, required this.novedad});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      decoration: const BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: AppBorderRadius.border2,
        boxShadow: AppShadows.shadow2,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 118,
            height: 156,
            child: Image.network(novedad.imgUrl, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(novedad.type.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.neutral75,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(novedad.name,
                      style: AppTypography.subtitle01,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(novedad.description,
                      style: AppTypography.body02.copyWith(
                        color: AppColors.neutral75,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => context.push('/novedad', extra: novedad),
                      child: Text(
                        'Leer Más',
                        style: AppTypography.button.copyWith(
                          color: AppColors.primary100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
