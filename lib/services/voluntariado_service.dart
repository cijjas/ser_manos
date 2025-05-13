import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/voluntariado.dart';

class VoluntariadoService {
  final _ref = FirebaseFirestore.instance.collection('voluntariados');

  Future<void> createVoluntariado(Voluntariado v) async {
    await _ref.doc(v.id).set(v.toJson());
  }

  Future<List<Voluntariado>> getAll() async {
    final query = await _ref.get();
    return query.docs.map((doc) => Voluntariado.fromJson(doc.data())).toList();
  }

  Stream<List<Voluntariado>> watchAll() {
    return _ref.snapshots().map((snap) =>
        snap.docs.map((doc) => Voluntariado.fromJson(doc.data())).toList());
  }
}
