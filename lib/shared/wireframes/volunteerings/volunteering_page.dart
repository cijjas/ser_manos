// volunteering_page.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ser_manos/shared/tokens/colors.dart';
import 'package:ser_manos/shared/wireframes/volunteerings/volunteering_list.dart';
import 'package:ser_manos/utils/app_strings.dart';

import '../../../constants/app_routes.dart';
import '../../../models/volunteering.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/volunteering_provider.dart';
import '../../cells/cards/current_volunteering_card.dart';
import '../../molecules/input/search_field.dart';
import '../../../utils/debounced_async_builder.dart';
import '../../tokens/typography.dart';

class VolunteeringsPage extends ConsumerWidget {
  const VolunteeringsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: AppColors.secondary10,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SearchAndToggleViewHeader(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    ParticipatingVolunteeringSection(),
                    VolunteeringsListSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchAndToggleViewHeader extends ConsumerStatefulWidget {
  const SearchAndToggleViewHeader({super.key});

  @override
  ConsumerState<SearchAndToggleViewHeader> createState() =>
      _SearchAndToggleViewHeaderState();
}

class _SearchAndToggleViewHeaderState
    extends ConsumerState<SearchAndToggleViewHeader> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(volunteeringSearchQueryProvider.notifier).state = query;
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchField(
      hintText: context.strings.searchHint,
      onChanged: _onSearchChanged,
    );
  }
}

final lastVolunteeringProvider = StateProvider<Volunteering?>((ref) => null);

class ParticipatingVolunteeringSection extends ConsumerWidget {
  const ParticipatingVolunteeringSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participatingVolunteering =
        ref.watch(volunteeringParticipatingProvider);
    final lastVolunteering = ref.watch(lastVolunteeringProvider);

    return participatingVolunteering.whenDebounced(
      data: (volunteering) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(lastVolunteeringProvider.notifier).state = volunteering;
        });
        if (volunteering == null) return const SizedBox();
        return buildParticipatingVolunteering(context, volunteering);
      },
      error: (e, _) => VolunteeringError(
          message: context.strings.loadActivityError),
      loading: () {
        if (lastVolunteering != null) {
          return buildParticipatingVolunteering(context, lastVolunteering);
        }
        return const SizedBox();
      },
      onError: (error, stackTrace) {
        ref.invalidate(volunteeringParticipatingProvider);
      },
    );
  }
}

Widget buildParticipatingVolunteering(BuildContext context, Volunteering volunteering) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(context.strings.yourActivity, style: AppTypography.headline01),
      const SizedBox(height: 16),
      SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: CardVolunteeringActual(
          volunteering: volunteering,
          onTap: () => context.pushNamed(
            RouteNames.volunteeringDetails,
            pathParameters: {'id': volunteering.id},
          ),
        ),
      ),
    ],
  );
}

class VolunteeringsListSection extends ConsumerWidget {
  const VolunteeringsListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final volunteeringsAsync = ref.watch(volunteeringsProvider);
    final user = ref.watch(currentUserProvider).value;
    final isSearching = ref.watch(volunteeringSearchQueryProvider).isNotEmpty;

    Future<void> onLikeTap(WidgetRef ref, String volunteeringId) async {
      if (user == null) {
        return;
      }
      await ref
          .read(userServiceProvider)
          .toggleLikeVolunteering(user, volunteeringId);
    }

    return volunteeringsAsync.whenDebounced(
      data: (volunteerings) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.strings.volunteering, style: AppTypography.headline01),
          const SizedBox(height: 16),
          VolunteeringListItems(
              volunteerings: volunteerings,
              isSearching: isSearching,
              user: user,
              onLikeTap: (id) => onLikeTap(ref, id)),
          const SizedBox(height: 16),
        ],
      ),
      loading: () => const VolunteeringLoading(),
      error: (error, stackTrace) => VolunteeringError(
          message: context.strings.loadVolunteeringError),
      onError: (error, stackTrace) {
        ref.invalidate(volunteeringsProvider);
      },
    );
  }
}

class VolunteeringError extends StatelessWidget {
  final String message;

  const VolunteeringError({
    super.key,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0),
      child: Center(
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }
}

class VolunteeringLoading extends StatelessWidget {
  const VolunteeringLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 64.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
