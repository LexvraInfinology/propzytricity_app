import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';

/// Confirmation popup: round icon, title, message, Cancel + confirm buttons.
/// Use [showConfirmDialog]; it returns true only when the user confirms.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.color = AppColors.error,
  });

  final IconData icon;
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  /// Accent for the icon and buttons (red for destructive actions).
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.3,
                fontFamily: FontFamily.plusJakartaSansBold,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                fontFamily: FontFamily.plusJakartaSansRegular,
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: cancelText,
                    variant: CustomButtonVariant.outlined,
                    foregroundColor: color,
                    borderColor: color.withValues(alpha: 0.5),
                    height: 48,
                    onPressed: () => Get.back(result: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: confirmText,
                    backgroundColor: color.withValues(alpha: 0.8),
                    foregroundColor: AppColors.textWhite,
                    height: 40,
                    onPressed: () => Get.back(result: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showConfirmDialog({
  required IconData icon,
  required String title,
  required String message,
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
  Color color = AppColors.error,
}) async {
  final result = await Get.dialog<bool>(
    ConfirmDialog(
      icon: icon,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      color: color,
    ),
  );
  return result ?? false;
}
