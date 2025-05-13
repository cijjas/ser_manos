import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/models/novedad.dart';
import '../services/novedad_service.dart';

final novedadServiceProvider = Provider((ref) => NovedadService());

final novedadesProvider = StreamProvider<List<Novedad>>((ref) {
  return ref.read(novedadServiceProvider).watchAll();
});



final novedadByIdProvider = StreamProvider.family<Novedad, String>((ref, id) {
  return ref.read(novedadServiceProvider).watchOne(id);
});
