import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

/// Circle with the user's initials ("Aman Garg" -> "AG").
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 40,
    this.onTap,
  });

  final String name;
  final double size;
  final VoidCallback? onTap;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    return parts.take(2).map((p) => p[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Text(
          _initials,
          style: TextStyle(
            fontSize: size * 0.34,
            fontFamily: FontFamily.plusJakartaSansBold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
