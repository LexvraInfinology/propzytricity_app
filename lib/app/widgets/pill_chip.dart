import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Rounded chip used for category tabs ("All", "Apartment") and for filter
/// dropdowns ("Budget v").
///
/// - `selected` + default look: solid dark green (category tabs).
/// - `selected` + `soft: true`: light green tint (an applied filter).
/// - `showChevron`: adds the small dropdown arrow.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    required this.onTap,
    this.selected = false,
    this.soft = false,
    this.showChevron = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool soft;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color borderColor;
    final Color foreground;

    if (selected && soft) {
      background = AppColors.primaryLight.withValues(alpha: 0.08);
      borderColor = AppColors.primaryLight;
      foreground = AppColors.primaryLight;
    } else if (selected) {
      background = AppColors.primaryLight;
      borderColor = AppColors.primaryLight;
      foreground = AppColors.textWhite;
    } else {
      background = Colors.white;
      borderColor = AppColors.otpBorderColor;
      foreground = AppColors.textLightBlack;
    }

    return Material(
      color: background,
      shape: StadiumBorder(side: BorderSide(color: borderColor)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: selected
                      ? FontFamily.plusJakartaSansSemiBold
                      : FontFamily.plusJakartaSansMedium,
                  color: foreground,
                ),
              ),
              if (showChevron) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 16,
                  color: foreground,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
