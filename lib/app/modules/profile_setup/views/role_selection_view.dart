import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/profile_setup/controllers/profile_setup_controller.dart';
import 'package:propzytricity/app/modules/profile_setup/models/setup_options.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/role_card.dart';

class RoleSelectionView extends GetView<ProfileSetupController> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "LET'S GET STARTED",
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontFamily: FontFamily.plusJakartaSansSemiBold,
                  color: AppColors.textGreen,
                ),
              ),
              const SizedBox(height: 14),
              Text.rich(
                TextSpan(
                  style: AppTextStyles.heading1.copyWith(
                    fontSize: 36,
                    height: 1.2,
                    fontFamily: FontFamily.plusJakartaSansExtraBold,
                    color: AppColors.textPrimaryLight,
                  ),
                  children: const [
                    TextSpan(text: 'How would you\nlike to '),
                    TextSpan(
                      text: 'use Propzy?',
                      style: TextStyle(color: AppColors.textGreen),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Choose your role to get a personalised\nexperience.',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 15,
                  height: 1.5,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 28),
              RoleCard(
                image: AppAssets.roleTenant,
                icon: AppIcons.personIcon,
                title: "I'm a Tenant",
                subtitle: 'Looking for a new home to rent in the city.',
                onTap: () => controller.selectRole(UserRole.tenant),
              ),
              const SizedBox(height: 20),
              RoleCard(
                image: AppAssets.roleOwner,
                icon: AppIcons.buildingIcon,
                title: "I'm a Property Owner",
                subtitle: 'Wanting to list my property for rent.',
                onTap: () => controller.selectRole(UserRole.owner),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
