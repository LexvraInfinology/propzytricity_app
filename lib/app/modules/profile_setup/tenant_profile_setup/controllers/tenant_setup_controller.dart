import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/models/tenant_setup_options.dart';
import 'package:propzytricity/app/routes/app_routes.dart';
import 'package:propzytricity/app/widgets/custom_snackbar.dart';

/// One controller for the whole setup flow:
/// role -> about you (step 1) -> preferences (step 2).
/// The three screens share this instance through ProfileSetupBinding.
class TenantSetupController extends GetxController {

  // ---------------- Step 1: about you ----------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final city = RxnString();
  final language = SetupOptions.languages.first.obs;

  final nameError = RxnString();
  final emailError = RxnString();
  final cityError = RxnString();

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  // ---------------- Step 2: preferences ----------------
  final interest = PropertyInterest.rent.obs;
  final propertyTypes = <PropertyType>{PropertyType.apartment}.obs;
  final budget = SetupOptions.defaultBudget.obs;

  final isSubmitting = false.obs;


  // ---------------- Step 1 actions ----------------

  void onNameChanged(String _) {
    if (nameError.value != null) nameError.value = null;
  }

  void onEmailChanged(String _) {
    if (emailError.value != null) emailError.value = null;
  }

  void onCityChanged(String? value) {
    city.value = value;
    cityError.value = null;
  }

  void onLanguageChanged(String? value) {
    if (value != null) language.value = value;
  }

  void pickAvatar() {
    // Integration point: image_picker (gallery/camera) + upload.
    CustomSnackbar.info('Photo upload will be available soon');
  }

  bool _validateDetails() {
    var valid = true;

    if (nameController.text.trim().length < 2) {
      nameError.value = 'Enter your full name';
      valid = false;
    }

    final email = emailController.text.trim();
    if (email.isNotEmpty && !_emailRegex.hasMatch(email)) {
      emailError.value = 'Enter a valid email address';
      valid = false;
    }

    if (city.value == null) {
      cityError.value = 'Select your city';
      valid = false;
    }

    return valid;
  }

  void continueFromDetails() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_validateDetails()) return;
    Get.toNamed(AppRoutes.preferences);
  }

  // ---------------- Step 2 actions ----------------

  void selectInterest(PropertyInterest value) => interest.value = value;

  void togglePropertyType(PropertyType type) {
    if (propertyTypes.contains(type)) {
      // Keep at least one type selected.
      if (propertyTypes.length > 1) propertyTypes.remove(type);
    } else {
      propertyTypes.add(type);
    }
  }

  void onBudgetChanged(RangeValues values) => budget.value = values;

  Future<void> completeSetup() async {
    if (isSubmitting.value) return;

    isSubmitting.value = true;
    try {
      // Integration point: save role, profile and preferences, e.g.
      // await _profileRepository.saveProfile(...);
      await Future<void>.delayed(const Duration(seconds: 1));

      Get.offAllNamed(AppRoutes.tenantDashboard);
    } catch (_) {
      CustomSnackbar.error('Could not save your details. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
  }

  // ---------------- Shared ----------------

  void back() => Get.back();

  void skipSetup() => Get.offAllNamed(AppRoutes.home);

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
