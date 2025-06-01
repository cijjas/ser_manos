
// lib/shared/cells/cards/card_foto.dart
import 'dart:io';

import 'package:flutter/material.dart';

import '../../tokens/colors.dart'; // Asegúrate que la ruta es correcta
import '../../tokens/typography.dart'; // Asegúrate que la ruta es correcta
import '../../molecules/buttons/short_button.dart'; // Asegúrate que la ruta es correcta
import '../../molecules/components/foto_perfil.dart'; // Asegúrate que la ruta es correcta


class CardFotoPerfil extends StatelessWidget {
  final String? imagenUrlRemota; // URL de la imagen ya guardada
  final File? imagenLocal;      // Archivo de imagen local seleccionado
  final VoidCallback onChange;
  final bool isLoading;         // Indica si el proceso general de guardado está en curso

  const CardFotoPerfil({
    super.key,
    this.imagenUrlRemota,
    this.imagenLocal,
    required this.onChange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determinar si hay alguna foto para mostrar (local o remota)
    final bool hasPhoto = imagenLocal != null || (imagenUrlRemota != null && imagenUrlRemota!.isNotEmpty);
    final String buttonLabel = hasPhoto ? 'Cambiar foto' : 'Subir foto';

    Widget buildButton(String label) => SizedBox(
      height: 36,
      child: ShortButton(
        label: label,
        onPressed: isLoading ? null : onChange, // Deshabilitar si está cargando
        // Si tu ShortButton soporta un estado de carga interno, podrías usarlo aquí
        // isLoading: isLoading,
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondary25,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasPhoto
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
            imageUrl: imagenUrlRemota,
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