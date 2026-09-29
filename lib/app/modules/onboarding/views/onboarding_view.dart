import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:propzytricity/app/modules/onboarding/models/onboarding_content.dart';
import 'package:propzytricity/app/modules/onboarding/widgets/onboarding_feature_page.dart';
import 'package:propzytricity/app/modules/onboarding/widgets/onboarding_hero_page.dart';
import 'package:propzytricity/app/modules/onboarding/widgets/page_dots.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: [
              const OnboardingHeroPage(),
              for (final item in OnboardingContent.features)
                OnboardingFeaturePage(content: item),
            ],
          ),

          // Top bar (back + skip), hidden on the hero page
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(
              () => controller.isFirstPage
                  ? const SizedBox.shrink()
                  : SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CircleIconButton(
                              icon: Icons.chevron_left_rounded,
                              onTap: controller.back,
                            ),
                            TextButton(
                              onPressed: controller.skip,
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: FontFamily.plusJakartaSansSemiBold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),

          // Bottom bar (dots + next)
          Positioned(
            left: 24,
            right: 24,
            bottom: bottomPad + 32,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageDots(
                    count: OnboardingController.totalPages,
                    index: controller.currentPage.value,
                    onDark: controller.isFirstPage,
                  ),
                  _NextButton(onTap: controller.next),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(side: BorderSide(color: AppColors.otpBorderColor)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 44,
          width: 44,
          child: Icon(icon, color: AppColors.onBoardingIndicatorColor),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.onBoardingIndicatorColor,
      elevation: 6,
      shadowColor: AppColors.onBoardingIndicatorColor,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox(
          height: 52,
          width: 52,
          child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
