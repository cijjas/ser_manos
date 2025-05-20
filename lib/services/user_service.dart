import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../models/user.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(User user) async {
    try {
      await _users.doc(user.id).set(user.toJson());
      FirebaseAnalytics.instance.logEvent(
        name: 'user_creation_success',
        parameters: {'source': 'UserService'},
      );
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to create user document in Firestore',
        fatal: false,
      );
      FirebaseAnalytics.instance.logEvent(
        name: 'user_creation_failed',
        parameters: {'source': 'UserService'},
      );
      rethrow;
    }
  }

  Future<User?> getUser(String id) async {
    final doc = await _users.doc(id).get();
    if (!doc.exists) return null;
    return User.fromJson(doc.data()!);
  }

  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((doc) => doc.exists).map(
          (doc) => User.fromJson(doc.data()!),
        );
  }
}
