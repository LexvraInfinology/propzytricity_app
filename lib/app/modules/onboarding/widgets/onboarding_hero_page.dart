import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';
import 'package:propzytricity/app/widgets/propzy_logo.dart';

class OnboardingHeroPage extends StatelessWidget {
  const OnboardingHeroPage({super.key});

  static const _stats = [
    (AppIcons.buildingIcon, '10K+', 'PROPERTIES'),
    (AppIcons.locationIcon, '5+', 'CITIES'),
    (AppIcons.keyIcon, '0%', 'BROKERAGE'),
  ];

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Stack(
      fit: StackFit.expand,
      children: [
        const AssetPhoto(AppAssets.onboarding1),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
                Colors.white.withValues(alpha: 0.55),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(24, topPad + 24, 24, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PropzyLogo(),
              const SizedBox(height: 56),
              Text.rich(
                TextSpan(
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: 40,
                    height: 1.15,
                    fontFamily: FontFamily.plusJakartaSansExtraBold,
                  ),
                  children: const [
                    TextSpan(text: 'Find Your\n'),
                    TextSpan(
                      text: 'Place.',
                      style: TextStyle(color: AppColors.textGreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Verified properties across Chandigarh,\nMohali, Zirakpur & Kharar.',
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  height: 1.5,
                  fontFamily: FontFamily.plusJakartaSansSemiBold,
                ),
              ),
              const Spacer(),
              const _StatsCard(stats: _stats),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.stats});

  final List<(String, String, String)> stats;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final s in stats) _Stat(icon: s.$1, value: s.$2, label: s.$3),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.value, required this.label});

  final String icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 34,
          width: 34,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: AppSvg(icon, size: 16, color: AppColors.onBoardingIndicatorColor),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.heading1.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.bodySecondary.copyWith(
            fontSize: 10,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
