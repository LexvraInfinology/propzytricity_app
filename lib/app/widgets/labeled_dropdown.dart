import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/field_shell.dart';

/// Dropdown styled like [LabeledTextField], with an optional leading icon.
class LabeledDropdown<T> extends StatelessWidget {
  const LabeledDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemLabel,
    this.prefixIcon,
    this.hint = 'Select',
    this.errorText,
  });

  final String label;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T item) itemLabel;
  final IconData? prefixIcon;
  final String hint;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.body.copyWith(
      fontSize: 14,
      color: AppColors.textPrimaryLight,
    );

    return FieldShell(
      label: label,
      errorText: errorText,
      child: Row(
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, size: 16, color: AppColors.primary),
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
                      child: Text(itemLabel(item)),
                    ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
