import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ser_manos/constants/app_assets.dart';
import '../../../utils/app_strings.dart';

import '../../molecules/buttons/short_button.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../cells/modals/confirm_modal.dart';

class IncompleteProfilePage extends StatelessWidget {
  const IncompleteProfilePage({
    super.key,
    required this.name,
    this.role = 'Voluntario',
    required this.onCompletePressed,
    required this.onLogoutPressed,
  });

  final String name;
  final String role;
  final VoidCallback onCompletePressed;
  final VoidCallback onLogoutPressed;

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
    return Container(
      color: AppColors.neutral0,
      width: double.infinity,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: SvgPicture.asset(
                        AppAssets.profile,
                        width: 100,
                        height: 100,
                        semanticsLabel: 'Avatar placeholder',
                        colorFilter: const ColorFilter.mode(
                          AppColors.secondary100,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 328,
                      height: 96,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 328,
                            height: 16,
                            child: Text(
                              role.toUpperCase(),
                              style: AppTypography.overline.copyWith(
                                color: AppColors.neutral75,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 328,
                            height: 24,
                            child: Text(
                              name,
                              style: AppTypography.subtitle01.copyWith(
                                color: AppColors.neutral100,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 328,
                            height: 40,
                            child: Text(
                              context.strings.completeProfileMessage,
                              style: AppTypography.body02.copyWith(
                                color: AppColors.neutral75,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Container(
                width: 328,
                height: 128,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  children: [
                    Center(
                      child: ShortButton(
                        label: context.strings.complete,
                        icon: Icons.add,
                        onPressed: onCompletePressed,
                        variant: ShortButtonVariant.regular,
                        height: 48,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 308,
                      height: 44,
                      child: AppButton(
                        label: context.strings.logoutButton,
                        onPressed: () => _showLogoutModal(context),
                        type: AppButtonType.tonal,
                        textColor: AppColors.error100,
                      ),
                    ),
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
