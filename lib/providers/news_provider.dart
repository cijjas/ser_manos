import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/models/news.dart';
import '../services/news_service.dart';

final newsServiceProvider = Provider((ref) => NewsService());

final newsProvider = StreamProvider<List<News>>((ref) {
  return ref.read(newsServiceProvider).watchAll();
});

final newsByIdProvider = StreamProvider.family<News, String>((ref, id) {
  return ref.read(newsServiceProvider).watchOne(id);
});
