import 'package:flutter/material.dart';
import 'package:propzytricity/app/modules/onboarding/models/onboarding_content.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';

class FloatingTag extends StatelessWidget {
  const FloatingTag({super.key, required this.data});

  final FloatingTagData data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final compact = data.compact;

    return Container(
      width: compact ? null: data.subLabel != null ? size.width*0.4:size.width*0.5,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 7 : 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(compact ? 20 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (compact)
            AppSvg(data.icon, size: 15,)
          else
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: AppSvg(data.icon, size: 18,),
            ),
          SizedBox(width: compact ? 6 : 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.label,
                style: TextStyle(
                  fontSize: compact ? 11 : 13,
                  fontFamily: data.subLabel != null ? FontFamily.plusJakartaSansBold:FontFamily.plusJakartaSansSemiBold,
                  color: AppColors.textLightBlack,
                ),
              ),
              if (data.subLabel != null)
                Text(
                  data.subLabel!,
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: FontFamily.plusJakartaSansMedium,
                    color: AppColors.textGrey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
