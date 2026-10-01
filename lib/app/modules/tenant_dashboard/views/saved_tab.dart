import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';
import 'package:propzytricity/app/widgets/property_card.dart';

/// Properties the user has hearted.
class SavedTab extends GetView<TenantDashboardController> {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleIconButton(
                  icon: Icons.chevron_left_rounded,
                  onTap: () => controller.changeTab(TenantDashboardController.homeTab),
                ),
                const Text(
                  'Saved Properties',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              final saved = controller.savedProperties;
              return saved.isEmpty ?
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 48,
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nothing saved yet',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: FontFamily.plusJakartaSansSemiBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tap the heart on a property to save it here.',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontFamily: FontFamily.plusJakartaSansRegular,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: '      Explore in home      ',
                      expand: false,
                      onPressed: controller.openExplore,
                    ),
                  ],
                ),
              ):
              ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                itemCount:  saved.length,
                itemBuilder: (context, index) {
                  final property = saved[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                    child: PropertyCard(
                      property: property,
                      imageAspectRatio: 1.45,
                      enableImagePager: true,
                      onTap: () => controller.openProperty(property),
                      onFavoriteTap: () => controller.toggleFavorite(property),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
