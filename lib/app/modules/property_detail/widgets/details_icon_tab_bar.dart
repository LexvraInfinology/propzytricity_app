import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/icon_tab_bar.dart';

class DetailsIconTabItem {
  const DetailsIconTabItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Row of tabs, each with an icon, a label and an underline when selected.
class DetailsIconTabBar extends StatelessWidget {
  const DetailsIconTabBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<IconTabItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++)
          Expanded(
            child: _TabButton(
              item: items[i],
              selected: i == selectedIndex,
              onTap: () => onTap(i),
            ),
          ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final IconTabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textGrey;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, size: 15, color: color),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: selected
                          ? FontFamily.plusJakartaSansSemiBold
                          : FontFamily.plusJakartaSansMedium,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2.5,
              width: 32,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
