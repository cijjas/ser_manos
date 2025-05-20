import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/voluntariado.dart';

class VoluntariadoService {
  final _ref = FirebaseFirestore.instance.collection('voluntariados');

  Future<List<Voluntariado>> getAll() async {
    final query = await _ref.get();
    return query.docs.map((doc) => Voluntariado.fromJson(doc.data())).toList();
  }

  Stream<List<Voluntariado>> watchAll() {
    return _ref.snapshots().map((snap) {
      print('DEBUG: Firestore snapshot received with ${snap.docs.length} documents');
      final voluntariados = snap.docs.map((doc) {
        print('DEBUG: Processing document ${doc.id}');
        print('DEBUG: Processing document ${doc.data()}');
        return Voluntariado.fromJson(doc.data());
      }).toList();
      print('DEBUG: Returning list of ${voluntariados.length} voluntariados');
      return voluntariados;
    });
  }
}
