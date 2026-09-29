import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/modules/login/controllers/login_controller.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const double _overlap = 32;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final heroHeight = size.height * 0.50;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height,
            child: const AssetPhoto(
              AppAssets.loginBackground,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SizedBox(height: heroHeight - _overlap),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: size.height - heroHeight + _overlap,
                  ),
                  padding: EdgeInsets.fromLTRB(24, 28, 24, 24 + bottomPad),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: _LoginForm(controller: controller),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to',
          style: AppTextStyles.heading2.copyWith(fontSize: 22),
        ),
        Text(
          'PROPZY',
          style: AppTextStyles.heading1.copyWith(
            fontSize: 34,
            height: 1.15,
            color: AppColors.primary,
            fontFamily: FontFamily.plusJakartaSansExtraBold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sign in to continue to your next home.',
          style: AppTextStyles.bodySecondary,
        ),
        const SizedBox(height: 24),

        // Mobile number
        Obx(
              () => TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            onChanged: controller.onPhoneChanged,
            onSubmitted: (_) => controller.sendOtp(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            style: AppTextStyles.body,
            decoration: InputDecoration(
              hintText: 'Enter mobile number',
              hintStyle: AppTextStyles.bodySecondary,
              errorText: controller.phoneError.value,
              prefixIcon: const _CountryCode(),
              prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Send OTP
        Obx(
              () => CustomButton(
            text: 'Send OTP',
            trailing: const Icon(Icons.arrow_forward_rounded, size: 18),
            isLoading: controller.isLoading.value,
            onPressed: controller.sendOtp,
          ),
        ),
        const SizedBox(height: 20),

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
        const SizedBox(height: 20),

        // Google
        CustomButton(
          text: 'Continue with Google',
          variant: CustomButtonVariant.outlined,
          onPressed: controller.continueWithGoogle,
          leading: const AppSvg(AppIcons.googleIcon, size: 20),
        ),
        const SizedBox(height: 32),

        // Terms
        Center(
          child: Column(
            children: [
              Text(
                'By continuing, you agree to our',
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 11),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: controller.openTerms,
                child: Text(
                  'Terms & Privacy Policy',
                  style: AppTextStyles.bodySecondary.copyWith(
                    fontSize: 11,
                    decoration: TextDecoration.underline,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CountryCode extends StatelessWidget {
  const _CountryCode();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('+91', style: AppTextStyles.body),
          SizedBox(width: 2),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: AppColors.textBlack,
          ),
        ],
      ),
    );
  }
}