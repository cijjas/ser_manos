import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'auth_provider.dart';

final userServiceProvider = Provider((ref) => UserService());

final createUserProvider = FutureProvider.family<void, User>((ref, user) async {
  await ref.read(userServiceProvider).createUser(user);
});

final currentUserProvider = StreamProvider<User>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) throw Exception('Not authenticated');
      return ref.read(userServiceProvider).watchOne(user.uid);
    },
    loading: () => Stream.value(throw Exception('Loading authentication state')),
    error: (err, stack) => Stream.value(throw Exception('Auth error: $err')),
  );
});

// Updated provider that uses the current user automatically
final markOnboardingCompleteProvider = FutureProvider<User?>((ref) async {
  // Get the current user from currentUserProvider
  final user = await ref.watch(currentUserProvider.future);

  // Update the user's onboarding status
  return ref.read(userServiceProvider).updateUser(
      user.id,
      {'hasSeenOnboarding': true}
  );
});
