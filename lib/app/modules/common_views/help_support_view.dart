import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/settings_tile.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  static const _topics = [
    _HelpTopic(Icons.search_rounded, 'How to search for properties'),
    _HelpTopic(Icons.person_outline_rounded, 'How to contact a property owner'),
    _HelpTopic(Icons.calendar_today_outlined, 'How to schedule a visit'),
    _HelpTopic(Icons.chat_bubble_outline_rounded, 'Enquiry related issues'),
    _HelpTopic(Icons.language_rounded, 'Account settings'),
    _HelpTopic(Icons.credit_card_outlined, 'Payments and bookings'),
    _HelpTopic(Icons.warning_amber_rounded, 'Report a problem'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(title: 'Help & Support'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular Topics',
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textLightBlack,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SettingsGroup(
                      children: [
                        for (final topic in _topics)
                          SettingsTile(
                            icon: topic.icon,
                            title: topic.title,
                            // Integration point: open the help article.
                            // onTap: () => controller.comingSoon(topic.title),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _ContactSupportCard(
                      // Integration point: open chat / email / phone support.
                      onContact: () => {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpTopic {
  const _HelpTopic(this.icon, this.title);

  final IconData icon;
  final String title;
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        children: [
          CircleIconButton(icon: Icons.chevron_left_rounded, onTap: Get.back),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
          // Keeps the title centred.
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

/// "Still need help?" box with the Contact Support button.
class _ContactSupportCard extends StatelessWidget {
  const _ContactSupportCard({required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              AppSvg(
                AppIcons.chatIcon,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Still need help?',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Contact our support team',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Contact Support',
            variant: CustomButtonVariant.outlined,
            foregroundColor: AppColors.primaryLight,
            borderColor: AppColors.primaryLight,
            height: 44,
            onPressed: onContact,
          ),
        ],
      ),
    );
  }
}
