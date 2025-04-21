// _icon_variation.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // TODO change color from onSurface to ??
    final Color iconColor;
    switch (color) {
      case AppIconsColor.PRIMARY:
        iconColor = colorScheme.primary;
        break;
      case AppIconsColor.SECONDARY:
        iconColor = colorScheme.secondary;
        break;
      case AppIconsColor.SECONDARY_DISABLED:
        iconColor = colorScheme.onSecondaryFixed;
        break;
      case AppIconsColor.DISABLED:
        iconColor = colorScheme.onSurface.withOpacity(0.38);
        break;
      default:
        iconColor = colorScheme.onSurface;
    }

    return Icon(
      icon.iconData,
      color: iconColor,
      size: size,
    );
  }
}