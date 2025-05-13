import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/novedad.dart';

class NovedadService {
  final _ref = FirebaseFirestore.instance.collection('novedades');

  Future<void> createNovedad(Novedad n) async {
    await _ref.doc(n.id).set(n.toJson());
  }

  Future<List<Novedad>> getAll() async {
    final query = await _ref.get();
    return query.docs.map((doc) => Novedad.fromJson(doc.data())).toList();
  }

  Stream<List<Novedad>> watchAll() {
    return _ref.snapshots().map((snap) =>
        snap.docs.map((doc) => Novedad.fromJson(doc.data())).toList());
  }
}
