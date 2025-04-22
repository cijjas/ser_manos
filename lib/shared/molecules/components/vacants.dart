import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';

import '../../atoms/icons/app_icons.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class VacantsDisplay extends StatefulWidget {
  final int initialNumber;

  const VacantsDisplay({
    super.key,
    required this.initialNumber,
  });

  @override
  State<VacantsDisplay> createState() => _VacantsDisplayState();
}

class _VacantsDisplayState extends State<VacantsDisplay> {
  late int number;

  @override
  void initState() {
    super.initState();
    number = widget.initialNumber; // Initialize the state with the initial number
  }

  void incrementNumber() {
    setState(() {
      number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: number != 0 ? AppColors.secondary25 : AppColors.neutral25,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Vacantes:',
            style: AppTypography.body02,
          ),
          const SizedBox(width: 8), // gap
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(icon: AppIcons.PERSONA, size: 20, color: number != 0 ? AppIconsColor.SECONDARY : AppIconsColor.SECONDARY_DISABLED),
              Text(
                number.toString(),
                style: AppTypography.subtitle01.copyWith(
                  color: number != 0 ? AppColors.secondary200 : AppColors.secondary80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}