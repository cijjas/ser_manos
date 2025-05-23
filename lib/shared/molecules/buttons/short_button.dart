// lib/shared/molecules/buttons/short_button.dart

import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

enum ShortButtonVariant { regular, compact }

class ShortButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ShortButtonVariant variant;

  const ShortButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.variant = ShortButtonVariant.regular,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    // Sólo padding horizontal; la altura la controla minimumSize
    final EdgeInsets padding = variant == ShortButtonVariant.compact
        ? const EdgeInsets.symmetric(horizontal: 12)
        : const EdgeInsets.symmetric(horizontal: 16);

    final Color backgroundColor =
    isDisabled ? AppColors.neutral25 : AppColors.primary100;
    final Color foregroundColor =
    isDisabled ? AppColors.neutral50 : AppColors.neutral0;

    // Construimos el contenido (icon opcional + texto)
    final children = <Widget>[];
    if (icon != null) {
      children.add(Icon(icon, size: 20, color: foregroundColor));
      children.add(const SizedBox(width: 8));
    }
    children.add(Text(
      label,
      style: AppTypography.button.copyWith(color: foregroundColor),
    ));

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        // Fijamos altura mínima de 36px
        minimumSize: MaterialStateProperty.all(const Size(0, 36)),
        padding: MaterialStateProperty.all(padding),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.all(
          AppColors.neutral10.withOpacity(0.1),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
