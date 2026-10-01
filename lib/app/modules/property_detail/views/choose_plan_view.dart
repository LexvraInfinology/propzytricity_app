import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/data/models/subscription_plan_model.dart';
import 'package:propzytricity/app/modules/property_detail/controllers/property_detail_controller.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/benefit_tile.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/plan_card.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/info_banner.dart';
import 'package:propzytricity/app/widgets/section_header.dart';

class ChoosePlanView extends GetView<PropertyDetailController> {
  const ChoosePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleIconButton(
                icon: Icons.chevron_left_rounded,
                onTap: Get.back,
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose a Plan',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Unlock owner details, connect directly and find your next home with zero brokerage.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  fontFamily: FontFamily.plusJakartaSansRegular,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 18),
              const InfoBanner(
                icon: AppIcons.secureIcon,
                title: '0% brokerage.',
                subtitle: 'Connect directly with owners. No middleman.',
              ),
              const SizedBox(height: 30),

              // Plans
              for (final plan in controller.plans) ...[
                Obx(
                  () => PlanCard(
                    plan: plan,
                    highlighted: plan.badge != null,
                    isActive: controller.subscription.activePlan.value?.id == plan.id &&
                        controller.hasPlan,
                    isLoading: controller.subscribingPlanId.value == plan.id,
                    onSubscribe: () => controller.subscribe(plan),
                  ),
                ),
                const SizedBox(height: 28),
              ],
              // Why choose a plan
              const SectionHeader(
                title: 'Why Choose a Plan?',
                titleFontSize: 24,
                subtitle: 'Get more success, better connections and a smarter home-search experience.',
              ),
              const SizedBox(height: 14),
              for (final benefit in PlanBenefit.all) ...[
                BenefitTile(
                  icon: benefit.icon,
                  title: benefit.title,
                  description: benefit.description,
                ),
                const SizedBox(height: 10),
              ],
              const SizedBox(height: 6),

              const IllustrationBanner(
                title: 'Find better homes with real connections.',
                subtitle: 'Simple plans.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class IllustrationBanner extends StatelessWidget {
  const IllustrationBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.height = 86,
    this.textWidthFactor = 0.65,
  });

  final String title;
  final String? subtitle;
  final double height;

  /// Share of the card width the text may use (keeps it clear of the image).
  final double textWidthFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.12)),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: 0,
            bottom: 0,
            child: AppSvg(AppIcons.locationBuildingsIcon,size: 82,),
          ),
          Positioned.fill(
            child: FractionallySizedBox(
              widthFactor: textWidthFactor,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 0, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.35,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textLightBlack,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        subtitle!,
                        style: const TextStyle(fontSize: 11,
                            fontFamily: FontFamily.plusJakartaSansMedium,
                            color: AppColors.textGrey),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
