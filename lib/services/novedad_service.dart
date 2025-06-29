import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/models/novedad.dart';

class NovedadService {
  NovedadService({FirebaseFirestore? firestore})
      : _collection =
            (firestore ?? FirebaseFirestore.instance).collection('novedades');

  final CollectionReference<Map<String, dynamic>> _collection;

  Future<List<Novedad>> getAll() async {
    final query =
        await _collection.orderBy('createdAt', descending: true).get();
    return query.docs.map((doc) => Novedad.fromJson(doc.data())).toList();
  }

  Stream<List<Novedad>> watchAll() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map(
        (snap) =>
            snap.docs.map((doc) => Novedad.fromJson(doc.data())).toList());
  }

  Stream<Novedad> watchOne(String id) {
    return _collection
        .doc(id)
        .snapshots()
        .map((doc) => Novedad.fromJson(doc.data()!));
  }
}
