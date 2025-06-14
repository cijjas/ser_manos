// lib/services/notification_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (resp) =>
          _handlePayload(resp.payload),
    );

    const channel = AndroidNotificationChannel(
      'high_importance', 'High Importance',
      description: 'Notificaciones críticas',
      importance: Importance.high,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> show(RemoteMessage msg) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const android = AndroidNotificationDetails(
      'high_importance',
      'High Importance',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();

    await _plugin.show(
      id,
      msg.notification?.title,
      msg.notification?.body,
      const NotificationDetails(android: android, iOS: ios),
      payload: jsonEncode(msg.data),
    );
  }


  /// despachador de deep links
  static void _handlePayload(String? payload) {
    if (payload == null) return;
    final data = jsonDecode(payload);
    _routeFromData(data);
  }

  static void handleRemoteMessage(RemoteMessage msg) =>
      _routeFromData(msg.data);

  static void _routeFromData(Map<String, dynamic> data) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final r = GoRouter.of(context);

    switch (data['type']) {
      case 'postulation_status':
        r.push('/voluntariado/${data['voluntariadoId']}');
        break;
      case 'news':
        r.push('/noticia/${data['newsId']}');
        break;
    }
  }
}
