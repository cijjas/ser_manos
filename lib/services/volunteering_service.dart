import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geolocator/geolocator.dart';
import '../models/volunteering.dart';

class VolunteeringService {
  VolunteeringService({
    FirebaseFirestore?   firestore,
    FirebaseCrashlytics? crashlytics,
  })  : _firestore   = firestore   ?? FirebaseFirestore.instance,
        _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
        _ref         = (firestore ?? FirebaseFirestore.instance)
            .collection('voluntariados');

  final FirebaseFirestore   _firestore;
  final FirebaseCrashlytics _crashlytics;
  final CollectionReference<Map<String, dynamic>> _ref;

  Stream<Volunteering> watchOne(String id) {
    return _ref.doc(id).snapshots().map(
          (doc) => Volunteering.fromJson(doc.id, doc.data()!),
    );
  }

  Stream<List<Volunteering>> watchFiltered(String query, Position? userPosition) {
    final lower = query.toLowerCase();

    return _ref.snapshots().map((snap) {
      final docs = snap.docs
          .map((doc) => Volunteering.fromJson(doc.id, doc.data()))
          .where((v) =>
      v.name.toLowerCase().contains(lower) ||
          v.description.toLowerCase().contains(lower) ||
          v.type.toLowerCase().contains(lower))
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
          if (distanceComparison != 0) return distanceComparison;
        }
        return b.createdAt.compareTo(a.createdAt);
      });

      return docs;
    });
  }


  Future<bool> decrementAvailableSlots(String id) async {
    try {
      final ref = _ref.doc(id);
      return _firestore.runTransaction<bool>((tx) async {
        final snap = await tx.get(ref);
        if (!snap.exists) return false;

        final current = snap.data()!['availableSlots'] as int;
        if (current <= 0) throw Exception('No available slots');

        tx.update(ref, {'availableSlots': current - 1});
        return true;
      });
    } catch (e, s) {
      _crashlytics.recordError(
        e,
        s,
        reason: 'Failed to decrement available slots',
        fatal: false,
      );
      return false;
    }
  }

  Future<bool> incrementAvailableSlots(String id) async {
    try {
      final ref = _ref.doc(id);
      return _firestore.runTransaction<bool>((tx) async {
        final snap = await tx.get(ref);
        if (!snap.exists) return false;

        final current = snap.data()!['availableSlots'] as int;
        tx.update(ref, {'availableSlots': current + 1});
        return true;
      });
    } catch (e, s) {
      _crashlytics.recordError(
        e,
        s,
        reason: 'Failed to increment available slots',
        fatal: false,
      );
      return false;
    }
  }
}
