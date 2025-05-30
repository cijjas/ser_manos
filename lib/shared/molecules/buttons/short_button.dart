import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

enum ShortButtonVariant { regular, compact }

class ShortButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ShortButtonVariant variant;
  final bool isLoading; // ← NUEVO

  const ShortButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.variant = ShortButtonVariant.regular,
    this.isLoading = false, // ← DEFAULT false
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    final EdgeInsets padding = variant == ShortButtonVariant.compact
        ? const EdgeInsets.symmetric(horizontal: 12)
        : const EdgeInsets.symmetric(horizontal: 16);

    final Color backgroundColor =
    isDisabled ? AppColors.neutral25 : AppColors.primary100;
    final Color foregroundColor =
    isDisabled ? AppColors.neutral50 : AppColors.neutral0;

    Widget child;

    if (isLoading) {
      child = const SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.neutral0),
        ),
      );
    } else {
      final children = <Widget>[];
      if (icon != null) {
        children.add(Icon(icon, size: 20, color: foregroundColor));
        children.add(const SizedBox(width: 8));
      }
      children.add(Text(
        label,
        style: AppTypography.button.copyWith(color: foregroundColor),
      ));

      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      );
    }

    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(0, 36)),
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
      child: child,
    );
  }
}
