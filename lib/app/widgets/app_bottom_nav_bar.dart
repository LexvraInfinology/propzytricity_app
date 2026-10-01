import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

class NavBarItem {
  const NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.badge = 0,
  });

  final String icon;
  final String activeIcon;
  final String label;

  /// Shows a small count bubble when > 0.
  final int badge;
}

/// Bottom navigation with icon, label and optional count badge.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<NavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.otpBorderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 62,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavButton(
                    item: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final NavBarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryLight : AppColors.textGrey;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AppSvg(selected ? item.activeIcon : item.icon, size: 20, color: color),
              if (item.badge > 0)
                Positioned(
                  right: -8,
                  top: -4,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 16),
                    height: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      '${item.badge}',
                      style: const TextStyle(
                        fontSize: 9,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textWhite,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: selected
                  ? FontFamily.plusJakartaSansSemiBold
                  : FontFamily.plusJakartaSansMedium,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
