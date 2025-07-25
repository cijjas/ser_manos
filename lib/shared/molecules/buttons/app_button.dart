import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

enum AppButtonType { filled, tonal }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Color? textColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.filled,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    final Color bgColor = switch (type) {
      AppButtonType.filled => isDisabled ? AppColors.neutral25 : AppColors.primary100,
      AppButtonType.tonal  => isDisabled ? AppColors.neutral0  : Colors.transparent,
    };

    final Color fgColor = textColor
        ?? (isDisabled
            ? AppColors.neutral50
            : (type == AppButtonType.filled ? AppColors.neutral0 : AppColors.primary100));

    final Color rippleColor = switch (type) {
      AppButtonType.filled => AppColors.neutral10.withValues(alpha: 0.1),
      AppButtonType.tonal  => AppColors.neutral25,
    };

    final ButtonStyle style = ButtonStyle(
      padding: WidgetStateProperty.all(
        const EdgeInsets.fromLTRB(8, 12, 8, 12),
      ),
      backgroundColor: WidgetStateProperty.all(bgColor),
      foregroundColor: WidgetStateProperty.all(fgColor),
      textStyle: WidgetStateProperty.all(AppTypography.button),
      overlayColor: WidgetStateProperty.all(rippleColor),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: style,
        child: isLoading
            ? const SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.neutral0,
          ),
        )
            : Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
