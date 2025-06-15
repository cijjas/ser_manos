import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import '../models/voluntariado.dart';

class VoluntariadoService {
  final _ref = FirebaseFirestore.instance.collection('voluntariados');

  Stream<Voluntariado> watchOne(String id) {
    return _ref.doc(id).snapshots().map(
          (doc) => Voluntariado.fromJson(doc.id, doc.data()!),
        );
  }

  Stream<List<Voluntariado>> watchFiltered(String query, Position? userPosition) {
    final lower = query.toLowerCase();

    return _ref.snapshots().map((snap) {
      final docs = snap.docs
          .map((doc) => Voluntariado.fromJson(doc.id, doc.data()))
          .where((v) =>
      v.nombre.toLowerCase().contains(lower) ||
          v.descripcion.toLowerCase().contains(lower) ||
          v.tipo.toLowerCase().contains(lower))
          .toList();

      docs.sort((a, b) {
        if (userPosition != null) {
          final da = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            a.location.latitude,
            a.location.longitude,
          );
          final db = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            b.location.latitude,
            b.location.longitude,
          );

          final distanceComparison = da.compareTo(db);
          print("Distance: " + distanceComparison.toString());
          if (distanceComparison != 0) return distanceComparison;
        }
        // If distances are equal, compare createdAt (newer first)
        return b.createdAt.compareTo(a.createdAt);
      });

      return docs;
    });
  }


  Future<bool> decrementAvailableSlots(String id) async {
    try {
      final voluntariadoRef = _ref.doc(id);
      return FirebaseFirestore.instance
          .runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(voluntariadoRef);
        if (!snapshot.exists) return false;

        final currentSlots = snapshot.data()!['availableSlots'] as int;
        if (currentSlots <= 0) throw Exception('No available slots');

        transaction
            .update(voluntariadoRef, {'availableSlots': currentSlots - 1});
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
      return FirebaseFirestore.instance
          .runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(voluntariadoRef);
        if (!snapshot.exists) return false;

        final currentSlots = snapshot.data()!['availableSlots'] as int;
        transaction
            .update(voluntariadoRef, {'availableSlots': currentSlots + 1});
        return true;
      });
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack,
          reason: 'Failed to increment available slots', fatal: false);
      return false;
    }
  }
}
