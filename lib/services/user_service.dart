import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:collection/collection.dart';

import '../models/user.dart';

class UserService {
  // ─────────── constructor con inyección opcional ───────────
  UserService({
    FirebaseFirestore?   firestore,
    FirebaseAnalytics?   analytics,
    FirebaseCrashlytics? crashlytics,
  })  : _firestore   = firestore   ?? FirebaseFirestore.instance,
        _analytics   = analytics   ?? FirebaseAnalytics.instance,
        _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
        _users       = (firestore ?? FirebaseFirestore.instance)
            .collection('users');

  // singletons/mocks usados internamente
  final FirebaseFirestore   _firestore;
  final FirebaseAnalytics   _analytics;
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

  // ─────────── helper para cambiar estado de voluntariado ───────────
  Future<bool> _setUserVoluntariadoState(
      String voluntariadoId,
      User user,
      VoluntariadoUserState newState,
      ) async {
    try {
      // construir voluntariado actualizado
      UserVoluntariado newVoluntariado;
      if (user.voluntariados?.isNotEmpty ?? false) {
        final existing = user.voluntariados!.firstWhere(
              (v) => v.id == voluntariadoId,
          orElse: () =>
              UserVoluntariado(id: voluntariadoId, estado: newState),
        );
        newVoluntariado = existing.copyWith(estado: newState);
      } else {
        newVoluntariado =
            UserVoluntariado(id: voluntariadoId, estado: newState);
      }

      // lista final
      final updated = [
        ...(user.voluntariados ?? [])
            .where((v) => v.id != voluntariadoId)
            ,
        if (newState != VoluntariadoUserState.available) newVoluntariado,
      ];

      await _users.doc(user.id).update({
        'voluntariados': updated.map((v) => v.toJson()).toList(),
      });

      _analytics.logEvent(name: 'voluntariado_state_updated', parameters: {
        'voluntariadoId': voluntariadoId,
        'oldState': user.voluntariados
            ?.firstWhereOrNull((v) => v.id == voluntariadoId)
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
        reason: 'Failed to update user voluntariado state in Firestore',
        fatal: false,
      );
      _analytics.logEvent(
        name: 'voluntariado_state_update_failed',
        parameters: {
          'voluntariadoId': voluntariadoId,
          'newState': newState.toString(),
          'userId': user.id,
          'error': e.toString(),
        },
      );
      return false;
    }
  }

  // ─────────── API pública de postulaciones ───────────
  Future<bool> postulateToVoluntariado(User user, String id) async {
    if (user.voluntariados?.any((v) => v.id == id) ?? false) {
      _crashlytics.recordError(
        'User already postulated',
        null,
        reason: 'User ${user.id} already postulated to $id',
        fatal: false,
      );
      return false;
    }
    return _setUserVoluntariadoState(id, user, VoluntariadoUserState.pending);
  }

  Future<bool> withdrawPostulation(User user, String id) async {
    final vol = user.voluntariados?.firstWhereOrNull((v) => v.id == id);
    if (vol == null || vol.estado != VoluntariadoUserState.pending) {
      _crashlytics.recordError(
        'Withdraw not allowed',
        null,
        reason: 'User ${user.id} tried to withdraw but state invalid',
        fatal: false,
      );
      return false;
    }
    return _setUserVoluntariadoState(id, user, VoluntariadoUserState.available);
  }

  Future<bool> abandonVoluntariado(User user, String id) async {
    final vol = user.voluntariados?.firstWhereOrNull((v) => v.id == id);
    if (vol == null || vol.estado != VoluntariadoUserState.accepted) {
      _crashlytics.recordError(
        'Abandon not allowed',
        null,
        reason: 'User ${user.id} tried to abandon but state invalid',
        fatal: false,
      );
      return false;
    }
    return _setUserVoluntariadoState(id, user, VoluntariadoUserState.available);
  }

  // ─────────── Lectores ───────────
  Stream<UserVoluntariado?> watchParticipating(String userId) {
    return _users.doc(userId).snapshots().map((doc) =>
        User.fromJson(doc.data()!).voluntariados?.firstWhereOrNull(
                (v) => v.estado == VoluntariadoUserState.accepted));
  }

  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((d) => d.exists).map(
          (d) => User.fromJson(d.data()!),
    );
  }

  // ─────────── Likes ───────────
  Future<void> toggleLikeVoluntariado(User user, String id) async {
    try {
      final likes = [...user.likedVoluntariados ?? []];
      likes.contains(id) ? likes.remove(id) : likes.add(id);

      await _users.doc(user.id).update({'likedVoluntariados': likes});
      _analytics.logEvent(name: 'toggle_like_voluntariado', parameters: {
        'userId': user.id,
        'voluntariadoId': id,
        'liked': likes.contains(id).toString(),
      });
    } catch (e) {
      _crashlytics.recordError(
        e,
        null,
        reason: 'Failed to toggle like on voluntariado',
        fatal: false,
      );
    }
  }

  // ─────────── Update genérico ───────────
  Future<User?> updateUser(User user) async {
    try {
      await _users.doc(user.id).set(user.toJson(), SetOptions(merge: true));
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
