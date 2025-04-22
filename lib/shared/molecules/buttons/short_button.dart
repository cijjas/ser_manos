import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

enum ShortButtonVariant { regular, compact }

class ShortButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final ShortButtonVariant variant;

  const ShortButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.variant = ShortButtonVariant.regular,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    final EdgeInsets padding = switch (variant) {
      ShortButtonVariant.regular => const EdgeInsets.all(12),
      ShortButtonVariant.compact =>
      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    };

    final Color backgroundColor =
    isDisabled ? AppColors.neutral25 : AppColors.primary100;

    final Color foregroundColor =
    isDisabled ? AppColors.neutral50 : AppColors.neutral0;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(padding),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        overlayColor: WidgetStateProperty.all(
          AppColors.neutral10.withOpacity(0.1),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: foregroundColor,
          ),
          const SizedBox(width: 8), // Gap 8
          Text(
            label,
            style: AppTypography.button.copyWith(color: foregroundColor),
          ),
        ],
      ),
    );
  }
}