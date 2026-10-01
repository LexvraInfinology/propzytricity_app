import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Result of [showSelectionSheet].
/// A null result means the sheet was dismissed; `value == null` means the user
/// picked the "clear" row.
class SelectionResult<T> {
  const SelectionResult(this.value);
  final T? value;
}

/// Bottom sheet with a single-choice list. Needs no BuildContext (uses Get),
/// so controllers can call it directly.
///
/// ```dart
/// final r = await showSelectionSheet<String>(
///   title: 'Select city',
///   options: cities,
///   labelOf: (c) => c,
///   selected: city,
/// );
/// if (r != null) city = r.value;
/// ```
Future<SelectionResult<T>?> showSelectionSheet<T>({
  required String title,
  required List<T> options,
  required String Function(T option) labelOf,
  T? selected,
  String? clearLabel,
}) {
  return Get.bottomSheet<SelectionResult<T>>(
    _SelectionSheet<T>(
      title: title,
      options: options,
      labelOf: labelOf,
      selected: selected,
      clearLabel: clearLabel,
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}

class _SelectionSheet<T> extends StatelessWidget {
  const _SelectionSheet({
    required this.title,
    required this.options,
    required this.labelOf,
    this.selected,
    this.clearLabel,
  });

  final String title;
  final List<T> options;
  final String Function(T option) labelOf;
  final T? selected;
  final String? clearLabel;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.7;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.otpBorderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                children: [
                  if (clearLabel != null)
                    _SheetOption(
                      label: clearLabel!,
                      selected: selected == null,
                      onTap: () => Get.back(result: SelectionResult<T>(null)),
                    ),
                  for (final option in options)
                    _SheetOption(
                      label: labelOf(option),
                      selected: option == selected,
                      onTap: () => Get.back(result: SelectionResult<T>(option)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  const _SheetOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: selected
                      ? FontFamily.plusJakartaSansSemiBold
                      : FontFamily.plusJakartaSansMedium,
                  color: selected
                      ? AppColors.primary
                      : AppColors.textLightBlack,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.check_rounded, size: 20, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
