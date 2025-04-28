
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                child: AppTab(
                  label: 'Postularse',
                  isSelected: selectedIndex == 0,
                  onTap: () => context.go('/home/postularse'),
                ),
              ),
              Expanded(
                child: AppTab(
                  label: 'Mi perfil',
                  isSelected: selectedIndex == 1,
                  onTap: () => context.go('/home/perfil'),
                ),
              ),
              Expanded(
                child: AppTab(
                  label: 'Novedades',
                  isSelected: selectedIndex == 2,
                  onTap: () => context.go('/home/novedades'),
                ),
              ),
            ],

          ),
            Expanded(child:
              Container(
                color: AppColors.secondary10,
                child: body,
              ),
            ),
        ],
      )
    );
  }
}