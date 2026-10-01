import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/data/models/subscription_plan_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/price_formatter.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';

/// Pricing card: name, validity, credits, price, feature checklist, button.
/// `highlighted` gives it the green border and shadow; the plan's `badge`
/// text is shown as a ribbon on the top edge.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    required this.onSubscribe,
    this.highlighted = false,
    this.isActive = false,
    this.isLoading = false,
  });

  final SubscriptionPlan plan;
  final VoidCallback onSubscribe;
  final bool highlighted;

  /// The user already has this plan.
  final bool isActive;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, highlighted ? 22 : 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlighted ? AppColors.primaryLight : AppColors.otpBorderColor,
          width: highlighted ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (highlighted ? AppColors.primaryLight : Colors.black)
                .withValues(alpha: highlighted ? 0.14 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  plan.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    letterSpacing: 0.8,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textGreen,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppColors.textGrey,
              ),
              const SizedBox(width: 4),
              Text(
                plan.validityLabel,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: FontFamily.plusJakartaSansMedium,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            plan.creditsLabel,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: FontFamily.plusJakartaSansBold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            plan.description,
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(
              text: PriceFormatter.rupees(plan.price),
              style: const TextStyle(
                fontSize: 30,
                fontFamily: FontFamily.plusJakartaSansBold,
                color: AppColors.primaryLight,
              ),
              children: [
                TextSpan(
                  text: ' ${plan.periodLabel}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: FontFamily.plusJakartaSansMedium,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Divider(height: 2, color: AppColors.otpBorderColor),
          const SizedBox(height: 14),
          for (final feature in plan.features)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: AppSvg(
                      AppIcons.verifiedIcon,
                      size: 12,

                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        fontFamily: FontFamily.plusJakartaSansMedium,
                        color: AppColors.textLightBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          CustomButton(
            text: isActive
                ? 'Current plan'
                : 'Subscribe Now • ${PriceFormatter.rupees(plan.price)}',
            isLoading: isLoading,
            backgroundColor: AppColors.primaryLight,
            onPressed: isActive ? null : onSubscribe,
          ),
        ],
      ),
    );

    if (plan.badge == null) return card;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        card,
        Positioned(
          top: -12,
          left: 0,
          right: 0,
          child: Center(child: _Ribbon(label: plan.badge!)),
        ),
      ],
    );
  }
}

class _Ribbon extends StatelessWidget {
  const _Ribbon({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 12, color: AppColors.textWhite),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 9,
              letterSpacing: 0.6,
              fontFamily: FontFamily.plusJakartaSansBold,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }
}
