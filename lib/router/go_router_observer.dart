import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class FirebaseAnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logScreenView(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logScreenView(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logScreenView(previousRoute);
    super.didPop(route, previousRoute);
  }

  void _logScreenView(Route<dynamic>? route) {
    if (route?.settings.name != null) {
      FirebaseAnalytics.instance.logScreenView(
        screenName: route!.settings.name,
        screenClass: route.settings.name,
      );
    }
  }
}
