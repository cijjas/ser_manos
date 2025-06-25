import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> saveFcmTokenToFirestore(String userId) async {
  try {
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': fcmToken,
      });
    } else {
    }
  } catch (e, stack) {
    FirebaseCrashlytics.instance.recordError(
      e,
      stack,
      reason: '-> Failed to save FCM token to Firestore',
      fatal: false,
    );
  }
}