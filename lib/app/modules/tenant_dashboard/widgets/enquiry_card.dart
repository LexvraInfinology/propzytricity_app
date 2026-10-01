import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/enquiry_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/date_time_extension.dart';
import 'package:propzytricity/app/utils/price_formatter.dart';
import 'package:propzytricity/app/widgets/app_network_image.dart';
import 'package:propzytricity/app/widgets/pill_filter_bar.dart';

class EnquiryCard extends StatelessWidget {
  const EnquiryCard({
    super.key,
    required this.enquiry,
    required this.onTap,
    required this.onView,
  });

  final EnquiryModel enquiry;
  final VoidCallback onTap;
  final VoidCallback onView;

  Color get _statusColor => enquiry.status == EnquiryStatus.awaiting
      ? AppColors.warning
      : AppColors.primaryLight;

  @override
  Widget build(BuildContext context) {
    final p = enquiry.property;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.otpBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  url: p.images.first,
                  width: 78,
                  height: 78,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              p.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: FontFamily.plusJakartaSansBold,
                                color: AppColors.textLightBlack,
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 13, color: AppColors.textGrey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              p.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12,
                                  fontFamily: FontFamily.plusJakartaSansRegular,
                                  color: AppColors.textGrey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: p.pricePerMonth.toInr,
                              style: const TextStyle(
                                fontSize: 15,
                              fontFamily: FontFamily.plusJakartaSansBold,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            const TextSpan(
                              text: ' /month',
                              style: TextStyle(fontSize: 11,
                                  fontFamily: FontFamily.plusJakartaSansRegular,
                                  color: AppColors.textGrey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          TagPill(label: '${p.bhk} BHK'),
                          TagPill(label: p.furnishing.label),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.otpBorderColor),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: _statusColor, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enquiry.status.label,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontFamily: FontFamily.plusJakartaSansSemiBold,
                          color: AppColors.textLightBlack,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        enquiry.updatedAt.enquiryLabel,
                        style: const TextStyle(fontSize: 11,
                            fontFamily: FontFamily.plusJakartaSansRegular,
                            color: AppColors.textGrey),
                      ),
                    ],
                  ),
                ),
                AppOutlinedButton(label: 'View', onPressed: onView),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 34,
    this.minWidth = 72,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(minWidth, height),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight, width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12,
               fontFamily: FontFamily.plusJakartaSansMedium),
        ),
      ),
    );
  }
}
