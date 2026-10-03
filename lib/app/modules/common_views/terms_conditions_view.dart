import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';

/// Static page, so it needs no controller.
/// Replace the text below with your final, lawyer-approved Terms.
class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  static const String _lastUpdated = 'Last updated: 10 June 2026';

  static const _sections = [
    _LegalSection(
      heading: '1. Acceptance of Terms',
      body:
          'By accessing or using PROPZY TRICITY, you agree to be bound by these Terms & Conditions. If you do not agree, please do not use the app.',
    ),
    _LegalSection(
      heading: '2. Use of the App',
      body:
          'For personal, non-commercial use, you agree to use this platform in compliance with applicable laws and will not engage in unauthorized actions.',
    ),
    _LegalSection(
      heading: '3. User Responsibilities',
      body:
          'You must provide accurate information and keep your credentials confidential. You are solely responsible for all activities occurring under your account.',
    ),
    _LegalSection(
      heading: '4. Property Listings',
      body:
          'Property listings are maintained and updated regularly. However, PROPZY TRICITY makes no representations or warranties regarding listing correctness.',
    ),
    _LegalSection(
      heading: '5. Enquiries and Communication',
      body:
          'Users agree to engage in respectful and legitimate communication with property agents and owners through verified channels.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(title: 'Terms & Conditions'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
                children: [
                  const Text(
                    _lastUpdated,
                    style: TextStyle(
                      fontSize: 10,
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
