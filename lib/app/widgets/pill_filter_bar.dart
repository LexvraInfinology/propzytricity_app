import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

import '../theme/app_colors.dart';

/// Horizontally scrollable single-select pill filters.
class PillFilterBar extends StatelessWidget {
  const PillFilterBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: labels.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryLight : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.primaryLight : AppColors.otpBorderColor,
                ),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? AppColors.textWhite : AppColors.textLightBlack,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TagPill extends StatelessWidget {
  const TagPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.textGrey.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10.5,
          fontFamily: FontFamily.plusJakartaSansRegular,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}