import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Dropdown with the label ABOVE the box (Edit Profile style).
/// Same look as [LabeledInputField], so they line up in one form.
class LabeledSelectField<T> extends StatelessWidget {
  const LabeledSelectField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.prefixIcon,
    this.hint = 'Select',
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T item) itemLabel;
  final IconData? prefixIcon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.body.copyWith(
        fontSize: 12,
        fontFamily: FontFamily.plusJakartaSansMedium,
        color: AppColors.textBlack
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: FontFamily.plusJakartaSansMedium,
            color: AppColors.textLightBlack,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.otpBorderColor),
          ),
          child: Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(prefixIcon, size: 17, color: AppColors.primary),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    value: value,
                    isExpanded: true,
                    isDense: true,
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textGrey,
                    ),
                    style: textStyle,
                    hint: Text(
                      hint,
                      style: textStyle.copyWith(color: AppColors.textGrey),
                    ),
                    items: [
                      for (final item in items)
                        DropdownMenuItem<T>(
                          value: item,
                          child: Text(
                            itemLabel(item),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
