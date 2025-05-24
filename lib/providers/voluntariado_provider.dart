import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/providers/user_provider.dart';
import '../models/user.dart';
import '../models/voluntariado.dart';
import '../services/voluntariado_service.dart';

final voluntariadoServiceProvider = Provider((ref) => VoluntariadoService());

final voluntariadoParticipatingProvider = StreamProvider<Voluntariado?>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return const Stream.empty();

  return ref.read(userServiceProvider).watchParticipating(user.id).map(
      (v) => v != null ? ref.watch(voluntariadoProvider(v.id)).value! : null);
});

final voluntariadosProvider = StreamProvider<List<Voluntariado>>((ref) {
  return ref.read(voluntariadoServiceProvider).watchAll();
});

final voluntariadoProvider =
    StreamProvider.family<Voluntariado, String>((ref, id) {
  return ref.read(voluntariadoServiceProvider).watchOne(id);
});

final postulateToVoluntariado =
    FutureProvider.family<bool, String>((ref, voluntariadoId) async {
  print('Postulando a voluntariado: $voluntariadoId');
  final user = await ref.read(currentUserProvider.future);
  print('Usuario: ${user.id}');

  return await ref
      .read(userServiceProvider)
      .postulateToVoluntariado(user, voluntariadoId);
});

final withrawPostulation =
    FutureProvider.family<bool, String>((ref, voluntariadoId) async {
  final user = await ref.read(currentUserProvider.future);

  return await ref
      .read(userServiceProvider)
      .withdrawPostulation(user, voluntariadoId);
});

final abandonVoluntariado =
    FutureProvider.family<bool, String>((ref, voluntariadoId) async {
  final user = await ref.read(currentUserProvider.future);

  // Use a transaction to make both operations atomic
  return FirebaseFirestore.instance.runTransaction<bool>((transaction) async {
    final success = await ref
        .read(userServiceProvider)
        .abandonVoluntariado(user, voluntariadoId);
    if (!success) return false;
    return ref
        .read(voluntariadoServiceProvider)
        .incrementAvailableSlots(voluntariadoId);
  });
});
