import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Full-width primary button. Swap with your existing custom_button.dart
/// if its API fits.
class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 46,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textWhite,
          disabledBackgroundColor: AppColors.primaryLight.withValues(alpha: 0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}
