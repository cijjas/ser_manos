// lib/shared/wireframes/perfil/perfil_wrapper.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../wireframes/perfil/perfil_completo.dart';
import '../../wireframes/perfil/perfil_incompleto.dart';

class PerfilWrapperPage extends ConsumerWidget {
  const PerfilWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error auth: $e')),
      ),
      data: (fbUser) {
        if (fbUser == null) {
          // No está logueado → voy a /
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/');
          });
          return const SizedBox();
        }

        final userAsync = ref.watch(currentUserProvider);

        return userAsync.when(
          loading: () => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Scaffold(
            body: Center(child: Text('Error user: $e')),
          ),
          data: (u) {
            final fullName = '${u.nombre} ${u.apellido}';
            final birthDate = u.fechaNacimiento != null
                ? DateFormat('dd/MM/yyyy').format(u.fechaNacimiento!)
                : '';
            final gender = u.genero ?? '';
            final phone = u.telefono ?? '';

            // Ahora consideramos incompleto también si falta imagenUrl
            final incomplete = u.telefono == null ||
                u.fechaNacimiento == null ||
                u.genero == null ||
                u.imagenUrl == null ||
                u.imagenUrl!.isEmpty;

            if (incomplete) {
              return PerfilIncompletoPage(
                name: fullName,
                onCompletePressed: () => context.push('/home/perfil/editar'),
                onLogoutPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/');
                  });
                },
              );
            } else {
              return PerfilCompletoPage(
                imageUrl: u.imagenUrl!, // Safe: ya es no-null aquí
                role: 'Voluntario',
                name: fullName,
                email: u.email,
                birthDate: birthDate,
                gender: gender,
                phone: phone,
                onLogoutPressed: () async {
                  await ref.read(authServiceProvider).signOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go('/');
                  });
                },
              );
            }
          },
        );
      },
    );
  }
}
