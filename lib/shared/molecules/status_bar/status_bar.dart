import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../tokens/colors.dart';

enum StatusBarStyle { blue, light, dark }

class StatusBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusBar({
    super.key,
    this.style = StatusBarStyle.light,
    this.hasShadow = false,
  });

  final StatusBarStyle style;
  final bool hasShadow;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final (bg, overlayStyle) = switch (style) {
      StatusBarStyle.blue => (
      AppColors.secondary90,
      SystemUiOverlayStyle.light,
      ),
      StatusBarStyle.light => (
      AppColors.neutral0,
      SystemUiOverlayStyle.dark,
      ),
      StatusBarStyle.dark => (
      AppColors.negro,
      SystemUiOverlayStyle.light,
      ),
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Container(
        width: double.infinity,
        height: preferredSize.height,
        decoration: BoxDecoration(
          color: bg,
          boxShadow: hasShadow
              ? [
            const BoxShadow(
              color: AppColors.negro, // stronger
              blurRadius: 20,                        // more blur
              spreadRadius: 20,                       // extend further
              offset: Offset(0, 0),            // push lower
            ),
          ]
              : null,
        ),
      ),
    );
  }
}
