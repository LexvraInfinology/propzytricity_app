import 'package:flutter/material.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';

class SubscriptionPlan {
  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.credits,
    required this.validityDays,
    required this.price,
    required this.description,
    required this.features,
    this.badge,
  });

  final String id;
  final String name;
  final int credits;
  final int validityDays;
  final int price;
  final String description;
  final List<String> features;

  /// Ribbon text, e.g. "MOST POPULAR • BEST VALUE".
  final String? badge;

  String get creditsLabel => '$credits Credits';
  String get validityLabel => '$validityDays Days validity';
  String get periodLabel => '/ $validityDays days';
}

/// One row of the "Why Choose a Plan?" list.
class PlanBenefit {
  const PlanBenefit({
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  static final  List<PlanBenefit> all = [
     const PlanBenefit(
      icon: AppIcons.callIcon,
      title: 'Direct Owner Contact',
      description: 'Call or WhatsApp owners directly. No agents, no middlemen.',
    ),
    const PlanBenefit(
      icon: AppIcons.secureIcon,
      title: 'Verified Listings',
      description: 'Every listing is checked for genuine details and real photos.',
    ),
    const PlanBenefit(
      icon: AppIcons.percentageIcon,
      title: '0% Brokerage',
      description: 'Save on brokerage. Talk to owners directly at zero cost.',
    ),
    const PlanBenefit(
      icon: AppIcons.instantIcon,
      title: 'Instant Unlocks',
      description: 'Use your credits to unlock owner details instantly, anytime.',
    ),
    const PlanBenefit(
      icon: AppIcons.notificationsIcon,
      title: 'Priority Alerts',
      description: 'Be the first to know about fresh verified listings in your area.',
    ),
    const PlanBenefit(
      icon: AppIcons.supportIcon,
      title: 'Expert Support',
      description: 'Get guidance on price negotiation and insights from our team.',
    ),
  ];
}
