import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

class PropzyLogo extends StatelessWidget {
  const PropzyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const AppSvg(AppIcons.homeIcon, size: 35),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROPZY',
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 3,
                height: 1.1,
                fontFamily: FontFamily.plusJakartaSansBold,
                color: AppColors.textBlack,
              ),
            ),
            Text(
              'TRICITY',
              style: TextStyle(
                fontSize: 11.6,
                letterSpacing: 4,
                fontFamily: FontFamily.plusJakartaSansMedium,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
