import 'package:flutter/material.dart';
import '../../molecules/buttons/app_button.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';
import '../../tokens/colors.dart';

enum ActionType {
  postulate("Te estas por postular a"),
  withdraw("¿Estás seguro de que quieres retirar tu postulación?"),
  abandon("¿Estás seguro de que quieres abandonar tu voluntariado?");

  final String message;
  const ActionType(this.message);
}

class ConfirmApplicationModal extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final ActionType actionType;

  const ConfirmApplicationModal({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
    required this.actionType,
  });
  @override
  Widget build(BuildContext context) {
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
            Text(
              actionType.message,
              style: AppTypography.subtitle01.copyWith(color: AppColors.neutral100),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
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
                    label: 'Cancelar',
                    onPressed: onCancel,
                    type: AppButtonType.tonal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    label: 'Confirmar',
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