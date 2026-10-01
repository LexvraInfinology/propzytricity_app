import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

import '../theme/app_colors.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
     this.borderOn = false,
  });

    final String icon;
    final bool borderOn;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: borderOn ? Border.all(color: AppColors.primaryLight.withValues(alpha: 0.12)):null,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppSvg(icon, size: 16, color: AppColors.primaryLight),
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
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11,
                      fontFamily: FontFamily.plusJakartaSansRegular,
                      color: AppColors.textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
