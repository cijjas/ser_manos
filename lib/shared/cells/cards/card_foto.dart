import 'dart:io';
import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../molecules/buttons/short_button.dart';
import '../../molecules/components/foto_perfil.dart';

class CardFotoPerfil extends StatelessWidget {
  final String? imagenUrlRemota;
  final File? imagenLocal;
  final VoidCallback onChange;
  final bool isLoading;

  const CardFotoPerfil({
    super.key,
    this.imagenUrlRemota,
    this.imagenLocal,
    required this.onChange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Priorizar imagen local sobre la remota
    final bool hasLocalImage = imagenLocal != null;
    final bool hasRemoteImage = imagenUrlRemota != null && imagenUrlRemota!.isNotEmpty;
    final bool hasAnyImage = hasLocalImage || hasRemoteImage;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondary25,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasAnyImage
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Foto de perfil',
                  style: AppTypography.subtitle01.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                const SizedBox(height: 8),
                ShortButton(
                  label: 'Cambiar foto',
                  onPressed: isLoading ? null : onChange,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          FotoPerfil.sm(
            imageUrl: hasLocalImage ? null : imagenUrlRemota,
            localImageFile: imagenLocal,
            onTap: isLoading ? null : onChange,
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Foto de perfil',
            style: AppTypography.subtitle01.copyWith(
              color: AppColors.neutral100,
            ),
          ),
          ShortButton(
            label: 'Subir foto',
            onPressed: isLoading ? null : onChange,
          ),
        ],
      ),
    );
  }
}