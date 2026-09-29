import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

/// One choice in an [OptionGrid].
class OptionItem<T> {
  const OptionItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final T value;
  final String label;
  final String icon;
}

/// Selectable card: icon + label, with a check badge in the corner.
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.onBoardingIndicatorColor.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.onBoardingIndicatorColor : AppColors.otpBorderColor,
            width: selected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSvg(
                      icon,
                      size: 22,
                      color: selected
                          ? AppColors.onBoardingIndicatorColor
                          : AppColors.textLightBlack,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.5,
                        height: 1.2,
                        fontFamily: selected
                            ? FontFamily.plusJakartaSansSemiBold
                            : FontFamily.plusJakartaSansMedium,
                        color: selected
                            ? AppColors.onBoardingIndicatorColor
                            : AppColors.textLightBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _CheckBadge(selected: selected),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBadge extends StatelessWidget {
  const _CheckBadge({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        color: selected ? AppColors.onBoardingIndicatorColor : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? AppColors.onBoardingIndicatorColor : AppColors.otpBorderColor,
        ),
      ),
      child: selected
          ? const Icon(Icons.check_rounded, size: 12, color: AppColors.textWhite)
          : null,
    );
  }
}

/// Grid of [OptionTile]s. Selection rules (single or multiple) live in the
/// caller: pass the currently [selected] values and handle [onTap].
///
/// With GetX, build the `selected` set inside the Obx closure
/// (`controller.types.toSet()`) so the Obx tracks it.
class OptionGrid<T> extends StatelessWidget {
  const OptionGrid({
    super.key,
    required this.items,
    required this.selected,
    required this.onTap,
    this.columns = 3,
    this.aspectRatio = 1.2,
  });

  final List<OptionItem<T>> items;
  final Set<T> selected;
  final ValueChanged<T> onTap;
  final int columns;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: aspectRatio,
      children: [
        for (final item in items)
          OptionTile(
            icon: item.icon,
            label: item.label,
            selected: selected.contains(item.value),
            onTap: () => onTap(item.value),
          ),
      ],
    );
  }
}
