import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';

class PageDots extends StatelessWidget {
  const PageDots({
    super.key,
    required this.count,
    required this.index,
    this.onDark = false,
  });

  final int count;
  final int index;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final inactive =
        onDark ? Colors.white.withValues(alpha: 0.65) : const Color(0xFFD9DEDB);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.only(right: 6),
          height: 8,
          width: active ? 20 : 20,
          decoration: BoxDecoration(
            color: active ? AppColors.onBoardingIndicatorColor : inactive,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }
}
