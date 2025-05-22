import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../models/voluntariado.dart';

class VoluntariadoService {
  final _ref = FirebaseFirestore.instance.collection('voluntariados');

  // Future<List<Voluntariado>> getAll() async {
  //   final query = await _ref.get();
  //   return query.docs.map((doc) => Voluntariado.fromJson(doc.data())).toList();
  // }

  Stream<Voluntariado> watchOne(String id) {
    return _ref.doc(id).snapshots().map(
          (doc) => Voluntariado.fromJson(doc.id, doc.data()!),
        );
  }

  Stream<List<Voluntariado>> watchAll() {
    return _ref.snapshots().map((snap) => snap.docs.map((doc) =>
        Voluntariado.fromJson(doc.id, doc.data())).toList()
    );
  }


  Future<bool> decrementAvailableSlots(String id) async {
    try {
      final voluntariadoRef = _ref.doc(id);
      return FirebaseFirestore.instance.runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(voluntariadoRef);
        if (!snapshot.exists) return false;

        final currentSlots = snapshot.data()!['availableSlots'] as int;
        if (currentSlots <= 0) throw Exception('No available slots');

        transaction.update(voluntariadoRef, {'availableSlots': currentSlots - 1});
        return true;
      });
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack,
          reason: 'Failed to decrement available slots', fatal: false);
      return false;
    }
  }

  // Add this to your VoluntariadoService class
  Future<bool> incrementAvailableSlots(String voluntariadoId) async {
    try {
      final voluntariadoRef = _ref.doc(voluntariadoId);
      return FirebaseFirestore.instance.runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(voluntariadoRef);
        if (!snapshot.exists) return false;

        final currentSlots = snapshot.data()!['availableSlots'] as int;
        transaction.update(voluntariadoRef, {'availableSlots': currentSlots + 1});
        return true;
      });
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack,
          reason: 'Failed to increment available slots', fatal: false);
      return false;
    }
  }
}
