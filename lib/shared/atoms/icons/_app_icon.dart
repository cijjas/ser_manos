// _icon_variation.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../tokens/colors.dart';
import 'app_icons.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final AppIconsColor color;
  final AppIcons icon;

  const AppIcon({
    super.key,
    required this.icon,
    this.color = AppIconsColor.DEFAULT,
    this.size = 24,
  });

  // EXAMPLE USAGE: AppIcon(icon: AppIcons.MOSTRAR, color: AppIconsColor.PRIMARY)

  @override
  Widget build(BuildContext context) {
    final Color iconColor;
    switch (color) {
      case AppIconsColor.PRIMARY:
        iconColor = AppColors.primary100;
        break;
      case AppIconsColor.SECONDARY:
        iconColor = AppColors.secondary200;
        break;
      case AppIconsColor.SECONDARY_DISABLED:
        iconColor = AppColors.secondary80;
        break;
      case AppIconsColor.DISABLED:
        iconColor = AppColors.neutral25;
        break;
      default:
        iconColor = AppColors.neutral0;
    }

    return Icon(
      icon.iconData,
      color: iconColor,
      size: size,
    );
  }
}