// lib/core/components/status_bar.dart
import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/typography.dart';


enum StatusBarStyle { blue, light, dark }

class StatusBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusBar({
    super.key,
    this.style = StatusBarStyle.light,
    this.timeText = '9:30',
    this.showPlaceHolders = true,
  });

  final StatusBarStyle style;
  final String timeText;
  final bool showPlaceHolders;      // show demo icons / dot

  // ───────────────────────────────────────────────────────────
  // PreferredSizeWidget → lets you drop this into Scaffold.appBar
  @override
  Size get preferredSize => const Size.fromHeight(52);
  // ───────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // Colours
    final (bg, fg) = switch (style) {
      StatusBarStyle.blue  => (AppColors.secondary90, AppColors.neutral0),
      StatusBarStyle.light => (AppColors.neutral0, AppColors.neutral100),
      StatusBarStyle.dark  => (AppColors.neutral100, AppColors.neutral0),
    };

    return Container(
      width: double.infinity,
      height: preferredSize.height,
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      color: bg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time (left)
          Text(
            timeText,
            style: AppTypography.button.copyWith(color: fg),
          ),

          // Demo “notch” dot (centre) – optional
          if (showPlaceHolders)
            Container(width: 24, height: 24, decoration: BoxDecoration(
              color: fg, shape: BoxShape.circle,
            )),

          // Placeholder icons (right) – optional
          if (showPlaceHolders)
            Row(
              children: [
                Icon(Icons.network_wifi, color: fg, size: 20),
                const SizedBox(width: 4),
                Icon(Icons.signal_cellular_alt, color: fg, size: 20),
                const SizedBox(width: 4),
                Icon(Icons.battery_4_bar, color: fg, size: 20),
              ],
            ),
        ],
      ),
    );
  }
}