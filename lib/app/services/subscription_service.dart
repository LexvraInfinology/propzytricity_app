import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/subscription_plan_model.dart';

/// App-wide subscription state. It must outlive any single screen: the user
/// buys a plan on one page and expects it to be active on every property.
///
/// PropertyDetailBinding registers it as permanent if nobody has yet; you can
/// move `Get.put(SubscriptionService(), permanent: true)` into InitialBinding.
class SubscriptionService extends GetxService {
  static const List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: 'standard',
      name: 'Standard Plan',
      credits: 20,
      validityDays: 30,
      price: 399,
      description:
          'Perfect for tenants looking to unlock up to 20 verified owner contacts.',
      features: [
        '20 Credits',
        'Direct Phone Call & WhatsApp Connect',
        '100% Zero Brokerage Guarantee',
        'Instant PROP-ID unlocks',
        'Standard Support & Advice',
      ],
    ),
    SubscriptionPlan(
      id: 'premium',
      name: 'Premium Plan',
      credits: 100,
      validityDays: 90,
      price: 999,
      description: 'Get 100 credits with 90 days validity.',
      badge: 'MOST POPULAR • BEST VALUE',
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

  final activePlan = Rxn<SubscriptionPlan>();
  final creditsLeft = 0.obs;
  final expiresAt = Rxn<DateTime>();

  bool get hasActivePlan {
    final plan = activePlan.value;
    final expiry = expiresAt.value;
    return plan != null && expiry != null && expiry.isAfter(DateTime.now());
  }

  /// Integration point: call this after the payment is verified by the
  /// backend, and load the same state from the API on app start.
  void activate(SubscriptionPlan plan) {
    activePlan.value = plan;
    creditsLeft.value = plan.credits;
    expiresAt.value = DateTime.now().add(Duration(days: plan.validityDays));
  }
}
