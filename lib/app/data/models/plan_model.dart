import 'package:flutter/material.dart';

class PlanModel {
  const PlanModel({
    required this.id,
    required this.tagLabel,
    required this.credits,
    required this.validityDays,
    required this.description,
    required this.price,
    required this.features,
    this.ribbon,
  });

  final String id;
  final String tagLabel;
  final int credits;
  final int validityDays;
  final String description;
  final int price;
  final List<String> features;

  /// Non-null => highlighted card with a ribbon on top.
  final String? ribbon;

  String get title => '$credits Credits';
  String get validityLabel => '$validityDays Days Validity';
  String get periodLabel => '/ $validityDays days';
  bool get isHighlighted => ribbon != null;

  // Demo data. Replace with API response later.
  static const samplePlans = <PlanModel>[
    PlanModel(
      id: 'standard',
      tagLabel: 'STANDARD PLAN',
      credits: 20,
      validityDays: 30,
      description:
          'Perfect for renters looking to unlock up to 20 verified owner contacts in specific localities.',
      price: 399,
      features: [
        '20 Credits',
        'Direct Phone Call & WhatsApp Connect',
        '100% Zero Brokerage Guarantee',
        'Instant PROP-ID unlocks',
        'Standard Support & Advice',
      ],
    ),
    PlanModel(
      id: 'premium',
      tagLabel: 'PREMIUM PLAN',
      credits: 100,
      validityDays: 90,
      description: 'Get 100 credits with 90 days validity.',
      price: 999,
      ribbon: 'MOST POPULAR • BEST VALUE',
      features: [
        '100 Credits',
        'Direct Phone Call & WhatsApp Unlock',
        '90 Days Extended Validity',
        'Priority Alerts on Fresh Verified Listings',
        'Price Negotiation Guidance on Your Behalf',
        '100% Zero Brokerage Guarantee',
      ],
    ),
  ];
}

class PlanBenefit {
  const PlanBenefit({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  static const sampleBenefits = <PlanBenefit>[
    PlanBenefit(
      icon: Icons.phone_in_talk_outlined,
      title: 'Direct Owner Contact',
      subtitle: 'Call or WhatsApp verified owners directly. No agents, no middlemen.',
    ),
    PlanBenefit(
      icon: Icons.verified_user_outlined,
      title: 'Verified Listings',
      subtitle: 'Connect only with genuine and verified property owners.',
    ),
    PlanBenefit(
      icon: Icons.percent,
      title: '0% Brokerage',
      subtitle: 'Save on brokerage. Talk directly with owners for better deals.',
    ),
    PlanBenefit(
      icon: Icons.bolt,
      title: 'Instant Unlocks',
      subtitle: 'Get owner details and PROP-ID instantly using your credits.',
    ),
    PlanBenefit(
      icon: Icons.notifications_active_outlined,
      title: 'Priority Alerts',
      subtitle: 'Be the first to know about fresh verified listings in your preferred areas.',
    ),
    PlanBenefit(
      icon: Icons.chat_bubble_outline,
      title: 'Expert Support',
      subtitle: 'Get guidance on price negotiation and local property insights.',
    ),
  ];
}
