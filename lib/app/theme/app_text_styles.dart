import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading1 = TextStyle(
    fontSize: 26,
    fontFamily: FontFamily.plusJakartaSansBold,
    color: AppColors.textBlack,
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontFamily: FontFamily.plusJakartaSansSemiBold,
    color: AppColors.textBlack,
  );

  static const body = TextStyle(
    fontSize: 15,
    fontFamily: FontFamily.plusJakartaSansRegular,
    color: AppColors.textBlack,
  );

  static const bodySecondary = TextStyle(
    fontSize: 13,
    fontFamily: FontFamily.plusJakartaSansRegular,
    color: AppColors.textGrey,
  );

  static const button = TextStyle(
    fontSize: 15,
    fontFamily: FontFamily.plusJakartaSansSemiBold,
    color: Colors.white,
  );
  static const buttonSmall = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.plusJakartaSansSemiBold,
    color: Colors.white,
  );
}