import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:collection/collection.dart';

import '../models/user.dart';

class UserService {
  UserService({
    FirebaseFirestore? firestore,
    FirebaseAnalytics? analytics,
    FirebaseCrashlytics? crashlytics,
  })  : _analytics = analytics ?? FirebaseAnalytics.instance,
        _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
        _users = (firestore ?? FirebaseFirestore.instance).collection('users');

  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;
  final CollectionReference<Map<String, dynamic>> _users;

  // ─────────── creación de usuario ───────────
  Future<void> createUser(User user) async {
    try {
      await _users.doc(user.id).set(user.toJson());
      _analytics.logEvent(
        name: 'user_creation_success',
        parameters: {'source': 'UserService'},
      );
    } catch (e, stack) {
      _crashlytics.recordError(
        e,
        stack,
        reason: 'Failed to create user document in Firestore',
        fatal: false,
      );
      _analytics.logEvent(
        name: 'user_creation_failed',
        parameters: {'source': 'UserService'},
      );
      rethrow;
    }
  }

  Future<bool> _setUserVolunteeringState(
    String volunteeringId,
    User user,
    VolunteeringUserState newState,
  ) async {
    try {
      UserVolunteering newVolunteering;
      if (user.volunteerings?.isNotEmpty ?? false) {
        final existing = user.volunteerings!.firstWhere(
          (v) => v.id == volunteeringId,
          orElse: () => UserVolunteering(id: volunteeringId, estado: newState),
        );
        newVolunteering = existing.copyWith(estado: newState);
      } else {
        newVolunteering =
            UserVolunteering(id: volunteeringId, estado: newState);
      }

      // lista final
      final updated = [
        ...(user.volunteerings ?? []).where((v) => v.id != volunteeringId),
        if (newState != VolunteeringUserState.available) newVolunteering,
      ];

      await _users.doc(user.id).update({
        'voluntariados': updated.map((v) => v.toJson()).toList(),
      });

      _analytics.logEvent(name: 'volunteering_state_updated', parameters: {
        'volunteeringId': volunteeringId,
        'oldState': user.volunteerings
                ?.firstWhereOrNull((v) => v.id == volunteeringId)
                ?.estado
                .toString() ??
            'not found',
        'newState': newState.toString(),
        'userId': user.id,
      });

      return true;
    } catch (e, stack) {
      _crashlytics.recordError(
        e,
        stack,
        reason: 'Failed to update user volunteering state in Firestore',
        fatal: false,
      );
      _analytics.logEvent(
        name: 'volunteering_state_update_failed',
        parameters: {
          'volunteeringId': volunteeringId,
          'newState': newState.toString(),
          'userId': user.id,
          'error': e.toString(),
        },
      );
      return false;
    }
  }

  Future<bool> postulateToVolunteering(User user, String id) async {
    if (user.volunteerings?.any((v) =>
            v.id == id &&
            v.estado != VolunteeringUserState.rejected &&
            v.estado != VolunteeringUserState.completed) ??
        false) {
      _crashlytics.recordError(
        'User already postulated',
        null,
        reason: 'User ${user.id} already postulated to $id',
        fatal: false,
      );
      return false;
    }
    return _setUserVolunteeringState(id, user, VolunteeringUserState.pending);
  }

  Future<bool> withdrawPostulation(User user, String id) async {
    final vol = user.volunteerings?.firstWhereOrNull((v) => v.id == id);
    if (vol == null || vol.estado != VolunteeringUserState.pending) {
      _crashlytics.recordError(
        'Withdraw not allowed',
        null,
        reason: 'User ${user.id} tried to withdraw but state invalid',
        fatal: false,
      );
      return false;
    }
    return _setUserVolunteeringState(id, user, VolunteeringUserState.available);
  }

  Future<bool> abandonVolunteering(User user, String id) async {
    final vol = user.volunteerings?.firstWhereOrNull((v) => v.id == id);
    if (vol == null || vol.estado != VolunteeringUserState.accepted) {
      _crashlytics.recordError(
        'Abandon not allowed',
        null,
        reason: 'User ${user.id} tried to abandon but state invalid',
        fatal: false,
      );
      return false;
    }
    return _setUserVolunteeringState(id, user, VolunteeringUserState.available);
  }

  // watchers
  Stream<UserVolunteering?> watchParticipating(String userId) {
    return _users.doc(userId).snapshots().map((doc) =>
        User.fromJson(doc.data()!).volunteerings?.firstWhereOrNull((v) =>
            v.estado == VolunteeringUserState.accepted ||
            v.estado == VolunteeringUserState.pending));
  }

  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((d) => d.exists).map(
          (d) => User.fromJson(d.data()!),
        );
  }

  // ─────────── Likes ───────────
  Future<void> toggleLikeVolunteering(User user, String id) async {
    try {
      final likes = [...user.likedVolunteerings ?? []];
      likes.contains(id) ? likes.remove(id) : likes.add(id);

      await _users.doc(user.id).update({'likedVoluntariados': likes});
      _analytics.logEvent(name: 'toggle_like_volunteering', parameters: {
        'userId': user.id,
        'volunteeringId': id,
        'liked': likes.contains(id).toString(),
      });
    } catch (e) {
      _crashlytics.recordError(
        e,
        null,
        reason: 'Failed to toggle like on volunteering',
        fatal: false,
      );
    }
  }

  Future<User?> updateUser(User user) async {
    try {
      final data = user.toJson();

      if (user.volunteerings != null) {
        data['voluntariados'] =
            user.volunteerings!.map((v) => v.toJson()).toList();
      }

      await _users.doc(user.id).set(data, SetOptions(merge: true));
      return user;
    } catch (e) {
      _crashlytics.recordError(
        e,
        null,
        reason: 'Failed to update user document in Firestore',
        fatal: false,
      );
      rethrow;
    }
  }
}
