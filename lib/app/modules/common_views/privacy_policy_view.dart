import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';

/// Static page, so it needs no controller.
/// Replace the text below with your final, lawyer-approved Privacy Policy.
class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  static const String _lastUpdated = 'Last updated: 10 June 2026';

  static const _sections = [
    _LegalSection(
      heading: '1. Introduction',
      body:
          'At PROPZY TRICITY, your privacy is paramount. We take careful measures to safeguard your personal information and maintain user confidentiality.',
    ),
    _LegalSection(
      heading: '2. Information We Collect',
      body:
          'We collect essential information to deliver services effectively, including:',
      bullets: [
        'Personal information (name, email, phone number)',
        'Location preferences',
        'Property search activity',
        'Enquiries and messages',
        'Device and usage data',
      ],
    ),
    _LegalSection(
      heading: '3. How We Use Your Information',
      body: 'We utilize collected data to optimize our platform offerings:',
      bullets: [
        'To show relevant property listings',
        'To communicate with you',
        'To ensure safety and security',
        'To send important updates and offers (with consent)',
      ],
    ),
    _LegalSection(
      heading: '4. Data Sharing',
      body:
          'We do not sell personal data. We only share verified contact details with owners and service partners when explicitly requested by you.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(title: 'Privacy Policy'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                children: [
                  const Text(
                    _lastUpdated,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontFamily: FontFamily.plusJakartaSansRegular,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (final section in _sections) _SectionBlock(section: section),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalSection {
  const _LegalSection({
    required this.heading,
    required this.body,
    this.bullets = const [],
  });

  final String heading;
  final String body;
  final List<String> bullets;
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

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.section});

  final _LegalSection section;

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 12,
      height: 1.6,
      fontFamily: FontFamily.plusJakartaSansRegular,
      color: AppColors.textGrey,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.heading,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.plusJakartaSansBold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          Text(section.body, style: bodyStyle),
          for (final bullet in section.bullets)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  ', style: bodyStyle),
                  Expanded(child: Text(bullet, style: bodyStyle)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}