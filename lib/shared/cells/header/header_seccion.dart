import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/tokens/typography.dart';

import '../../molecules/status_bar/status_bar.dart';

class AppHeaderSection extends StatelessWidget {
  final String title;

  const AppHeaderSection({
    super.key,
    required this.title,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(
          style: StatusBarStyle.blue, timeText: '', showPlaceHolders: false),
      body: IntrinsicHeight(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(16, 20, 40, 20),
          width: double.infinity,
          color: AppColors.secondary90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => print("test"),
                  child: const AppIcon(icon: AppIcons.ATRAS),
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  // Ensures the text is centered within the Expanded widget
                  style: AppTypography.subtitle01.copyWith(
                      color: AppColors.neutral0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}