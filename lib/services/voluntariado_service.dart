import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
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

}
