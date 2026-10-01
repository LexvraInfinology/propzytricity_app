import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/locality_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

/// Photo tile with the locality name and property count over a dark gradient.
class LocalityCard extends StatelessWidget {
  const LocalityCard({
    super.key,
    required this.locality,
    required this.onTap,
    this.width = 140,
    this.height = 160,
  });

  final LocalityModel locality;
  final VoidCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AssetPhoto(locality.image),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.4, 1],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      locality.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      locality.countLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: FontFamily.plusJakartaSansMedium,
                        color: AppColors.textWhite.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
