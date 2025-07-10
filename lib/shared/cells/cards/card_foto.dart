import 'dart:io';
import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';
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
    final bool hasRemoteImage =
        imagenUrlRemota != null && imagenUrlRemota!.isNotEmpty;
    final bool hasAnyImage = hasLocalImage || hasRemoteImage;

    return Container(
      width: double.infinity,
      height: hasAnyImage ? 100 : 52,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.secondary25,
        borderRadius: BorderRadius.circular(4),
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
                        context.strings.profilePhoto,
                        style: AppTypography.subtitle01.copyWith(
                          color: AppColors.neutral100,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 107,
                        height: 36,
                        child: ShortButton(
                          label: context.strings.changePhoto,
                          onPressed: isLoading ? null : onChange,
                          variant: ShortButtonVariant.compact,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 84,
                  height: 84,
                  child: FotoPerfil.sm(
                    imageUrl: hasLocalImage ? null : imagenUrlRemota,
                    localImageFile: imagenLocal,
                    onTap: isLoading ? null : onChange,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 24,
                    child: Text(
                      context.strings.profilePhoto,
                      style: AppTypography.subtitle01.copyWith(
                        color: AppColors.neutral100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 36,
                  child: ShortButton(
                    label: context.strings.uploadPhoto,
                    onPressed: isLoading ? null : onChange,
                    variant: ShortButtonVariant.compact,
                  ),
                ),
              ],
            ),
    );
  }
}
