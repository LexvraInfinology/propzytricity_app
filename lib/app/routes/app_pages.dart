import 'package:get/get.dart';
import 'package:propzytricity/app/modules/common_views/about_view.dart';
import 'package:propzytricity/app/modules/common_views/help_support_view.dart';
import 'package:propzytricity/app/modules/common_views/privacy_policy_view.dart';
import 'package:propzytricity/app/modules/common_views/terms_conditions_view.dart';
import 'package:propzytricity/app/modules/login/views/otp_view.dart';
import 'package:propzytricity/app/modules/onboarding/views/onboarding_view.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/bindings/owner_profile_setup_binding.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/views/owner_about_you_view.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/bindings/tenant_setup_binding.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/views/tenant_about_you_view.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/views/tenant_preferences_view.dart';
import 'package:propzytricity/app/modules/login/views/role_selection_view.dart';
import 'package:propzytricity/app/modules/property_detail/bindings/property_detail_binding.dart';
import 'package:propzytricity/app/modules/property_detail/views/choose_plan_view.dart';
import 'package:propzytricity/app/modules/property_detail/views/property_detail_view.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/bindings/tenant_dashboard_binding.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/edit_profile_view.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/location_preferences_view.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/notification_view.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/views/tenant_dashboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/profile_setup/owner_profile_setup/views/owner_intent_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();
  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
   GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: LoginBinding(),
    ),  GetPage(
      name: AppRoutes.role,
      page: () => const RoleSelectionView(),
      binding: LoginBinding(),
    ),
  GetPage(
      name: AppRoutes.preferences,
      page: () => const TenantPreferencesView(),
      binding: TenantSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.tenantProfileDetails,
      page: () => const TenantAboutYouView(),
      binding: TenantSetupBinding(),
    ), GetPage(
      name: AppRoutes.ownerProfileDetails,
      page: () => const OwnerAboutYouView(),
      binding: OwnerProfileSetupBinding(),
    ),GetPage(
      name: AppRoutes.ownerIntent,
      page: () => const OwnerIntentView(),
      binding: OwnerProfileSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.tenantDashboard,
      page: () => const TenantDashboardView(),
      binding: TenantDashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => const PropertyDetailView(),
      binding: PropertyDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.choosePlan,
      page: () => const ChoosePlanView(),
      binding: PropertyDetailBinding(),
    ), GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: TenantDashboardBinding(),
    ),GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationView(),
      binding: TenantDashboardBinding(),
    ),GetPage(
      name: AppRoutes.locationPreferences,
      page: () => const LocationPreferencesView(),
      binding: TenantDashboardBinding(),
    ),GetPage(
      name: AppRoutes.helpSupport,
      page: () => const HelpSupportView(),
    ),GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyView(),
    ),GetPage(
      name: AppRoutes.termsConditions,
      page: () => const TermsConditionsView(),
    ),GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
    )
  ];
}
