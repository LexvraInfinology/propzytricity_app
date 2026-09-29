import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propzytricity/app/modules/onboarding/models/onboarding_content.dart';
import 'package:propzytricity/app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  /// Read this in main.dart to decide the initial route.
  static const String storageKey = 'onboarding_done';


  static final int totalPages = 1 + OnboardingContent.features.length;

  final pageController = PageController();
  final currentPage = 0.obs;

  final _storage = GetStorage();

  bool get isFirstPage => currentPage.value == 0;
  bool get isLastPage => currentPage.value == totalPages - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (isLastPage) {
      finish();
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void back() {
    if (isFirstPage) return;
    pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void skip() => finish();

  Future<void> finish() async {
    await _storage.write(storageKey, true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
