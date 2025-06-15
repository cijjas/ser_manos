import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/models/novedad.dart';

class NovedadService {
  final _collection = FirebaseFirestore.instance.collection('novedades');

  Stream<List<Novedad>> watchAll() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
        snap.docs.map((doc) => Novedad.fromJson(doc.data())).toList());
  }


  Stream<Novedad> watchOne(String id) {
    return _collection
        .doc(id)
        .snapshots()
        .map((doc) => Novedad.fromJson(doc.data()!));
  }

}
