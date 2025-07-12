import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../cells/modals/confirm_modal.dart';
import '../../molecules/components/profile_picture.dart';
import '../../cells/cards/information_card.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class FullProfilePage extends StatelessWidget {
  final VoidCallback onLogoutPressed;

  const FullProfilePage({
    super.key,
    required this.imageUrl,
    required this.role,
    required this.name,
    required this.email,
    required this.contactEmail,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.onLogoutPressed,
  });

  final String imageUrl;
  final String role;
  final String name;
  final String email;
  final String contactEmail;
  final String birthDate;
  final String gender;
  final String phone;

  void _showLogoutModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmApplicationModal(
              title: context.strings.logoutConfirmTitle,
              message: '',
              confirmLabel: context.strings.logoutButton,
              cancelLabel: context.strings.cancel,
              onConfirm: () {
                Navigator.pop(context);
                onLogoutPressed();
              },
              onCancel: () => Navigator.pop(context),
              actionType: ActionType.logout,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral0,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    ProfilePicture.lg(
                      imageUrl: imageUrl.isNotEmpty ? imageUrl : null,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      role.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.neutral75,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      email,
                      style: AppTypography.body01.copyWith(
                        color: AppColors.secondary200,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    InformationCard(
                      title: context.strings.personalInformation,
                      label1: context.strings.birthDate,
                      content1: birthDate,
                      label2: context.strings.gender,
                      content2: gender,
                    ),
                    const SizedBox(height: 24),
                    InformationCard(
                      title: context.strings.contactData,
                      label1: context.strings.phone,
                      content1: phone,
                      label2: context.strings.email,
                      content2: contactEmail,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    AppButton(
                      label: context.strings.editProfile,
                      onPressed: () {
                        context.push(AppRoutes.homeProfileEdit);
                      },
                      type: AppButtonType.filled,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: context.strings.logoutButton,
                      onPressed: () => _showLogoutModal(context),
                      type: AppButtonType.tonal,
                      textColor: AppColors.error100,
                    ),
                    const SizedBox(height: 24),
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
