import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/initials_avatar.dart';

/// Greeting + city selector on the left, bell and avatar on the right.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.controller});

  final TenantDashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  '${controller.greeting}, ${controller.firstName}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: FontFamily.plusJakartaSansRegular,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: controller.pickCity,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 4),
                    Obx(
                      () => Text(
                        controller.city.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: FontFamily.plusJakartaSansBold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 22,
                      color: AppColors.textPrimaryLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CircleIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: controller.openNotifications,
        ),
        const SizedBox(width: 10),
        Obx(
          () => InitialsAvatar(
            name: controller.userName.value,
            onTap: () => controller.changeTab(4),
          ),
        ),
      ],
    );
  }
}
