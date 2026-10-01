import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Icon in a tinted square with a label under it (home page categories).
class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: selected ? 0.16 : 0.08),
              borderRadius: BorderRadius.circular(16),
              border: selected
                  ? Border.all(color: AppColors.primaryLight, width: 1.2)
                  : null,
            ),
            child: Icon(icon, size: 26, color: AppColors.primaryLight),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 76,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.25,
                fontFamily: FontFamily.plusJakartaSansMedium,
                color: AppColors.textLightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
