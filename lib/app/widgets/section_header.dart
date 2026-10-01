import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Section title with an optional subtitle and a "See all" action.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
    this.seeAllLabel = 'See all',
    this.titleFontSize = 18
  });

  final String title;
  final double titleFontSize;
  final String? subtitle;
  final VoidCallback? onSeeAll;
  final String seeAllLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: FontFamily.plusJakartaSansRegular,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(top: 3, left: 12),
              child: Text(
                seeAllLabel,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontFamily: FontFamily.plusJakartaSansSemiBold,
                  color: AppColors.primaryLight,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
