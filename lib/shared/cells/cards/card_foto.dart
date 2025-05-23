// lib/shared/cells/cards/card_foto.dart

import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

// IMPORT CORRECTO de tu ShortButton y tu FotoPerfil
import '../../../shared/molecules/buttons/short_button.dart';
import '../../../shared/molecules/components/foto_perfil.dart';

/// Tarjeta para foto de perfil:
/// - Si [imageUrl] != null: altura 100, márgenes V=16, botón "Cambiar foto" + avatar.
/// - Si [imageUrl] == null: altura 52, márgenes V=14, botón "Subir foto" solo.
class CardFotoPerfil extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onChange;

  const CardFotoPerfil({
    super.key,
    this.imageUrl,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = imageUrl != null;

    return Container(
      margin: EdgeInsets.symmetric(vertical: hasPhoto ? 16 : 14),
      width: double.infinity,
      height: hasPhoto ? 100 : 52,
      decoration: BoxDecoration(
        color: AppColors.secondary25,
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: hasPhoto
          ? Row(
        children: [
          // COLUMNA que agrupa texto + botón
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Foto de perfil',
                  style: AppTypography.subtitle01.copyWith(
                    color: AppColors.neutral100,
                  ),
                ),
                const SizedBox(height: 8),
                // Botón con alto fijo de 36
                SizedBox(
                  height: 36,
                  child: ShortButton(
                    label: 'Cambiar foto',
                    onPressed: onChange,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // avatar
          FotoPerfil.sm(imageUrl: imageUrl!),
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
          SizedBox(
            height: 36,
            child: ShortButton(
              label: 'Subir foto',
              onPressed: onChange,
            ),
          ),
        ],
      ),
    );
  }
}
