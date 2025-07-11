import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ser_manos/models/news.dart';

class NewsService {
  NewsService({FirebaseFirestore? firestore})
      : _collection =
            (firestore ?? FirebaseFirestore.instance).collection('novedades');

  final CollectionReference<Map<String, dynamic>> _collection;

  Future<List<News>> getAll() async {
    final query =
        await _collection.orderBy('createdAt', descending: true).get();
    return query.docs.map((doc) => News.fromJson(doc.data())).toList();
  }

  Stream<List<News>> watchAll() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map(
        (snap) =>
            snap.docs.map((doc) => News.fromJson(doc.data())).toList());
  }

  Stream<News> watchOne(String id) {
    return _collection
        .doc(id)
        .snapshots()
        .map((doc) => News.fromJson(doc.data()!));
  }
}
