import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 36,
    this.iconSize = 18,
    this.iconColor,
    this.backgroundColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor ?? AppColors.textLightBlack,
          ),
        ),
      ),
    );
  }
}
