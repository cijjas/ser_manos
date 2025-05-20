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

  Future<bool> setUserVoluntariadoState(
    String voluntariadoId,
    String userId,
    VoluntariadoUserState newState,
  ) async {
    try {
      final user = await getUser(userId);
      if (user == null) {
        FirebaseCrashlytics.instance.recordError(
          'User not found',
          null,
          reason: 'User with ID $userId not found',
          fatal: false,
        );
        return false;
      }

      UserVoluntariado newVoluntariado;

      // Check if user already has this voluntariado
      if (user.voluntariados != null && user.voluntariados!.isNotEmpty) {
        final existingVoluntariado = user.voluntariados!.firstWhere(
            (v) => v.id == voluntariadoId,
            orElse: () =>
                UserVoluntariado(id: voluntariadoId, estado: newState));
        newVoluntariado = existingVoluntariado.copyWith(estado: newState);
      } else {
        newVoluntariado = UserVoluntariado(
          id: voluntariadoId,
          estado: newState,
        );
      }

      final List<UserVoluntariado> updatedVoluntariados = [
        ...user.voluntariados?.where((v) => v.id != voluntariadoId) ?? [],
        newVoluntariado
      ];

      // Create an updated user with copyWith
      final updatedUser = user.copyWith(
        voluntariados: updatedVoluntariados,
      );

      // Update in Firestore
      await _users.doc(userId).update(updatedUser.toJson());
      FirebaseAnalytics.instance.logEvent(
          name: 'voluntariado_state_updated',
          parameters: {
            'voluntariadoId': voluntariadoId,
            'newState': newState.toString(),
            'userId': userId,
          }
      );

      return true;
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to update user voluntariado state in Firestore',
        fatal: false,
      );
      FirebaseAnalytics.instance.logEvent(
        name: 'voluntariado_state_update_failed',
        parameters: {
          'voluntariadoId': voluntariadoId,
          'newState': newState,
          'userId': userId,
          'error': e.toString(),
        },
      );

      return false;
    }
  }

  Future<User?> getUser(String id) async {
    final doc = await _users.doc(id).get();
    if (!doc.exists) return null;
    return User.fromJson(doc.data()!);
  }

  Future<User?> updateUser(String id, Map<String, dynamic> data) async {
    try {
      await _users.doc(id).update(data);
      return getUser(id);
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        e,
        null,
        reason: 'Failed to update user document in Firestore',
        fatal: false,
      );
      rethrow;
    }
  }

  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((doc) => doc.exists).map(
          (doc) => User.fromJson(doc.data()!),
        );
  }
}
