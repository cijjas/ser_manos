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
    this.isSelected = false, // Default to not selected
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0,0,0,3), // 3px white space around the button
      color: Colors.white, // White background for the margin
      child: MaterialButton(
        onPressed: onTap, // Trigger the external state change
        color: isSelected
            ? AppColors.secondary200 // Active state color
            : AppColors.secondary100, // Default color
        splashColor: AppColors.neutral100.withAlpha(25),
        elevation: 0, // Removes default shadow
        highlightElevation: 0, // Removes highlight shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: isSelected
            ? const EdgeInsets.fromLTRB(6, 14.5, 6, 14.5) // Smaller padding when selected
            : const EdgeInsets.fromLTRB(8, 16, 8, 16), // Default padding
        child: Text(
          label,
          style: AppTypography.button.copyWith(
            color: isSelected
                ? AppColors.neutral0 // Active text color
                : AppColors.neutral25, // Default text color
          ),
        ),
      ),
    );
  }
}