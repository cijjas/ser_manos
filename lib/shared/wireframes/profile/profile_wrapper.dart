import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ser_manos/shared/wireframes/profile/incomplete_profile.dart';

import '../../../constants/app_routes.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/debounced_async_builder.dart';
import 'full_profile.dart';

class ProfileWrapperPage extends ConsumerWidget {
  const ProfileWrapperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.whenDebounced(
      data: (fbUser) {
        if (fbUser == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRoutes.entry);
          });
          return const SizedBox();
        }

        final userAsync = ref.watch(currentUserProvider);

        return userAsync.whenDebounced(
          data: (u) {
            final fullName = '${u.nombre} ${u.apellido}';
            final birthDate = u.fechaNacimiento != null
                ? DateFormat('dd/MM/yyyy').format(u.fechaNacimiento!)
                : '';
            final gender = u.genero ?? '';
            final phone = u.telefono ?? '';

            final incomplete = u.telefono == null ||
                u.fechaNacimiento == null ||
                u.genero == null ||
                u.imagenUrl == null ||
                u.imagenUrl!.isEmpty;

            if (incomplete) {
              return IncompleteProfilePage(
                name: fullName,
                onCompletePressed: () =>
                    context.push(AppRoutes.homeProfileEdit),
                onLogoutPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go(AppRoutes.entry);
                  });
                },
              );
            } else {
              return FullProfilePage(
                imageUrl: u.imagenUrl!,
                role: context.strings.volunteer,
                name: fullName,
                email: authState.value!.email ?? u.email,
                contactEmail: u.email,
                birthDate: birthDate,
                gender: gender,
                phone: phone,
                onLogoutPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go(AppRoutes.entry);
                  });
                },
              );
            }
          },
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Scaffold(
            body: Center(child: Text(context.strings.errorUser)),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(child: Text(context.strings.errorAuth)),
      ),
    );
  }
}
