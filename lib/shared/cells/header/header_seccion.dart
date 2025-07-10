import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/constants/app_icons.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../molecules/status_bar/status_bar.dart';

class AppHeaderSection extends StatelessWidget {
  final String title;

  const AppHeaderSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const StatusBar(
          style: StatusBarStyle.blue,
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 40, 20),
          width: double.infinity,
          color: AppColors.secondary90,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const AppIcon(icon: AppIcons.back),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypography.subtitle01.copyWith(
                    color: AppColors.neutral0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
