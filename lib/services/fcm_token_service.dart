import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> saveFcmTokenToFirestore(String userId) async {
  try {
    // Get the FCM token for the current device
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      // Update the user's document in Firestore with the new token
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': fcmToken,
      });
      print('FCM token saved successfully for user: $userId');
    } else {
      print('FCM token is null. Cannot save to Firestore.');
    }
  } catch (e, stack) {
    // Log any errors to Crashlytics
    FirebaseCrashlytics.instance.recordError(
      e,
      stack,
      reason: '-> Failed to save FCM token to Firestore',
      fatal: false,
    );
    print('Error saving FCM token: $e');
  }
}