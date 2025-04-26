import 'package:flutter/material.dart';
import '../../tokens/shadow.dart';
import '../../tokens/typography.dart';
import '../../tokens/colors.dart';
import '../buttons/app_button.dart';

class ConfirmApplicationModal extends StatelessWidget {
  final String title;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmApplicationModal({
    super.key,
    required this.title,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material( // <--- very important inside a dialog
        color: Colors.transparent,
        child: Container(
          width: 280,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: AppShadows.shadow3,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Te estas por postular a',
                style: AppTypography.subtitle01.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: AppTypography.headline02.copyWith(
                  color: AppColors.neutral100,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: 'Cancelar',
                    onPressed: onCancel,
                    type: AppButtonType.tonal,
                    fillWidth: false,
                    widthType: AppButtonWidthType.hug,
                  ),
                  const SizedBox(width: 8),
                  AppButton(
                    label: 'Confirmar',
                    onPressed: onConfirm,
                    type: AppButtonType.tonal,
                    fillWidth: false,
                    widthType: AppButtonWidthType.hug,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}