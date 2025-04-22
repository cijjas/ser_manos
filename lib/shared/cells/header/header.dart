
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

import '../../atoms/symbols/app_wordmark.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../molecules/tabs/tab.dart';

class AppHeader extends StatelessWidget {
  final Widget body;
  final int selectedIndex;

  const AppHeader({
    super.key,
    this.selectedIndex = 0,
    this.body = const SizedBox(),
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StatusBar(style: StatusBarStyle.blue, timeText: '', showPlaceHolders: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
            width: double.infinity,
            height: 41,
            color: AppColors.secondary90,
            child: const AppWordmark(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTab(label: "Postularse", onTap: () => debugPrint('Postularse tapped'), isSelected: selectedIndex == 0),
              ),
              Expanded(
                child: AppTab(label: "Mi perfil", onTap: () => debugPrint('Mi perfil tapped'), isSelected: selectedIndex == 1),
              ),
              Expanded(
                child: AppTab(label: "Novedades", onTap: () => debugPrint('Novedades tapped'), isSelected: selectedIndex == 2),
              ),
            ],
          ),
            Expanded(child:
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                color: AppColors.secondary10,
                child: body,
              ),
            ),
        ],
      )
    );
  }
}