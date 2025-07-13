import 'dart:io';
import 'package:flutter/material.dart';
import '../../../utils/app_strings.dart';
import '../../tokens/colors.dart';
import '../../tokens/typography.dart';
import '../../molecules/buttons/short_button.dart';
import '../../molecules/components/profile_picture.dart';

class ProfilePictureCard extends StatelessWidget {
  final String? remoteImageUrl;
  final File? localImage;
  final VoidCallback onChange;
  final bool isLoading;

  const ProfilePictureCard({
    super.key,
    this.remoteImageUrl,
    this.localImage,
    required this.onChange,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasLocalImage = localImage != null;
    final bool hasRemoteImage =
        remoteImageUrl != null && remoteImageUrl!.isNotEmpty;
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
                      ShortButton(
                        label: context.strings.changePhoto,
                        onPressed: isLoading ? null : onChange,
                        variant: ShortButtonVariant.compact,
                        height: 36,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 84,
                  height: 84,
                  child: ProfilePicture.sm(
                    imageUrl: hasLocalImage ? null : remoteImageUrl,
                    localImageFile: localImage,
                    onTap: isLoading ? null : onChange,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
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
                ShortButton(
                  label: context.strings.uploadPhoto,
                  onPressed: isLoading ? null : onChange,
                  variant: ShortButtonVariant.compact,
                  height: 36,
                ),
              ],
            ),
    );
  }
}
