import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider((ref) => UserService());

/*final userProvider = StreamProvider.family<User?, String>((ref, userId) {
  return ref.read(userServiceProvider).watchUser(userId);
});*/


final userByIdProvider = StreamProvider.family<User, String>((ref, id) {
  return ref.read(userServiceProvider).watchOne(id);
});

final createUserProvider =
    FutureProvider.family<void, User>((ref, user) async {
  await ref.read(userServiceProvider).createUser(user);
});

final updateUserProvider =
    FutureProvider.family<void, User>((ref, user) async {
  await ref.read(userServiceProvider).updateUser(user);
});
