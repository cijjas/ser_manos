import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/typography.dart';
import '../../tokens/colors.dart';

enum ActionType {
  postulate,
  withdraw,
  abandon,
  logout;

  String getMessage(BuildContext context) {
    switch (this) {
      case ActionType.postulate:
        return context.strings.postulateActionMessage;
      case ActionType.withdraw:
        return context.strings.withdrawActionMessage;
      case ActionType.abandon:
        return context.strings.abandonActionMessage;
      case ActionType.logout:
        return context.strings.logoutConfirmTitle;
    }
  }
}

class ConfirmApplicationModal extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final ActionType actionType;

  final String? confirmLabel;
  final String? cancelLabel;
  final String? message;

  const ConfirmApplicationModal({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
    required this.actionType,
    this.confirmLabel,
    this.cancelLabel,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final String effectiveMessage = message ?? actionType.getMessage(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 280,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        color: AppColors.neutral0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (effectiveMessage.isNotEmpty) ...[
              Text(
                effectiveMessage,
                style: AppTypography.subtitle01.copyWith(color: AppColors.neutral100),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
            ],
            if (title.isNotEmpty)
              Text(
                title,
                style: AppTypography.headline02.copyWith(color: AppColors.neutral100),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelLabel ?? context.strings.cancel,
                    onPressed: onCancel,
                    type: AppButtonType.tonal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    label: confirmLabel ?? context.strings.confirm,
                    onPressed: onConfirm,
                    type: AppButtonType.tonal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}