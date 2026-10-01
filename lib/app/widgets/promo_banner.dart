import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

/// Light green strip with an icon, two lines of text and an arrow button.
class PromoBanner extends StatelessWidget {
  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon = AppIcons.apartmentIcon,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppSvg(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.textWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
