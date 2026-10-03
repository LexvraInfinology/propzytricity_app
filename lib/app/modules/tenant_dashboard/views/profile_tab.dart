import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/profile_summary_card.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/settings_tile.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';
import 'package:propzytricity/app/widgets/section_title.dart';

/// Profile tab of the tenant dashboard.
class ProfileTab extends GetView<TenantDashboardController> {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleIconButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () =>
                      controller.changeTab(TenantDashboardController.homeTab),
                ),
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.plusJakartaSansBold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Manage your account and preferences',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.plusJakartaSansRegular,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleIconButton(
                  icon: Icons.notifications_none_rounded,
                  onTap: controller.openNotifications,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => ProfileSummaryCard(
                name: controller.userName.value,
                email: controller.userEmail.value,
                phone: controller.formattedPhone,
                avatarPath: controller.avatarPath.value,
                onTap: controller.openEditProfile,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle('App Preferences',
              fontFamily: FontFamily.plusJakartaSansBold,),
            const SizedBox(height: 10),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notification Preferences',
                  onTap: controller.openNotifications,
                ),
                SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location Preferences',
                  onTap: () => controller.openLocationPreferences(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const SectionTitle('Support',
                fontFamily: FontFamily.plusJakartaSansBold),
            const SizedBox(height: 10),
            SettingsGroup(
              children: [
                SettingsTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () => controller.openHelpSupport(),
                ),
                SettingsTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  onTap: () => controller.openTerms(),
                ),
                SettingsTile(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  onTap: () => controller.openPrivacy(),
                ),
                 SettingsTile(
                   onTap: () => controller.openAbout(),
                   icon: Icons.info_outline_rounded,
                  title: 'About PROPZY TRICITY',
                  trailingText: TenantDashboardController.appVersion,
                ),
              ],
            ),
            const SizedBox(height: 24),

            CustomButton(
              text: 'Log Out',
              variant: CustomButtonVariant.outlined,
              foregroundColor: AppColors.error,
              borderColor: AppColors.error.withValues(alpha: 0.4),
              textStyle: const TextStyle(
                  fontSize: 12,
                  fontFamily: FontFamily.plusJakartaSansBold),
              leading: const Icon(
                Icons.logout_rounded,
                size: 16,
                color: AppColors.error,
              ),
              onPressed: controller.confirmLogout,
            ),
          ],
        ),
      ),
    );
  }
}





