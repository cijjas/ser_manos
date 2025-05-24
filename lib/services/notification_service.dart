// lib/services/notification_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();   // se pasa a GoRouter

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  /// ① inicializar
  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (resp) =>
          _handlePayload(resp.payload),
    );

    // Android 13+: canal obligatorio
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

  /// ② mostrar en foreground
  static Future<void> show(RemoteMessage msg) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const android = AndroidNotificationDetails(
      'high_importance',
      'High Importance',
      importance: Importance.max,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails(); // ← Add this!

    await _plugin.show(
      id,
      msg.notification?.title,
      msg.notification?.body,
      const NotificationDetails(android: android, iOS: ios),
      payload: jsonEncode(msg.data),
    );
  }


  /// ③ despachador de deep links
  static void _handlePayload(String? payload) {
    if (payload == null) return;
    final data = jsonDecode(payload);
    _routeFromData(data);
  }

  /// ④ mismo despachador para onMessageOpenedApp
  static void handleRemoteMessage(RemoteMessage msg) =>
      _routeFromData(msg.data);

  static void _routeFromData(Map<String, dynamic> data) {
    final r = GoRouter.of(navigatorKey.currentContext!);

    switch (data['type']) {
      case 'postulation_status':   // accepted | rejected
        r.push('/voluntariado/${data['voluntariadoId']}');
        break;

      case 'news':
        r.push('/noticia/${data['newsId']}');
        break;
    }
  }
}
