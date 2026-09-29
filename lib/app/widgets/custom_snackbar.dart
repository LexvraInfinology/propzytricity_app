import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

enum SnackType { success, error, warning, info }

class CustomSnackbar {
  CustomSnackbar._();

  static void success(String message, {String title = 'Success'}) {
    _show(title: title, message: message, type: SnackType.success);
  }

  static void error(String message, {String title = 'Error'}) {
    _show(title: title, message: message, type: SnackType.error);
  }

  static void warning(String message, {String title = 'Warning'}) {
    _show(title: title, message: message, type: SnackType.warning);
  }

  static void info(String message, {String title = 'Info'}) {
    _show(title: title, message: message, type: SnackType.info);
  }

  static void _show({
    required String title,
    required String message,
    required SnackType type,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    final config = _configFor(type);

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: config.background,
      colorText: Colors.white,
      icon: Icon(config.icon, color: Colors.white),
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 1),
      snackStyle: SnackStyle.FLOATING,
      forwardAnimationCurve: Curves.easeOutBack,
      isDismissible: true,
    );
  }

  static _SnackConfig _configFor(SnackType type) {
    switch (type) {
      case SnackType.success:
        return _SnackConfig(AppColors.success, Icons.check_circle_outline);
      case SnackType.error:
        return _SnackConfig(AppColors.error, Icons.error_outline);
      case SnackType.warning:
        return _SnackConfig(AppColors.warning, Icons.warning_amber_outlined);
      case SnackType.info:
        return _SnackConfig(AppColors.info, Icons.info_outline);
    }
  }
}

class _SnackConfig {
  final Color background;
  final IconData icon;
  _SnackConfig(this.background, this.icon);
}
