import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

class CardInformacion extends StatelessWidget {
  final String title;
  final String label1;
  final String content1;
  final String label2;
  final String content2;

  const CardInformacion({
    super.key,
    required this.title,
    required this.label1,
    required this.content1,
    required this.label2,
    required this.content2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 136,
      decoration: BoxDecoration(
        color: AppColors.neutral10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [

          // Header
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: const BoxDecoration(
              color: AppColors.secondary25,
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppTypography.subtitle01,
            ),
          ),

          // Info items
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoItem(label1, content1),
                  _InfoItem(label2, content2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.overline.copyWith(
            color: AppColors.neutral75,
          ),
        ),
        Text(
          value,
          style: AppTypography.body01,
        ),
      ],
    );
  }
}