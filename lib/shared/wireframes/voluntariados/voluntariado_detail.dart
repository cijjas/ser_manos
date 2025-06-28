import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/models/voluntariado.dart';
import 'package:ser_manos/providers/voluntariado_provider.dart';
import 'package:geocoding/geocoding.dart';

import '../../../constants/app_routes.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/components/vacants.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';


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
      BuildContext context, WidgetRef ref, User user, Voluntariado? participatingVoluntariado) async {
    if (participatingVoluntariado == null) return;
    await ref
        .read(userServiceProvider)
        .withdrawPostulation(user, participatingVoluntariado.id);
  }

  Future<void> _handleAbandon(
      BuildContext context, WidgetRef ref, User user, Voluntariado? participatingVoluntariado) async {
    if (participatingVoluntariado == null) return;
    await ref
        .read(userServiceProvider)
        .abandonVoluntariado(user, participatingVoluntariado.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voluntariadoAsync = ref.watch(voluntariadoProvider(voluntariadoId));
    final currentUserAsync = ref.watch(currentUserProvider);

    final participatingVoluntariado =
        ref.watch(voluntariadoParticipatingProvider);

    return voluntariadoAsync.when(
      data: (voluntariado) {
        return currentUserAsync.when(
          data: (user) {
            return _buildContent(
              context,
              ref,
              voluntariado,
              user,
              participatingVoluntariado.value,
              () => _handleApply(context, ref, user),
              () => _handleWithdraw(context, ref, user, participatingVoluntariado.value),
              () => _handleAbandon(context, ref, user, participatingVoluntariado.value),
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
  bool _isProfileComplete(User user) {
    return user.fechaNacimiento != null &&
        (user.genero != null && user.genero!.isNotEmpty) &&
        (user.imagenUrl != null && user.imagenUrl!.isNotEmpty) &&
        (user.telefono != null && user.telefono!.isNotEmpty);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Voluntariado voluntariado,
    User user,
    Voluntariado? participatingVoluntariado,
    Future<void> Function()? onApply,
    Future<void> Function()? onWithdraw,
    Future<void> Function()? onAbandon,
  ) {
    final media = MediaQuery.of(context);

    Future<void> wrappedApply() async {
      final currentUser = ref.read(currentUserProvider).value;
      if (currentUser == null) return;

      if (_isProfileComplete(currentUser)) {
        _showConfirmModal(context, voluntariado,
            () => onApply != null ? onApply() : {}, ActionType.postulate);
      } else {
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => ConfirmApplicationModal(
            message: "Para postularte debes primero completar tus datos.",
            title: "",
            confirmLabel: "Confirmar",
            onConfirm: () => Navigator.of(dialogContext).pop(true),
            onCancel: () => Navigator.of(dialogContext).pop(false),
            actionType: ActionType
                .postulate,
          ),
        );
        if (!context.mounted) return;

        if (confirmed == true) {
          final profileSaved =
              await GoRouter.of(context).push<bool>(AppRoutes.homeProfileEdit);
          if (!context.mounted) return;

          if (profileSaved == true) {
            ref.invalidate(currentUserProvider);
            final freshUser = await ref.read(currentUserProvider.future);

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
      if (participatingVoluntariado == null) {
        return;
      }
      _showConfirmModal(context, participatingVoluntariado,
          () => onWithdraw != null ? onWithdraw() : {}, ActionType.withdraw);
    }

    Future<void> wrappedAbandon() async {
      if (participatingVoluntariado == null) {
        return;
      }
      _showConfirmModal(context, participatingVoluntariado,
          () => onAbandon != null ? onAbandon() : {}, ActionType.abandon);
    }

    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: Stack(
        children: [
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
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.neutral10,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
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
                          participatingVoluntariado: participatingVoluntariado,
                          onApply: wrappedApply,
                          onWithdraw: wrappedWithdraw,
                          onAbandon: wrappedAbandon,
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: StatusBar(
              style: StatusBarStyle.dark,
              hasShadow: true,
            ),
          ),

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

class _BottomSection extends StatelessWidget {
  const _BottomSection(
      {required this.state,
      required this.onApply,
      required this.onWithdraw,
      required this.onAbandon,
      this.participatingVoluntariado});

  final Voluntariado? participatingVoluntariado;

  final VoluntariadoUserState state;
  final Future<void> Function() onApply;
  final Future<void> Function() onWithdraw;
  final Future<void> Function() onAbandon;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case VoluntariadoUserState.available || VoluntariadoUserState.rejected || VoluntariadoUserState.completed:
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

      case VoluntariadoUserState.busyOther ||
            VoluntariadoUserState.busyOtherPending:
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
              onPressed: state == VoluntariadoUserState.busyOtherPending
                  ? onWithdraw
                  : onAbandon,
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

class _LocationCard extends StatefulWidget {
  const _LocationCard({
    required this.location,
  });

  final LatLng location;

  @override
  State<_LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<_LocationCard> {
  String? _address;

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  Future<void> _getAddress() async {
    try {
      final placemarks = await placemarkFromCoordinates(
        widget.location.latitude,
        widget.location.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _address = '${place.street}, ${place.locality}, ${place.country}';
      });
    } catch (e) {
      setState(() => _address = 'No se pudo obtener la dirección');
    }
  }

  void _openNativeMaps() {
    MapsLauncher.launchCoordinates(
      widget.location.latitude,
      widget.location.longitude,
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
          Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.secondary25,
            child: const Text('Ubicación', style: AppTypography.subtitle01),
          ),
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
          Container(
            color: AppColors.neutral10,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dirección', style: AppTypography.overline),
                const SizedBox(height: 4),
                Text(_address ?? 'Cargando dirección...',
                    style: AppTypography.body01),
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
  try {
    final userVoluntariado = user.voluntariados?.firstWhere(
      (v) => v.id == voluntariado.id,
    );

    if (userVoluntariado != null) {
      return userVoluntariado.estado;
    }
  } catch (_) {}

  if (user.voluntariados
          ?.any((v) => v.estado == VoluntariadoUserState.accepted) ??
      false) {
    return VoluntariadoUserState.busyOther;
  }

  if (user.voluntariados
          ?.any((v) => v.estado == VoluntariadoUserState.pending) ??
      false) {
    return VoluntariadoUserState.busyOtherPending;
  }

  if (voluntariado.vacantes <= 0) {
    return VoluntariadoUserState.full;
  }

  return VoluntariadoUserState.available;
}
