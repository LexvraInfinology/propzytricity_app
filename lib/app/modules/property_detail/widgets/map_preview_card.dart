import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Static map picture with a pin and the address under it.
/// (Swap [image] for a real map widget when you add Google Maps.)
class MapPreviewCard extends StatelessWidget {
  const MapPreviewCard({
    super.key,
    required this.image,
    required this.address,
    this.onTap,
  });

  final String image;
  final String address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.otpBorderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AssetPhoto(image),
                  Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.home_rounded,
                        size: 18,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontFamily: FontFamily.plusJakartaSansMedium,
                        color: AppColors.textLightBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
