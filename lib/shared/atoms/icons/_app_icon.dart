import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../../constants/app_icons.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final AppIconsColor color;
  final AppIcons icon;
  final Color? overrideColor;

  const AppIcon({
    super.key,
    required this.icon,
    this.color = AppIconsColor.defaultColor,
    this.size = 24,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = overrideColor ?? _getColorFromEnum(color);

    return Icon(
      icon.iconData,
      color: iconColor,
      size: size,
    );
  }

  Color _getColorFromEnum(AppIconsColor color) {
    switch (color) {
      case AppIconsColor.primary:
        return AppColors.primary100;
      case AppIconsColor.secondary:
        return AppColors.secondary200;
      case AppIconsColor.secondaryDisabled:
        return AppColors.secondary80;
      case AppIconsColor.disabled:
        return AppColors.neutral25;
      case AppIconsColor.neutral75:
        return AppColors.neutral75;
      default:
        return AppColors.neutral0;
    }
  }
}