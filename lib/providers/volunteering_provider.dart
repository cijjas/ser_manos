import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/providers/user_provider.dart';
import '../models/volunteering.dart';
import '../services/volunteering_service.dart';

final volunteeringServiceProvider = Provider((ref) => VolunteeringService());

final volunteeringParticipatingProvider = StreamProvider<Volunteering?>((ref) {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) return const Stream.empty();

  return ref.read(userServiceProvider).watchParticipating(user.id).map(
      (v) => v != null ? ref.watch(volunteeringProvider(v.id)).value! : null);
});

final volunteeringSearchQueryProvider = StateProvider<String>((ref) => '');

final volunteeringsProvider = StreamProvider<List<Volunteering>>((ref) {
  final query = ref.watch(volunteeringSearchQueryProvider);
  final userLocationAsync = ref.watch(userLocationProvider);

  return userLocationAsync.when(
    data: (userPosition) {
      return ref
          .read(volunteeringServiceProvider)
          .watchFiltered(query, userPosition);
    },
    loading: () {
      return ref.read(volunteeringServiceProvider).watchFiltered(query, null);
    },
    error: (_, __) {
      return ref.read(volunteeringServiceProvider).watchFiltered(query, null);
    },
  );
});

final volunteeringProvider =
    StreamProvider.family<Volunteering, String>((ref, id) {
  return ref.read(volunteeringServiceProvider).watchOne(id);
});

final postulateToVolunteering =
    FutureProvider.family<bool, String>((ref, volunteeringId) async {
  final user = await ref.read(currentUserProvider.future);

  return await ref
      .read(userServiceProvider)
      .postulateToVolunteering(user, volunteeringId);
});

final withrawPostulation =
    FutureProvider.family<bool, String>((ref, volunteeringId) async {
  final user = await ref.read(currentUserProvider.future);

  return await ref
      .read(userServiceProvider)
      .withdrawPostulation(user, volunteeringId);
});

final abandonVolunteering =
    FutureProvider.family<bool, String>((ref, volunteeringId) async {
  final user = await ref.read(currentUserProvider.future);

  return FirebaseFirestore.instance.runTransaction<bool>((transaction) async {
    final success = await ref
        .read(userServiceProvider)
        .abandonVolunteering(user, volunteeringId);
    if (!success) return false;
    return ref
        .read(volunteeringServiceProvider)
        .incrementAvailableSlots(volunteeringId);
  });
});
