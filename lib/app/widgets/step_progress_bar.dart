import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Segmented progress with a "Step x of y" caption.
class StepProgressBar extends StatelessWidget {
  const StepProgressBar({
    super.key,
    required this.current,
    required this.total,
    this.segmentWidth = 48,
  });

  /// 1-based current step.
  final int current;
  final int total;
  final double segmentWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < total; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: segmentWidth,
                height: 4,
                decoration: BoxDecoration(
                  color: i < current
                      ? AppColors.primary
                      : AppColors.otpBorderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Step $current of $total',
          style: AppTextStyles.bodySecondary.copyWith(
            fontSize: 11,
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
