import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// User photo, or the initials when there is no photo. Optional camera badge.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.imagePath,
    this.size = 56,
    this.showCameraBadge = false,
    this.onTap,
  });

  final String name;
  final String? imagePath;
  final double size;
  final bool showCameraBadge;
  final VoidCallback? onTap;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

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
            ClipOval(
              child: SizedBox(
                height: size,
                width: size,
                child: imagePath != null
                    ? AssetPhoto(imagePath!)
                    : Container(
                        alignment: Alignment.center,
                        color: AppColors.primary.withValues(alpha: 0.12),
                        child: Text(
                          _initials,
                          style: TextStyle(
                            fontSize: size * 0.34,
                            fontFamily: FontFamily.plusJakartaSansBold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
            ),
            if (showCameraBadge)
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  height: size * 0.34,
                  width: size * 0.34,
                  decoration: BoxDecoration(
                    color: AppColors.textLightBlack,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(
                    Icons.photo_camera_rounded,
                    size: size * 0.17,
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
