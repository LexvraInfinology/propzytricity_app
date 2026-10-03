import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

/// One option in a [ChoiceCardGroup].
class ChoiceItem<T> {
  const ChoiceItem({
    required this.value,
    required this.title,
    required this.description,
    required this.icon,
  });

  final T value;
  final String title;
  final String description;
  final String icon;
}

/// Selectable card with an icon, title, short description and a radio mark.
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.04)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.primaryLight : AppColors.otpBorderColor,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: AppSvg(icon, size: 16, color: AppColors.primaryLight),
                ),
                _RadioMark(selected: selected),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: FontFamily.plusJakartaSansBold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
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

class _RadioMark extends StatelessWidget {
  const _RadioMark({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.primaryLight : AppColors.otpBorderColor,
          width: selected ? 2 : 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: selected ? 10 : 0,
        width: selected ? 10 : 0,
        decoration: const BoxDecoration(
          color: AppColors.primaryLight,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Single-choice group laid out in rows of [columns] cards. Cards in the same
/// row always have the same height, even when one description is longer.
///
/// With GetX, pass `selected` from inside the Obx closure
/// (`selected: controller.goal.value`) so the Obx tracks it.
class ChoiceCardGroup<T> extends StatelessWidget {
  const ChoiceCardGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
    this.columns = 2,
    this.spacing = 12,
  });

  final List<ChoiceItem<T>> items;
  final T? selected;
  final ValueChanged<T> onSelected;
  final int columns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var start = 0; start < items.length; start += columns) {
      if (rows.isNotEmpty) rows.add(SizedBox(height: spacing));

      final cells = <Widget>[];
      for (var i = 0; i < columns; i++) {
        if (i > 0) cells.add(SizedBox(width: spacing));

        final index = start + i;
        if (index >= items.length) {
          cells.add(const Expanded(child: SizedBox.shrink()));
          continue;
        }

        final item = items[index];
        cells.add(
          Expanded(
            child: ChoiceCard(
              icon: item.icon,
              title: item.title,
              description: item.description,
              selected: item.value == selected,
              onTap: () => onSelected(item.value),
            ),
          ),
        );
      }

      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cells,
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}
