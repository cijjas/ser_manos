// lib/shared/wireframes/voluntariado/voluntariado_detalle.dart
//
// Pantalla de detalle de voluntariado.
// Incluye parte fija y una sección variable según el estado del usuario.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';

import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/components/vacants.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

// ──────────────────────────────────────────────────────────────────────

class VoluntariadoDetallePage extends ConsumerWidget {
  const VoluntariadoDetallePage({
    super.key,
    required this.voluntariadoId,
  });

  final String voluntariadoId;

  Future<void> _handleApply(
      BuildContext context, WidgetRef ref, User user) async {
    final result = await ref
        .read(userServiceProvider)
        .postulateToVoluntariado(user, voluntariadoId);
    // TODO remove snackbar
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Postulación enviada.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ya estás postulado.")),
      );
    }
  }

  Future<void> _handleWithdraw(
      BuildContext context, WidgetRef ref, User user) async {
    final result = await ref
        .read(userServiceProvider)
        .withdrawPostulation(user, voluntariadoId);
    // TODO remove snackbar
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Postulación retirada.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo retirar la postulación.")),
      );
    }
  }

  Future<void> _handleAbandon(
      BuildContext context, WidgetRef ref, User user) async {
    final result = await ref
        .read(userServiceProvider)
        .abandonVoluntariado(user, voluntariadoId);
    // TODO remove snackbar
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Voluntariado abandonado.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se pudo abandonar el voluntariado.")),
      );
    }
  }

  // TODO modal

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadoAsync = ref.watch(voluntariadoProvider(voluntariadoId));
    final currentUserAsync = ref.watch(currentUserProvider);

    return voluntariadoAsync.when(
      data: (voluntariado) {
        return currentUserAsync.when(
          data: (user) {
            return _buildContent(
              context,
              voluntariado,
              user,
              () => _handleApply(context, ref, user),
              () => _handleWithdraw(context, ref, user),
              () => _handleAbandon(context, ref, user),
            );
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (err, _) =>
              Scaffold(body: Center(child: Text('Error de usuario: $err'))),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Voluntariado voluntariado,
    User user,
    Future<void> Function()? onApply,
    Future<void> Function()? onWithdraw,
    Future<void> Function()? onAbandon,
  ) {
    // Determine user state based on user and voluntariado data
    final media = MediaQuery.of(context);

    // Create wrapped functions that will show modals and invalidate providers


    Future<void> wrappedApply() async {
      _showConfirmModal(context, voluntariado, () => onApply != null ? onApply() : {}, ActionType.postulate);
    }

    Future<void> wrappedWithdraw() async {
      _showConfirmModal(context, voluntariado, () => onWithdraw != null ? onWithdraw() : {}, ActionType.withdraw);
    }

    Future<void> wrappedAbandon() async {
      _showConfirmModal(context, voluntariado, () => onAbandon != null ? onAbandon() : {}, ActionType.abandon);
    }

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen de cabecera
              Stack(
                children: [
                  SizedBox(
                    height: media.size.width * 0.6,
                    width: double.infinity,
                    child:
                        Image.network(voluntariado.imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.neutral0),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(voluntariado.tipo.toUpperCase(),
                        style: AppTypography.overline
                            .copyWith(color: AppColors.neutral75)),
                    const SizedBox(height: 4),
                    Text(voluntariado.nombre, style: AppTypography.headline01),
                    const SizedBox(height: 16),
                    Text(voluntariado.resumen,
                        style: AppTypography.body01
                            .copyWith(color: AppColors.secondary200)),

                    const SizedBox(height: 32),
                    Text('Sobre la actividad', style: AppTypography.headline02),
                    const SizedBox(height: 8),
                    Text(voluntariado.descripcion, style: AppTypography.body01),

                    const SizedBox(height: 32),
                    _LocationCard(address: voluntariado.location.toString()),
                    const SizedBox(height: 32),

                    Text('Participar del voluntariado',
                        style: AppTypography.headline02),
                    const SizedBox(height: 16),

                    Text('Requisitos', style: AppTypography.subtitle01),
                    const SizedBox(height: 8),
                    _BulletList(lines: voluntariado.requisitos),

                    const SizedBox(height: 16),
                    Text('Disponibilidad', style: AppTypography.subtitle01),
                    const SizedBox(height: 8),
                    _BulletList(lines: voluntariado.disponibilidad),

                    const SizedBox(height: 24),
                    VacantsDisplay(initialNumber: voluntariado.vacantes),

                    const SizedBox(height: 32),

                    // Sección variable al final
                    _BottomSection(
                      state: _determineUserState(voluntariado, user),
                      onApply: wrappedApply,
                      onWithdraw: wrappedWithdraw,
                      onAbandon: onAbandon,
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void _showConfirmModal(BuildContext context, Voluntariado voluntariado, Function() onConfirm, ActionType actionType) {
  showDialog(
    context: context,
    builder: (context) => ConfirmApplicationModal(
      title: voluntariado.nombre,
      onConfirm: () {
        Navigator.pop(context);
        onConfirm();
      },
      onCancel: () => Navigator.pop(context),
      actionType: actionType,
    ),
  );
}

// ──────────────────────────────────────────────────────────────────────
// Sección variable
class _BottomSection extends StatelessWidget {
  const _BottomSection({
    required this.state,
    this.onApply,
    this.onWithdraw,
    this.onAbandon,
  });

  final VoluntariadoUserState state;
  final Future<void> Function()? onApply;
  final Future<void> Function()? onWithdraw;
  final Future<void> Function()? onAbandon;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case VoluntariadoUserState.available:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              label: 'Postularme',
              onPressed: onApply,
              type: AppButtonType.filled,
            ),
          ],
        );

      case VoluntariadoUserState.applied:
        return _InfoWithLink(
          title: 'Te has postulado',
          subtitle:
              'Pronto la organización se pondrá en contacto\ncontigo y te inscribirá como participante.',
          linkLabel: 'Retirar postulación',
          onLinkPressed: onWithdraw,
        );

      case VoluntariadoUserState.accepted:
        return _InfoWithLink(
          title: 'Estas participando',
          subtitle:
              'La organización confirmó que ya estas\nparticipando de este voluntariado',
          linkLabel: 'Abandonar voluntariado',
          onLinkPressed: onAbandon,
        );

      case VoluntariadoUserState.full:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'No hay vacantes disponibles para postularse',
              style: AppTypography.body01,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Postularme',
              onPressed: null, // disabled
              type: AppButtonType.filled,
            ),
          ],
        );

      case VoluntariadoUserState.busyOther:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ya estas participando en otro voluntariado, debes abandonarlo primero para postularte a este.',
              style: AppTypography.body01,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onAbandon,
              child: Text('Abandonar voluntariado actual',
                  style: AppTypography.button
                      .copyWith(color: AppColors.primary100)),
            ),
            const SizedBox(height: 16),
            const AppButton(
              label: 'Postularme',
              onPressed: null,
              type: AppButtonType.filled,
            ),
          ],
        );
    }
  }
}

