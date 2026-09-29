import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

class AssetPhoto extends StatelessWidget {
  const AssetPhoto(
    this.path, {
    super.key,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  final String path;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFCFE8DC), Color(0xFFEAF4EE)],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.home_work_rounded,
            size: 56,
            color: AppColors.primary.withValues(alpha: 0.35),
          ),
        ),
      ),
    );
  }
}
