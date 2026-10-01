import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FeatureCheckRow extends StatelessWidget {
  const FeatureCheckRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 16, color: AppColors.primaryLight),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textLightBlack,
            ),
          ),
        ),
      ],
    );
  }
}