// ──────────────────────────────────────────────────────────────────────
// Bloque de info + link
class _InfoWithLink extends StatelessWidget {
  const _InfoWithLink({
    required this.title,
    required this.subtitle,
    required this.linkLabel,
    required this.onLinkPressed,
  });

  final String title;
  final String subtitle;
  final String linkLabel;
  final VoidCallback? onLinkPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,
            style: AppTypography.headline02, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(subtitle,
            style: AppTypography.body01, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onLinkPressed,
          child: Text(linkLabel,
              style:
                  AppTypography.button.copyWith(color: AppColors.primary100)),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// Card de ubicación (mapa placeholder)
class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondary10,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
            ),
            child: Text('Ubicación', style: AppTypography.headline02),
          ),
          Container(
            height: 200,
            color: AppColors.neutral25,
            alignment: Alignment.center,
            child: const Icon(Icons.map, size: 64, color: AppColors.neutral50),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dirección',
                    style: AppTypography.overline
                        .copyWith(color: AppColors.neutral75)),
                const SizedBox(height: 4),
                Text(address, style: AppTypography.body01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────
// Lista con bullets
class _BulletList extends StatelessWidget {
  const _BulletList({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final line in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: AppTypography.body01),
                Expanded(child: Text(line, style: AppTypography.body01)),
              ],
            ),
          ),
      ],
    );
  }
}

VoluntariadoUserState _determineUserState(
    Voluntariado voluntariado, User user) {
  // Find if user has this voluntariado in their list
  try {
    final userVoluntariado = user.voluntariados?.firstWhere(
      (v) => v.id == voluntariado.id,
    );

    if (userVoluntariado != null) {
      return userVoluntariado.estado;
    }
  } catch (_) {
    // Not found in list - continue to next checks
  }

  // Check if user is busy with another voluntariado
  if (user.voluntariados
          ?.any((v) => v.estado == VoluntariadoUserState.accepted) ??
      false) {
    return VoluntariadoUserState.busyOther;
  }

  if (voluntariado.vacantes <= 0) {
    return VoluntariadoUserState.full;
  }

  // Default available state
  return VoluntariadoUserState.available;
}

//
// // ──────────────────────────────────────────────────────────────────────
// // Demo rápida con los 5 estados en un TabBar
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DefaultTabController(
//         length: 5,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Demo estados voluntariado'),
//             bottom: const TabBar(
//               isScrollable: true,
//               tabs: [
//                 Tab(text: 'available'),
//                 Tab(text: 'applied'),
//                 Tab(text: 'accepted'),
//                 Tab(text: 'full'),
//                 Tab(text: 'busy'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               _buildPage(VoluntariadoUserState.available),
//               _buildPage(VoluntariadoUserState.applied),
//               _buildPage(VoluntariadoUserState.accepted),
//               _buildPage(VoluntariadoUserState.full),
//               _buildPage(VoluntariadoUserState.busyOther),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// /// Helper para la demo
// Widget _buildPage(VoluntariadoUserState state) {
//   return VoluntariadoDetallePage(
//     imageUrl: 'https://picsum.photos/id/1032/800/400',
//     type: 'Acción Social',
//     title: 'Un Techo para mi País',
//     subtitle:
//     'El propósito principal de \"Un techo para mi país\" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
//     activityDescription:
//     'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.',
//     address: 'Echeverría 3560, Capital Federal.',
//     requirements: ['Mayor de edad.', 'Poder levantar cosas pesadas.'],
//     availability: ['Mayor de edad.', 'Poder levantar cosas pesadas.'],
//     vacants: state == VoluntariadoUserState.full ? 0 : 10,
//     state: state,
//     onApply: () => debugPrint('apply'),
//     onWithdraw: () => debugPrint('withdraw'),
//     onAbandon: () => debugPrint('abandon'),
//   );
// }
