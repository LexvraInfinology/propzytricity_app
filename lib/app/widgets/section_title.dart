import 'package:flutter/material.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/theme/app_text_styles.dart';

/// Small heading above a group of fields or options.
class SectionTitle extends StatelessWidget {
const  SectionTitle( this.text,
{super.key,
  this.fontFamily = FontFamily.plusJakartaSansSemiBold,
  });


  final String text;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(
        fontSize: 12,
        fontFamily: fontFamily,
        color: AppColors.textLightBlack,
      ),
    );
  }
}
