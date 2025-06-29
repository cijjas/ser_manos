import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
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


final markOnboardingCompleteProvider = FutureProvider<User?>((ref) async {
  final user = await ref.watch(currentUserProvider.future);

  return ref.read(userServiceProvider).updateUser(
      user.copyWith(
        hasSeenOnboarding: true,
      )
  );
});

final updateUserProvider =
    FutureProvider.family<void, User>((ref, user) async {
  await ref.read(userServiceProvider).updateUser(user);
});

final userLocationProvider = FutureProvider<Position?>((ref) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (!serviceEnabled || permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return null;
    }
  }

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.low,
      timeLimit: Duration(seconds: 10),
    )
  );
});
