// _icon_variation.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../tokens/colors.dart';
import 'app_icons.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final AppIconsColor color;
  final AppIcons icon;
  final Color? overrideColor;

  const AppIcon({
    super.key,
    required this.icon,
    this.color = AppIconsColor.DEFAULT,
    this.size = 24,
    this.overrideColor,
  });

  // EXAMPLE USAGE: AppIcon(icon: AppIcons.MOSTRAR, color: AppIconsColor.PRIMARY)

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
      case AppIconsColor.PRIMARY:
        return AppColors.primary100;
      case AppIconsColor.SECONDARY:
        return AppColors.secondary200;
      case AppIconsColor.SECONDARY_DISABLED:
        return AppColors.secondary80;
      case AppIconsColor.DISABLED:
        return AppColors.neutral25;
      default:
        return AppColors.neutral0;
    }
  }
}