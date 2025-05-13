import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';

final userServiceProvider = Provider((ref) => UserService());

final userProvider = StreamProvider.family<User?, String>((ref, userId) {
  return ref.read(userServiceProvider).watchUser(userId);
});
