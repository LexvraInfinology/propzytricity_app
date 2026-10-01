import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

/// Row card: icon tile, bold title and a one-line description.
class BenefitTile extends StatelessWidget {
  const BenefitTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.otpBorderColor),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppSvg(icon, size: 15, color: AppColors.primary),
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
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    fontFamily: FontFamily.plusJakartaSansRegular,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
