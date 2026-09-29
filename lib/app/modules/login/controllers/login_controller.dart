import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/routes/app_routes.dart';
import 'package:propzytricity/app/widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  // ---------------- Phone step ----------------
  final phoneController = TextEditingController();
  final isLoading = false.obs;
  final phoneError = RxnString();

  static final RegExp _phoneRegex = RegExp(r'^[6-9]\d{9}$');

  // ---------------- OTP step ----------------
  static const int otpLength = 4;
  static const int resendSeconds = 30;

  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();
  final isVerifying = false.obs;
  final otpError = RxnString();
  final secondsLeft = 0.obs;

  Timer? _timer;

  /// 10-digit number typed on the login screen.
  String get phone => phoneController.text.trim();

  bool get canResend => secondsLeft.value == 0;

  String get formattedPhone => phone.length == 10
      ? '+91 ${phone.substring(0, 5)} ${phone.substring(5)}'
      : '+91 $phone';

  String get timerText {
    final s = secondsLeft.value;
    final mm = (s ~/ 60).toString().padLeft(2, '0');
    final ss = (s % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  // ---------------- Phone step actions ----------------

  void onPhoneChanged(String _) {
    if (phoneError.value != null) phoneError.value = null;
  }

  bool _validatePhone() {
    if (phone.isEmpty) {
      phoneError.value = 'Enter your mobile number';
      return false;
    }
    if (!_phoneRegex.hasMatch(phone)) {
      phoneError.value = 'Enter a valid 10-digit mobile number';
      return false;
    }
    phoneError.value = null;
    return true;
  }

  Future<void> sendOtp() async {
    if (isLoading.value) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_validatePhone()) return;

    isLoading.value = true;
    try {
      // Integration point: replace with the real call, e.g.
      // await _authRepository.sendOtp('+91$phone');
      await Future<void>.delayed(const Duration(seconds: 1));

      resetOtp();
      _startOtpTimer();
      CustomSnackbar.success('OTP sent to +91 $phone');
      Get.toNamed(AppRoutes.otp);
    } catch (_) {
      CustomSnackbar.error('Could not send OTP. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void continueWithGoogle() {
    // Integration point: google_sign_in + backend token exchange.
    CustomSnackbar.info('Google sign-in will be available soon');
  }

  void openTerms() {
    // Integration point: open the terms URL with url_launcher.
    CustomSnackbar.info('Terms & Privacy Policy');
  }

  // ---------------- OTP step actions ----------------

  void onOtpChanged(String _) {
    if (otpError.value != null) otpError.value = null;
  }

  Future<void> verifyOtp() async {
    if (isVerifying.value) return;

    final code = otpController.text.trim();
    if (code.length != otpLength) {
      otpError.value = 'Enter the $otpLength-digit code';
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    isVerifying.value = true;
    try {
      // Integration point: replace with the real call, e.g.
      // await _authRepository.verifyOtp(phone: phone, otp: code);
      await Future<void>.delayed(const Duration(seconds: 1));

      CustomSnackbar.success('Number verified');
      Get.offAllNamed(AppRoutes.role);
    } catch (_) {
      otpError.value = 'Invalid code. Please try again.';
      otpController.clear();
      otpFocusNode.requestFocus();
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend || isVerifying.value) return;

    otpController.clear();
    otpError.value = null;
    try {
      // Integration point: await _authRepository.sendOtp('+91$phone');
      await Future<void>.delayed(const Duration(seconds: 1));

      _startOtpTimer();
      CustomSnackbar.info('A new code has been sent');
      otpFocusNode.requestFocus();
    } catch (_) {
      CustomSnackbar.error('Could not resend the code. Please try again.');
    }
  }

  void changeNumber() => Get.back();

  void getOtpOnWhatsApp() {
    // Integration point: request the OTP over WhatsApp from the backend.
    CustomSnackbar.info('WhatsApp OTP will be available soon');
  }

  /// Clears the OTP step. Called when the OTP screen is left, so the login
  /// screen (same controller) starts clean if the user comes back.
  void resetOtp() {
    _timer?.cancel();
    secondsLeft.value = 0;
    otpController.clear();
    otpError.value = null;
    isVerifying.value = false;
  }

  void _startOtpTimer() {
    _timer?.cancel();
    secondsLeft.value = resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        secondsLeft.value = 0;
        timer.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    phoneController.dispose();
    otpController.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }
}
