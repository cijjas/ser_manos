import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

enum AppButtonType { filled, tonal }
enum AppButtonWidthType { fixed, hug }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool fillWidth;
  final AppButtonWidthType widthType;
  final Color? textColor;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.filled,
    this.fillWidth = false,
    this.widthType = AppButtonWidthType.fixed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    final Color bgColor = switch (type) {
      AppButtonType.filled => isDisabled ? AppColors.neutral25 : AppColors.primary100,
      AppButtonType.tonal  => isDisabled ? AppColors.neutral0  : Colors.transparent,
    };

    final Color fgColor = textColor
        ?? (isDisabled
            ? AppColors.neutral50
            : (type == AppButtonType.filled ? AppColors.neutral0 : AppColors.primary100));

    final Color rippleColor = switch (type) {
      AppButtonType.filled => AppColors.neutral10.withOpacity(0.1),
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

    final double? maxButtonWidth = switch (widthType) {
      AppButtonWidthType.fixed => 328,
      AppButtonWidthType.hug => null,
    };

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxButtonWidth ?? double.infinity,
      ),
      child: SizedBox(
        width: fillWidth ? double.infinity : null,
        child: TextButton(
          onPressed: onPressed,
          style: style,
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}