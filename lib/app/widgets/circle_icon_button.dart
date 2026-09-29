import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

/// Round white button with a border (back buttons, small actions).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.otpBorderColor),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: size,
          width: size,
          child: Icon(icon, color: AppColors.textPrimaryLight),
        ),
      ),
    );
  }
}
