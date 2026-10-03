import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// White rounded card holding [SettingsTile]s, with dividers between them.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.otpBorderColor),
      ),
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              const Divider(
                height: 1,
                thickness: 1,
                indent: 14,
                endIndent: 14,
                color: AppColors.otpBorderColor,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// One row: icon, title and a chevron (or a small [trailingText]).
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailingText,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.plusJakartaSansRegular,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: FontFamily.plusJakartaSansMedium,
                  color: AppColors.textGrey,
                ),
              )
            else
              const Icon(
                Icons.chevron_right_rounded,
                size: 14,
                color: AppColors.textGrey,
              ),
          ],
        ),
      ),
    );
  }
}
