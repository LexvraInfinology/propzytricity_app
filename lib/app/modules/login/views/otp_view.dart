import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/login/controllers/login_controller.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/auth_sheet_scaffold.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';
import 'package:propzytricity/app/widgets/otp_input.dart';

class OtpView extends GetView<LoginController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Runs for the back button, swipe back and "Change number".
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) controller.resetOtp();
      },
      child: AuthSheetScaffold(child: _OtpForm(controller: controller)),
    );
  }
}

class _OtpForm extends StatelessWidget {
  const _OtpForm({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;

    return Column(
      children: [
        // Icon badge
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: const AppSvg(
            AppIcons.msgIcon,
            size: 56,
          ),
        ),
        const SizedBox(height: 16),

        Text(
          'Verify your number',
          style: AppTextStyles.heading1.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 8),
        const Text(
          "We've sent a ${LoginController.otpLength}-digit verification code to",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySecondary,
        ),
        const SizedBox(height: 4),
        Text(
          controller.formattedPhone,
          style: AppTextStyles.heading2.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: controller.changeNumber,
          child: const Text(
            'Change number',
            style: TextStyle(
              fontSize: 13,
              fontFamily: FontFamily.plusJakartaSansSemiBold,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 28),

        // OTP boxes
        Obx(
          () => OtpInput(
            boxHeight: 56,
            maxBoxWidth: 46,
            length: LoginController.otpLength,
            controller: controller.otpController,
            focusNode: controller.otpFocusNode,
            onChanged: controller.onOtpChanged,
            hasError: controller.otpError.value != null,
            autofocus: true,
          ),
        ),
        Obx(() {
          final error = controller.otpError.value;
          if (error == null) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              error,
              style: AppTextStyles.bodySecondary.copyWith(
                fontSize: 12,
                color: errorColor,
              ),
            ),
          );
        }),
        const SizedBox(height: 20),

        // Resend
        Obx(
          () => controller.canResend
              ? GestureDetector(
                  onTap: controller.resendOtp,
                  child: const Text(
                    'Resend code',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: FontFamily.plusJakartaSansSemiBold,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                )
              : Text.rich(
                  TextSpan(
                    text: 'Resend code in ',
                    style: AppTextStyles.bodySecondary,
                    children: [
                      TextSpan(
                        text: controller.timerText,
                        style: const TextStyle(
                          fontFamily: FontFamily.plusJakartaSansSemiBold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 24),

        // Verify
        Obx(
          () => CustomButton(
            text: 'Verify & Continue',
            trailing: const Icon(Icons.arrow_forward_rounded, size: 18),
            isLoading: controller.isVerifying.value,
            onPressed: controller.verifyOtp,
          ),
        ),
        const SizedBox(height: 16),

        // OR divider
        const Row(
          children: [
            Expanded(child: Divider(color: AppColors.otpBorderColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('OR', style: AppTextStyles.bodySecondary),
            ),
            Expanded(child: Divider(color: AppColors.otpBorderColor)),
          ],
        ),
        const SizedBox(height: 16),

        // WhatsApp
        CustomButton(
          text: 'Get OTP on WhatsApp',
          variant: CustomButtonVariant.outlined,
          onPressed: controller.getOtpOnWhatsApp,
          textStyle: AppTextStyles.buttonSmall,
          leading: const AppSvg(
            AppIcons.chatIcon,
            size: 18,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
