import 'package:get/get.dart';
import 'package:propzytricity/app/modules/login/views/otp_view.dart';
import 'package:propzytricity/app/modules/onboarding/views/onboarding_view.dart';
import 'package:propzytricity/app/modules/profile_setup/bindings/profile_setup_binding.dart';
import 'package:propzytricity/app/modules/profile_setup/views/about_you_view.dart';
import 'package:propzytricity/app/modules/profile_setup/views/role_selection_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/profile_setup/views/preferences_view.dart';
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
      binding: ProfileSetupBinding(),
    ),
  GetPage(
      name: AppRoutes.preferences,
      page: () => const PreferencesView(),
      binding: ProfileSetupBinding(),
    ),
    GetPage(
      name: AppRoutes.profileDetails,
      page: () => const AboutYouView(),
      binding: ProfileSetupBinding(),
    ),

  ];
}
