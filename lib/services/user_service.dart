import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../models/user.dart';
import 'package:collection/collection.dart';

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

  Future<bool> _setUserVoluntariadoState(
    String voluntariadoId,
    User user,
    VoluntariadoUserState newState,
  ) async {
    try {
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
        if (newState != VoluntariadoUserState.available) newVoluntariado
      ];

      // Update in Firestore
      await _users.doc(user.id).update(
        {
          'voluntariados': updatedVoluntariados.map((v) => v.toJson()).toList(),
        },
      );

      FirebaseAnalytics.instance
          .logEvent(name: 'voluntariado_state_updated', parameters: {
        'voluntariadoId': voluntariadoId,
        'oldState': user.voluntariados
                ?.firstWhere((v) => v.id == voluntariadoId,
                    orElse: () => UserVoluntariado(
                        id: voluntariadoId,
                        estado: VoluntariadoUserState.available))
                .estado
                .toString() ??
            'not found',
        'newState': newState.toString(),
        'userId': user.id,
      });

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
          'newState': newState.toString(),
          'userId': user.id,
          'error': e.toString(),
        },
      );

      return false;
    }
  }

  Future<bool> postulateToVoluntariado(User user, String voluntariadoId) async {
    if (user.voluntariados != null &&
        user.voluntariados!.any((v) => v.id == voluntariadoId)) {
      print(user.toString());
      FirebaseCrashlytics.instance.recordError(
        'User already postulated',
        null,
        reason:
            'User ${user.id} is already postulated to voluntariado $voluntariadoId',
        fatal: false,
      );
      return false; // User is already postulated
    }

    return _setUserVoluntariadoState(
        voluntariadoId, user, VoluntariadoUserState.applied);
  }

  Future<bool> withdrawPostulation(User user, String voluntariadoId) async {
    print(user.voluntariados);
    if (user.voluntariados == null ||
        !user.voluntariados!.any((v) => v.id == voluntariadoId)) {
      FirebaseCrashlytics.instance.recordError(
        'User has no voluntariados',
        null,
        reason:
            'User ${user.id} has no voluntariados and tried to withdraw from $voluntariadoId',
        fatal: false,
      );
      return false;
    }

    UserVoluntariado matchingVoluntariado =
        user.voluntariados!.firstWhere((v) => v.id == voluntariadoId);

    if (matchingVoluntariado.estado != VoluntariadoUserState.applied) {
      FirebaseCrashlytics.instance.recordError(
        'User voluntariado wrong state',
        null,
        reason:
            'User ${user.id} has a voluntariado $voluntariadoId but not in applied state and tried to withdraw',
        fatal: false,
      );
      return false;
    }
    return _setUserVoluntariadoState(
        voluntariadoId, user, VoluntariadoUserState.available);
  }

  Future<bool> abandonVoluntariado(User user, String voluntariadoId) async {
    if (user.voluntariados == null ||
        !user.voluntariados!.any((v) => v.id == voluntariadoId)) {
      FirebaseCrashlytics.instance.recordError(
        'User has no voluntariados',
        null,
        reason:
            'User ${user.id} has no voluntariados and tried to abandon $voluntariadoId',
        fatal: false,
      );
      return false; // User has no voluntariados
    }

    UserVoluntariado matchingVoluntariado =
        user.voluntariados!.firstWhere((v) => v.id == voluntariadoId);

    if (matchingVoluntariado.estado != VoluntariadoUserState.accepted) {
      FirebaseCrashlytics.instance.recordError(
        'User voluntariado wrong state',
        null,
        reason:
            'User ${user.id} has a voluntariado $voluntariadoId but not in accepted state and tried to abandon',
        fatal: false,
      );
      return false; // User has a voluntariado but not in applied state
    }

    return _setUserVoluntariadoState(
        voluntariadoId, user, VoluntariadoUserState.available);
  }

  Stream<UserVoluntariado?> watchParticipating(String userId) {
    return _users.doc(userId).snapshots().map((doc) =>
        User.fromJson(doc.data()!).voluntariados?.firstWhereOrNull(
            (vol) => vol.estado == VoluntariadoUserState.accepted));
  }

  Stream<User> watchOne(String id) {
    return _users.doc(id).snapshots().where((doc) => doc.exists).map(
          (doc) => User.fromJson(doc.data()!),
        );
  }

  Future<void> toggleLikeVoluntariado(
    User user,
    String voluntariadoId,
  ) async {
    try {

      final likedVoluntariados = [...user.likedVoluntariados ?? []];

      if (likedVoluntariados.contains(voluntariadoId)) {
        likedVoluntariados.remove(voluntariadoId);
      } else {
        likedVoluntariados.add(voluntariadoId);
      }

      await _users.doc(user.id).update({
        'likedVoluntariados': likedVoluntariados,
      });
      // TODO check event is relevant?
      FirebaseAnalytics.instance.logEvent(
        name: 'toggle_like_voluntariado',
        parameters: {
          'userId': user.id,
          'voluntariadoId': voluntariadoId,
          'liked': !likedVoluntariados.contains(voluntariadoId) ? "true" : "false",
        },
      );
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        e,
        null,
        reason: 'Failed to toggle like on voluntariado',
        fatal: false,
      );
    }
  }

  Future<User?> updateUser(User user) async {
    try {
      await _users.doc(user.id).set(user.toJson(), SetOptions(merge: true));
      return user;
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
}
