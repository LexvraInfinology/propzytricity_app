import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/onboarding/models/onboarding_content.dart';
import 'package:propzytricity/app/modules/onboarding/widgets/floating_tag.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';

class OnboardingFeaturePage extends StatelessWidget {
  const OnboardingFeaturePage({super.key, required this.content});

  final OnboardingContent content;

  static const String _stackLeft = AppAssets.subOnboarding1;
  static const String _stackRight = AppAssets.subOnboarding2;
  static const double _narrowWidthFactor = 0.80;
  static const double _narrowRightInset = 20;

  bool get _isStacked => content.image == AppAssets.onboarding2;
  bool get _isNarrow => content.image == AppAssets.onboarding3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPad = MediaQuery.paddingOf(context).top;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(24, topPad + 84, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: SizedBox(
              height: size.height * 0.37,
              child: _isStacked
                  ? _StackedPhotos(
                centerImage: content.image,
                leftImage: _stackLeft,
                rightImage: _stackRight,
                tags: content.tags,
              )
                  : _SinglePhoto(
                image: content.image,
                tags: content.tags,
                widthFactor: _isNarrow ? _narrowWidthFactor : 1,
                rightInset: _isNarrow ? _narrowRightInset : 0,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text.rich(
            TextSpan(
              style: AppTextStyles.heading1.copyWith(fontSize: 32, height: 1.2),
              children: [
                TextSpan(text: content.title),
                TextSpan(
                  text: content.highlight,
                  style: const TextStyle(color: AppColors.textGreen),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content.description,
            style: AppTextStyles.bodySecondary.copyWith(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SinglePhoto extends StatelessWidget {
  const _SinglePhoto({
    required this.image,
    required this.tags,
    this.widthFactor = 1,
    this.rightInset = 0,
  });

  final String image;
  final List<FloatingTagData> tags;
  final double widthFactor;
  final double rightInset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: rightInset),
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: 1,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: _PhotoCard(image: image, elevated: true)),
              for (final tag in tags)
                Align(alignment: tag.alignment, child: FloatingTag(data: tag)),
            ],
          ),
        ),
      ),
    );
  }
}

class _StackedPhotos extends StatelessWidget {
  const _StackedPhotos({
    required this.centerImage,
    required this.leftImage,
    required this.rightImage,
    required this.tags,
  });

  final String centerImage;
  final String leftImage;
  final String rightImage;
  final List<FloatingTagData> tags;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        final centerW = w * 0.68;
        final sideW = centerW * 0.80;
        final sideH = h * 0.70;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Back left
            Positioned(
              left: 0,
              top: h * 0.20,
              width: sideW,
              height: sideH,
              child: _PhotoCard(image: leftImage, radius: 22, borderWidth: 3),
            ),
            // Back right (sits slightly higher than the left one)
            Positioned(
              right: 0,
              top: h * 0.10,
              width: sideW,
              height: sideH,
              child: _PhotoCard(image: rightImage, radius: 22, borderWidth: 3),
            ),
            // Front centre + tags
            Positioned(
              left: (w - centerW) / 2,
              top: 0,
              width: centerW,
              height: h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: _PhotoCard(image: centerImage, elevated: true),
                  ),
                  for (final tag in tags)
                    Align(
                      alignment: tag.alignment,
                      child: FloatingTag(data: tag),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard({
    required this.image,
    this.radius = 28,
    this.borderWidth = 4,
    this.elevated = false,
  });

  final String image;
  final double radius;
  final double borderWidth;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: elevated ? 0.10 : 0.08),
            blurRadius: elevated ? 24 : 16,
            offset: Offset(0, elevated ? 10 : 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius - borderWidth),
        child: AssetPhoto(image),
      ),
    );
  }
}