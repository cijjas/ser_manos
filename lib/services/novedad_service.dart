import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/models/novedad.dart';

class NovedadService {
  final _ref = FirebaseFirestore.instance.collection('novedades');

  Future<List<Novedad>> getAll() async {
    final query = await _ref.get();
    return query.docs.map((doc) => Novedad.fromJson(doc.data())).toList();
  }

  Stream<List<Novedad>> watchAll() {
    return _ref.snapshots().map((snap) =>
        snap.docs.map((doc) => Novedad.fromJson(doc.data())).toList());
  }

  Stream<Novedad> watchOne(String id) {
    return _ref.doc(id).snapshots().map(
          (doc) => Novedad.fromJson(doc.data()!),
    );
  }

}
