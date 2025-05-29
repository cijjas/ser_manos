import 'package:flutter/material.dart';
import 'package:ser_manos/shared/atoms/icons/_app_icon.dart';
import 'package:ser_manos/shared/atoms/icons/app_icons.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

import '../../molecules/status_bar/status_bar.dart';

class AppHeaderModal extends StatelessWidget {

  const AppHeaderModal({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(
          style: StatusBarStyle.light),
      body: IntrinsicHeight(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          width: double.infinity,
          color: AppColors.neutral0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => print("test"),
                  child: const AppIcon(icon: AppIcons.CERRAR, overrideColor: AppColors.neutral100,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}