import 'package:flutter/material.dart';
import '../../tokens/border_radius.dart';
import '../../tokens/colors.dart';
import '../../tokens/shadow.dart';

class AppFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const AppFloatingButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: AppBorderRadius.border4,
        boxShadow: AppShadows.shadow3,
      ),
      child: Material(
        color: isDisabled ? AppColors.neutral10 : AppColors.primary10,
        borderRadius: AppBorderRadius.border4,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppBorderRadius.border4,
          splashColor: AppColors.neutral75.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 24,
              color: isDisabled ? AppColors.neutral25 : AppColors.primary100,
            ),
          ),
        ),
      ),
    );
  }
}