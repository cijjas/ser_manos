import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class AppTab extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isSelected;

  const AppTab({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: MaterialButton(
        onPressed: onTap,
        color: isSelected
            ? AppColors.secondary200
            : AppColors.secondary100,
        splashColor: AppColors.neutral100.withAlpha(25),
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: isSelected
            ? const EdgeInsets.fromLTRB(6, 14.5, 6, 14.5)
            : const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: Text(
          label,
          style: AppTypography.button.copyWith(
            color: isSelected
                ? AppColors.neutral0
                : AppColors.neutral25,
          ),
        ),
      ),
    );
  }
}
