import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/constants/app_routes.dart';
import 'package:ser_manos/shared/tokens/colors.dart';

import '../../atoms/symbols/app_wordmark.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../molecules/tabs/tab.dart';

class AppHeader extends StatefulWidget {
  final Widget body;
  final int selectedIndex;

  const AppHeader({
    super.key,
    this.selectedIndex = 0,
    this.body = const SizedBox(),
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  int? _lastIndex;

  @override
  void didUpdateWidget(AppHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != _lastIndex) {
      _lastIndex = widget.selectedIndex;

      final screenName = switch (widget.selectedIndex) {
        0 => RouteNames.volunteeringTab,
        1 => RouteNames.profileTab,
        2 => RouteNames.newsTab,
        _ => RouteNames.unknownTab,
      };

      FirebaseAnalytics.instance
          .logScreenView(screenName: screenName, screenClass: screenName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondary10,
        appBar: const StatusBar(style: StatusBarStyle.blue),
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
                    isSelected: widget.selectedIndex == 0,
                    onTap: () => context.go(AppRoutes.homeVolunteering),
                  ),
                ),
                Expanded(
                  child: AppTab(
                    label: 'Mi perfil',
                    isSelected: widget.selectedIndex == 1,
                    onTap: () => context.go(AppRoutes.homeProfile),
                  ),
                ),
                Expanded(
                  child: AppTab(
                    label: 'Novedades',
                    isSelected: widget.selectedIndex == 2,
                    onTap: () => context.go(AppRoutes.homeNews),
                  ),
                ),
              ],
            ),
            Expanded(
              child: KeyedSubtree(
                key: ValueKey(widget.selectedIndex),
                child: widget.body,
              ),
            ),
          ],
        ));
  }
}
