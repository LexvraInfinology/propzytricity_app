import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Placeholder for tabs that are not built yet.
class ComingSoonTab extends StatelessWidget {
  const ComingSoonTab({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.primary.withValues(alpha: 0.5)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: FontFamily.plusJakartaSansBold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Coming soon',
              style: TextStyle(
                fontSize: 13,
                fontFamily: FontFamily.plusJakartaSansRegular,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
