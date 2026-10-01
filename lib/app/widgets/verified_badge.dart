import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key, this.label = 'Verified'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified, size: 13, color: AppColors.primaryLight),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
