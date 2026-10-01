import 'package:flutter/material.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/price_formatter.dart';
import 'package:propzytricity/app/widgets/app_network_image.dart';

class ChatPropertyCard extends StatelessWidget {
  const ChatPropertyCard({super.key, required this.property, this.onTap});

  final PropertyModel property;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.otpBorderColor),
        ),
        child: Row(
          children: [
            AppNetworkImage(
              url: property.images.first,
              width: 46,
              height: 46,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontFamily: FontFamily.plusJakartaSansBold,
                      color: AppColors.textLightBlack,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: property.pricePerMonth.toInr,
                          style: const TextStyle(
                            fontSize: 13,
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
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
