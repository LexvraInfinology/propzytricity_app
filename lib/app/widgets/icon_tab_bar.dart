import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class IconTabItem {
  const IconTabItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class IconTabBar extends StatelessWidget {
  const IconTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<IconTabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.otpBorderColor)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            Expanded(child: _TabButton(item: tabs[i], selected: i == selectedIndex, onTap: () => onTap(i))),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.item, required this.selected, required this.onTap});

  final IconTabItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryLight : AppColors.textGrey;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.primaryLight : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
