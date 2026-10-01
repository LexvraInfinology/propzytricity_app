import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

class ChatStatusBanner extends StatelessWidget {
  const ChatStatusBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = AppIcons.verifiedIcon,
  });

  final String title;
  final String subtitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSvg(icon, size: 24,),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:  const TextStyle(
                    fontSize: 13,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textLightBlack,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.plusJakartaSansRegular,
                      height: 1.35, color: AppColors.textGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
