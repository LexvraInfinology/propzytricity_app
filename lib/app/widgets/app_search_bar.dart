import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Rounded search box. Use `readOnly: true` + `onTap` when it should only act
/// as a button that opens the real search screen.
class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hint = 'Search by locality, project or land...',
    this.readOnly = false,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hint;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.body.copyWith(
      fontSize: 13.5,
      color: AppColors.textPrimaryLight,
    );

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.otpBorderColor),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, size: 20, color: AppColors.textGrey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              readOnly: readOnly,
              canRequestFocus: !readOnly,
              onTap: onTap,
              onChanged: onChanged,
              textInputAction: TextInputAction.search,
              style: style,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: style.copyWith(color: AppColors.textGrey),
                isCollapsed: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          if (controller != null && !readOnly)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller!,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    controller!.clear();
                    onChanged?.call('');
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.textGrey,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
