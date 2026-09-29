import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';

/// A small white chip floating over the onboarding photo.
class FloatingTagData {
  const FloatingTagData({
    required this.icon,
    required this.label,
    required this.alignment,
    this.subLabel,
    this.compact = false,
  });

  final String icon;
  final String label;
  final String? subLabel;
  final Alignment alignment;
  final bool compact;
}

/// Content of the feature slides (slide 2 to 4). Slide 1 is the hero page.
class OnboardingContent {
  const OnboardingContent({
    required this.image,
    required this.title,
    required this.highlight,
    required this.description,
    this.tags = const [],
  });

  final String image;
  final String title;
  final String highlight;
  final String description;
  final List<FloatingTagData> tags;

  static const List<OnboardingContent> features = [
    OnboardingContent(
      image: AppAssets.onboarding2,
      title: 'Explore curated\nhomes across\n',
      highlight: 'Tricity.',
      description: 'Apartments, villas, plots and more\nall in one place.',
      tags: [
        FloatingTagData(
          icon: AppIcons.locationIcon,
          label: 'Mohali',
          alignment: Alignment(-0.7, 0.85),
          compact: true,
        ),
      ],
    ),
    OnboardingContent(
      image: AppAssets.onboarding3,
      title: 'Homes you can\ntruly ',
      highlight: 'Trust.',
      description:
          'Every listing is verified for genuine information, real photos and accurate details.',
      tags: [
        FloatingTagData(
          icon: AppIcons.verifiedIcon,
          label: 'Verified Listing',
          alignment: Alignment(0.8, -0.9),
          compact: true,
        ),
        FloatingTagData(
          icon: AppIcons.cameraIcon,
          label: 'Real Photos',
          alignment: Alignment(-1.30, -0.29),
        ),
        FloatingTagData(
          icon: AppIcons.verifiedOwnershipIcon,
          label: 'Verified Ownership',
          alignment: Alignment(-1.80, 0.29),
        ),
        FloatingTagData(
          icon: AppIcons.todoIcon,
          label: 'Accurate Details',
          alignment: Alignment(-1.30, 0.85),
        ),
      ],
    ),
    OnboardingContent(
      image: AppAssets.onboarding4,
      title: 'Find your home, no\n',
      highlight: 'extra fees.',
      description:
          'Connect directly with property owners and save on brokerage costs.',
      tags: [
        FloatingTagData(
          icon: AppIcons.percentageIcon,
          label: '0%',
          subLabel: 'Brokerage',
          alignment: Alignment(0.8, -0.85),
        ),
        FloatingTagData(
          icon: AppIcons.personIcon,
          label: 'Direct Owner',
          subLabel: 'Contact',
          alignment: Alignment(-0.7, 0.85),
        ),
      ],
    ),
  ];
}
