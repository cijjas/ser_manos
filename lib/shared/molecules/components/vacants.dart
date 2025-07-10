import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';

import '../../../constants/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class VacantsDisplay extends StatelessWidget {
  final int number;

  const VacantsDisplay({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    final bool hayVacantes = number != 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: hayVacantes ? AppColors.secondary25 : AppColors.neutral25,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.strings.vacancies_dot,
            style: AppTypography.body02,
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icon: AppIcons.person,
                size: 20,
                color: hayVacantes
                    ? AppIconsColor.secondary
                    : AppIconsColor.secondaryDisabled,
              ),
              Text(
                number.toString(),
                style: AppTypography.subtitle01.copyWith(
                  color: hayVacantes
                      ? AppColors.secondary200
                      : AppColors.secondary80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
