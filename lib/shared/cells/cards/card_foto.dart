import 'package:flutter/material.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';

import '../../../shared/molecules/buttons/short_button.dart';
import '../../../shared/molecules/components/foto_perfil.dart';

/// Tarjeta para foto de perfil:
/// - Si [imageUrl] != null: altura 100, márgenes V=16, botón "Cambiar foto" + avatar.
/// - Si [imageUrl] == null: altura 52, márgenes V=14, botón "Subir foto" solo.
/// - Si [isLoading] == true: muestra spinner y desactiva botón.
class CardFotoPerfil extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onChange;
  final bool isLoading; // ← NUEVO

  const CardFotoPerfil({
    super.key,
    this.imageUrl,
    required this.onChange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = imageUrl != null;

    Widget _buildButton(String label) => SizedBox(
      height: 36,
      child: ShortButton(
        label: label,
        onPressed: isLoading ? null : onChange,
        isLoading: isLoading, // si tu ShortButton soporta loader
      ),
    );

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
      child: isLoading
          ? Center(
        child: SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primary100,
          ),
        ),
      )
          : hasPhoto
          ? Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Foto de perfil',
                    style: AppTypography.subtitle01
                        .copyWith(color: AppColors.neutral100)),
                const SizedBox(height: 8),
                _buildButton('Cambiar foto'),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FotoPerfil.sm(imageUrl: imageUrl!),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Foto de perfil',
              style: AppTypography.subtitle01
                  .copyWith(color: AppColors.neutral100)),
          _buildButton('Subir foto'),
        ],
      ),
    );
  }
}
