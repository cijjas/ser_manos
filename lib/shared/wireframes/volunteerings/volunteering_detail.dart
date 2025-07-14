import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:ser_manos/models/volunteering.dart';
import 'package:ser_manos/providers/volunteering_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_routes.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/debounced_async_builder.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/buttons/app_button.dart';
import '../../molecules/components/vacants.dart';
import '../../molecules/status_bar/status_bar.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class VolunteeringDetallePage extends ConsumerStatefulWidget {
  const VolunteeringDetallePage({
    super.key,
    required this.volunteeringId,
  });

  final String volunteeringId;

  @override
  ConsumerState<VolunteeringDetallePage> createState() =>
      _VolunteeringDetallePageState();
}

class _VolunteeringDetallePageState
    extends ConsumerState<VolunteeringDetallePage> {
  Future<void> _handleApply(BuildContext context, WidgetRef ref, User user,
      Volunteering volunteering) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'apply_for_volunteering',
      parameters: {
        'volunteering_id': volunteering.id,
        'volunteering_name': volunteering.name,
        'volunteering_type': volunteering.type,
      },
    );

    try {
      await ref
          .read(userServiceProvider)
          .postulateToVolunteering(user, widget.volunteeringId);
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to apply for volunteering',
        information: [
          'Volunteering ID: ${widget.volunteeringId}',
          'User ID: ${user.id}'
        ],
        fatal: false,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.applyError)),
        );
      }
    }
  }

  Future<void> _handleWithdraw(BuildContext context, WidgetRef ref, User user,
      Volunteering? participatingVolunteering) async {
    if (participatingVolunteering == null) return;

    await FirebaseAnalytics.instance.logEvent(
      name: 'withdraw_application',
      parameters: {
        'volunteering_id': participatingVolunteering.id,
        'volunteering_name': participatingVolunteering.name,
      },
    );

    try {
      await ref
          .read(userServiceProvider)
          .withdrawPostulation(user, participatingVolunteering.id);
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to withdraw postulation',
        information: [
          'Volunteering ID: ${participatingVolunteering.id}',
          'User ID: ${user.id}'
        ],
        fatal: false,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.withdrawError)),
        );
      }
    }
  }

  Future<void> _handleAbandon(BuildContext context, WidgetRef ref, User user,
      Volunteering? participatingVolunteering) async {
    if (participatingVolunteering == null) return;

    await FirebaseAnalytics.instance.logEvent(
      name: 'abandon_volunteering',
      parameters: {
        'volunteering_id': participatingVolunteering.id,
        'volunteering_name': participatingVolunteering.name,
      },
    );

    try {
      await ref
          .read(userServiceProvider)
          .abandonVolunteering(user, participatingVolunteering.id);
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to abandon volunteering',
        information: [
          'Volunteering ID: ${participatingVolunteering.id}',
          'User ID: ${user.id}'
        ],
        fatal: false,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.strings.abandonError)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final volunteeringAsync =
        ref.watch(volunteeringProvider(widget.volunteeringId));
    final currentUserAsync = ref.watch(currentUserProvider);

    final participatingVolunteering =
        ref.watch(volunteeringParticipatingProvider);

    return volunteeringAsync.whenDebounced(
      data: (volunteering) {
        return currentUserAsync.whenDebounced(
          data: (user) {
            return _buildContent(
              context,
              ref,
              volunteering,
              user,
              participatingVolunteering.value,
              () => _handleApply(context, ref, user, volunteering),
              () => _handleWithdraw(
                  context, ref, user, participatingVolunteering.value),
              () => _handleAbandon(
                  context, ref, user, participatingVolunteering.value),
            );
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (err, stack) {
            FirebaseCrashlytics.instance.recordError(
              err,
              stack,
              reason:
                  'Failed to load current user data for VolunteeringDetallePage',
              fatal: false,
            );
            return Scaffold(
                body: Center(child: Text(context.strings.loadUserDataError)));
          },
          onError: (error, stackTrace) {
            ref.invalidate(currentUserProvider);
          },
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          reason:
              'Failed to load volunteering data for VolunteeringDetallePage',
          information: ['Volunteering ID: ${widget.volunteeringId}'],
          fatal: false,
        );
        ref.invalidate(volunteeringProvider(widget.volunteeringId));
        return Scaffold(
            body: Center(child: Text(context.strings.loadVolunteeringError)));
      },
      onError: (error, stackTrace) {
        ref.invalidate(volunteeringProvider(widget.volunteeringId));
      },
    );
  }

  bool _isProfileComplete(User user) {
    return user.fechaNacimiento != null &&
        (user.genero != null && user.genero!.isNotEmpty) &&
        (user.imagenUrl != null && user.imagenUrl!.isNotEmpty) &&
        (user.telefono != null && user.telefono!.isNotEmpty);
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    Volunteering volunteering,
    User user,
    Volunteering? participatingVolunteering,
    Future<void> Function()? onApply,
    Future<void> Function()? onWithdraw,
    Future<void> Function()? onAbandon,
  ) {
    final media = MediaQuery.of(context);

    Future<void> wrappedApply() async {
      final currentUser = ref.read(currentUserProvider).value;
      if (currentUser == null) {
        FirebaseCrashlytics.instance.recordError(
          'Current user is null when attempting to apply',
          StackTrace.current,
          reason: 'Unexpected null user in wrappedApply',
          fatal: false,
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.strings.getUserInfoError)),
          );
        }
        return;
      }

      if (_isProfileComplete(currentUser)) {
        _showConfirmModal(context, volunteering,
            () => onApply != null ? onApply() : {}, ActionType.postulate);
      } else {
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => ConfirmApplicationModal(
            message: context.strings.completeProfileFirstMessage,
            title: "",
            confirmLabel: context.strings.confirmLabel,
            onConfirm: () => Navigator.of(dialogContext).pop(true),
            onCancel: () => Navigator.of(dialogContext).pop(false),
            actionType: ActionType.postulate,
          ),
        );
        if (!context.mounted) return;

        if (confirmed == true) {
          final profileSaved =
              await GoRouter.of(context).push<bool>(AppRoutes.homeProfileEdit);
          if (!context.mounted) return;

          if (profileSaved == true) {
            ref.invalidate(currentUserProvider);
            try {
              final freshUser = await ref.read(currentUserProvider.future);
              if (!context.mounted) return;
              _showConfirmModal(
                context,
                volunteering,
                () => _handleApply(context, ref, freshUser, volunteering),
                ActionType.postulate,
              );
            } catch (e, stack) {
              FirebaseCrashlytics.instance.recordError(
                e,
                stack,
                reason:
                    'Failed to fetch fresh user after profile edit for application',
                fatal: false,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.strings.updateUserDataError)),
                );
              }
            }
          }
        }
      }
    }

    Future<void> wrappedWithdraw() async {
      if (participatingVolunteering == null) {
        return;
      }
      _showConfirmModal(context, participatingVolunteering,
          () => onWithdraw != null ? onWithdraw() : {}, ActionType.withdraw);
    }

    Future<void> wrappedAbandon() async {
      if (participatingVolunteering == null) {
        return;
      }
      _showConfirmModal(context, participatingVolunteering,
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
                      volunteering.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        FirebaseCrashlytics.instance.recordError(
                          error,
                          stackTrace,
                          reason: 'Failed to load volunteering image',
                          information: [
                            'Volunteering ID: ${volunteering.id}',
                            'Image URL: ${volunteering.imageUrl}'
                          ],
                          fatal: false,
                        );
                        return Container(
                          color: AppColors.neutral10,
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image,
                              size: 64, color: AppColors.neutral50),
                        );
                      },
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
                        Text(volunteering.type.toUpperCase(),
                            style: AppTypography.overline
                                .copyWith(color: AppColors.neutral75)),
                        const SizedBox(height: 4),
                        Text(volunteering.name,
                            style: AppTypography.headline01),
                        const SizedBox(height: 16),
                        Text(volunteering.summary,
                            style: AppTypography.body01
                                .copyWith(color: AppColors.secondary200)),
                        const SizedBox(height: 32),
                        Text(context.strings.aboutActivity,
                            style: AppTypography.headline02),
                        const SizedBox(height: 8),
                        Text(volunteering.description,
                            style: AppTypography.body01),
                        const SizedBox(height: 32),
                        _LocationCard(
                          location: volunteering.location,
                        ),
                        const SizedBox(height: 32),
                        Text(context.strings.participateVolunteering,
                            style: AppTypography.headline02),
                        const SizedBox(height: 16),
                        MarkdownBody(
                          data: volunteering.requirements,
                          styleSheet:
                              MarkdownStyleSheet.fromTheme(Theme.of(context))
                                  .copyWith(
                            p: AppTypography.body01,
                          ),
                        ),
                        const SizedBox(height: 24),
                        VacantsDisplay(number: volunteering.vacancies),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${context.strings.volunteerCostLabel}: '
                                '${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).format(volunteering.cost)}',
                                style: AppTypography.body01,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${context.strings.volunteerCreatedAtLabel}: '
                                '${DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(volunteering.createdAt)}',
                                style: AppTypography.body01,
                              ),
                            ],
                          ),
                        ),
                        _BottomSection(
                          state: _determineUserState(volunteering, user),
                          participatingVolunteering: participatingVolunteering,
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

void _showConfirmModal(BuildContext context, Volunteering volunteering,
    Function() onConfirm, ActionType actionType) {
  showDialog(
    context: context,
    builder: (context) => ConfirmApplicationModal(
      title: volunteering.name,
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
  const _BottomSection({
    required this.state,
    required this.onApply,
    required this.onWithdraw,
    required this.onAbandon,
    this.participatingVolunteering,
  });

  final Volunteering? participatingVolunteering;
  final VolunteeringUserState state;
  final Future<void> Function() onApply;
  final Future<void> Function() onWithdraw;
  final Future<void> Function() onAbandon;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case VolunteeringUserState.available ||
            VolunteeringUserState.rejected ||
            VolunteeringUserState.completed:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppButton(
              label: context.strings.applyButton,
              onPressed: onApply,
              type: AppButtonType.filled,
            ),
          ],
        );

      case VolunteeringUserState.pending:
        return _InfoWithLink(
          title: context.strings.appliedTitle,
          subtitle: context.strings.appliedSubtitle,
          linkLabel: context.strings.withdrawApplication,
          onLinkPressed: onWithdraw,
        );

      case VolunteeringUserState.accepted:
        return _InfoWithLink(
          title: context.strings.participatingTitle,
          subtitle: context.strings.participatingSubtitle,
          linkLabel: context.strings.leaveVolunteering,
          onLinkPressed: onAbandon,
        );

      case VolunteeringUserState.full:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.strings.noVacanciesMessage,
              style: AppTypography.body01,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: context.strings.applyButton,
              onPressed: null, // disabled
              type: AppButtonType.filled,
            ),
          ],
        );

      case VolunteeringUserState.busyOther ||
            VolunteeringUserState.busyOtherPending:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.strings.alreadyParticipating,
              style: AppTypography.body01,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: state == VolunteeringUserState.busyOtherPending
                  ? onWithdraw
                  : onAbandon,
              child: Text(context.strings.leaveCurrentVolunteering,
                  style: AppTypography.button
                      .copyWith(color: AppColors.primary100)),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: context.strings.applyButton,
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
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to get address from coordinates',
        information: [
          'Latitude: ${widget.location.latitude}',
          'Longitude: ${widget.location.longitude}'
        ],
        fatal: false,
      );
      if (!mounted) return;
      setState(() => _address = 'No se pudo obtener la dirección');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error al cargar la dirección. Intenta de nuevo.')),
      );
    }
  }

  void _openNativeMaps() {
    try {
      MapsLauncher.launchCoordinates(
        widget.location.latitude,
        widget.location.longitude,
      );
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(
        e,
        stack,
        reason: 'Failed to launch native maps',
        information: [
          'Latitude: ${widget.location.latitude}',
          'Longitude: ${widget.location.longitude}'
        ],
        fatal: false,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'No se pudo abrir el mapa. Asegúrate de tener una aplicación de mapas instalada.')),
        );
      }
    }
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
            child: Text(context.strings.location, style: AppTypography.subtitle01),
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
                 Text(context.strings.address, style: AppTypography.overline),
                const SizedBox(height: 4),
                Text(_address ?? context.strings.loadingMessage,
                    style: AppTypography.body01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

VolunteeringUserState _determineUserState(
    Volunteering volunteering, User user) {
  // Safely find the user's volunteering without throwing exceptions
  final userVolunteering = user.volunteerings?.firstWhereOrNull(
    (v) => v.id == volunteering.id,
  );

  if (userVolunteering != null) {
    return userVolunteering.estado;
  }

  if (user.volunteerings
          ?.any((v) => v.estado == VolunteeringUserState.accepted) ??
      false) {
    return VolunteeringUserState.busyOther;
  }

  if (user.volunteerings
          ?.any((v) => v.estado == VolunteeringUserState.pending) ??
      false) {
    return VolunteeringUserState.busyOtherPending;
  }

  if (volunteering.vacancies <= 0) {
    return VolunteeringUserState.full;
  }

  return VolunteeringUserState.available;
}
