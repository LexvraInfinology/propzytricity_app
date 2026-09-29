import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

/// Round avatar placeholder with a camera badge. Pass [image] once a photo
/// has been picked.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    required this.onTap,
    this.image,
    this.size = 96,
  });

  final VoidCallback onTap;
  final ImageProvider? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: AppColors.otpBorderColor,
                shape: BoxShape.circle,
                image: image == null
                    ? null
                    : DecorationImage(image: image!, fit: BoxFit.cover),
              ),
              child: image == null
                  ? Icon(
                      Icons.person_rounded,
                      size: size * 0.55,
                      color: AppColors.textWhite,
                    )
                  : null,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.backgroundLight,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.photo_camera_rounded,
                  size: 14,
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
