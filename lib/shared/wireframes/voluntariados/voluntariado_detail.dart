// lib/shared/wireframes/voluntariado/voluntariado_detalle.dart
//
// Pantalla de detalle de voluntariado.
// Incluye parte fija y una sección variable según el estado del usuario.

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';

import '../../../constants/app_routes.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/components/vacants.dart';
import '../../molecules/status_bar/status_bar.dart';
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
    await ref
        .read(userServiceProvider)
        .postulateToVoluntariado(user, voluntariadoId);
  }

  Future<void> _handleWithdraw(
      BuildContext context, WidgetRef ref, User user) async {
    await ref
        .read(userServiceProvider)
        .withdrawPostulation(user, voluntariadoId);
  }

  Future<void> _handleAbandon(
      BuildContext context, WidgetRef ref, User user) async {
    await ref
        .read(userServiceProvider)
        .abandonVoluntariado(user, voluntariadoId);
  }

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
              ref,
              // Pass ref
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
      error: (error, _) {
        ref.invalidate(voluntariadoProvider(voluntariadoId));
        return Scaffold(body: Center(child: Text('Error: $error')));
      },
    );
  }

  // Helper function to determine if the user profile is complete.
  // Ideally, this would be a getter on the User model (`user.isProfileComplete`).
  bool _isProfileComplete(User user) {
    return user.fechaNacimiento != null &&
        (user.genero != null && user.genero!.isNotEmpty) &&
        (user.imagenUrl != null && user.imagenUrl!.isNotEmpty) &&
        (user.telefono != null && user.telefono!.isNotEmpty);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref, // Receive ref
    Voluntariado voluntariado,
    User user,
    Future<void> Function()? onApply,
    Future<void> Function()? onWithdraw,
    Future<void> Function()? onAbandon,
  ) {
    final media = MediaQuery.of(context);

    Future<void> wrappedApply() async {
      // Get the latest user data directly from the provider.
      final currentUser = ref.read(currentUserProvider).value;
      if (currentUser == null) return; // Exit if user data is not available.

      // Check if the user's profile is complete.
      if (_isProfileComplete(currentUser)) {
        // If complete, show the confirmation modal to apply.
        _showConfirmModal(context, voluntariado,
            () => onApply != null ? onApply() : {}, ActionType.postulate);
      } else {
        // If incomplete, show a modal informing the user.
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => ConfirmApplicationModal(
            message: "Para postularte debes primero completar tus datos.",
            title: "",
            // Title is not needed as message is descriptive.
            confirmLabel: "Confirmar",
            onConfirm: () => Navigator.of(dialogContext).pop(true),
            onCancel: () => Navigator.of(dialogContext).pop(false),
            actionType: ActionType
                .postulate, // A placeholder type, the message is overridden.
          ),
        );
        // Insert mounted check after showDialog
        if (!context.mounted) return;

        // If user confirms, navigate to the edit profile page.
        if (confirmed == true) {
          final profileSaved = await GoRouter.of(context).push<bool>(AppRoutes.homeProfileEdit);
          // Insert mounted check after push
          if (!context.mounted) return;

          // If the profile was saved successfully...
          if (profileSaved == true) {
            // Invalidate the provider to force a refetch of the user data.
            ref.invalidate(currentUserProvider);
            // Wait for the provider to update with the new user data.
            final freshUser = await ref.read(currentUserProvider.future);

            // Now, with the updated user, show the application modal.
            _showConfirmModal(
              context,
              voluntariado,
              () => _handleApply(context, ref, freshUser),
              ActionType.postulate,
            );
          }
        }
      }
    }

    Future<void> wrappedWithdraw() async {
      _showConfirmModal(context, voluntariado,
          () => onWithdraw != null ? onWithdraw() : {}, ActionType.withdraw);
    }

    Future<void> wrappedAbandon() async {
      _showConfirmModal(context, voluntariado,
          () => onAbandon != null ? onAbandon() : {}, ActionType.abandon);
    }

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: Stack(
        children: [
          // 1. Scrollable content
          Positioned.fill(
            top: 52,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: media.size.width * 0.6,
                    width: double.infinity,
                    child: Image.network(
                      voluntariado.imageUrl,
                      fit: BoxFit.cover,
                    ),
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
                        Text(voluntariado.nombre,
                            style: AppTypography.headline01),
                        const SizedBox(height: 16),
                        Text(voluntariado.resumen,
                            style: AppTypography.body01
                                .copyWith(color: AppColors.secondary200)),
                        const SizedBox(height: 32),
                        const Text('Sobre la actividad',
                            style: AppTypography.headline02),
                        const SizedBox(height: 8),
                        Text(voluntariado.descripcion,
                            style: AppTypography.body01),
                        const SizedBox(height: 32),
                        _LocationCard(
                          address: voluntariado.location.toString(),
                          location: voluntariado.location,
                        ),
                        const SizedBox(height: 32),
                        const Text('Participar del voluntariado',
                            style: AppTypography.headline02),
                        const SizedBox(height: 16),
                        MarkdownBody(
                          data: voluntariado.requisitos,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                            p: AppTypography.body01,
                          ),
                        ),
                        const SizedBox(height: 24),
                        VacantsDisplay(number: voluntariado.vacantes),
                        const SizedBox(height: 32),
                        _BottomSection(
                          state: _determineUserState(voluntariado, user),
                          onApply: wrappedApply,
                          onWithdraw: wrappedWithdraw,
                          onAbandon:
                              wrappedAbandon, // Changed from onAbandon to wrappedAbandon for consistency
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Status bar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StatusBar(
              style: StatusBarStyle.dark,
              hasShadow: true,
            ),
          ),

          // 3. Back button
          Positioned(
            top: 8,
            left: 8,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.neutral0),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showConfirmModal(BuildContext context, Voluntariado voluntariado,
    Function() onConfirm, ActionType actionType) {
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
      case VoluntariadoUserState.available || VoluntariadoUserState.rejected:
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

      case VoluntariadoUserState.pending:
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
        return const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'No hay vacantes disponibles para postularse',
              style: AppTypography.body01,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
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

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.address,
    required this.location,
  });

  final String address;
  final LatLng location;

  void _openNativeMaps() {
    MapsLauncher.launchCoordinates(
      location.latitude,
      location.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral0,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.secondary25,
            child: const Text('Ubicación', style: AppTypography.subtitle01),
          ),

          // Pressable "map" placeholder
          GestureDetector(
            onTap: _openNativeMaps,
            child: Container(
              height: 200,
              color: AppColors.neutral25,
              alignment: Alignment.center,
              child:
                  const Icon(Icons.map, size: 64, color: AppColors.neutral50),
            ),
          ),

          // Address section
          Container(
            color: AppColors.neutral10,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dirección', style: AppTypography.overline),
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
