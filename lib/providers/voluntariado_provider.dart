import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/voluntariado.dart';
import '../services/voluntariado_service.dart';

final voluntariadoServiceProvider = Provider((ref) => VoluntariadoService());

final voluntariadosProvider = StreamProvider<List<Voluntariado>>((ref) {
  return ref.read(voluntariadoServiceProvider).watchAll();
});
