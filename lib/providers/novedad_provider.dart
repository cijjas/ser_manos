import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/novedad.dart';
import '../services/novedad_service.dart';

final novedadServiceProvider = Provider((ref) => NovedadService());

final novedadesProvider = StreamProvider<List<Novedad>>((ref) {
  return ref.read(novedadServiceProvider).watchAll();
});
