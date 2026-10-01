import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/enquiry_card.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/pill_filter_bar.dart';

class EnquiriesView extends GetView<TenantDashboardController> {
  const EnquiriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => controller.changeTab(TenantDashboardController.homeTab),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Enquiries',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontFamily.plusJakartaSansBold,
                            color: AppColors.textPrimaryLight,
                          ),
                        ),
                        SizedBox(height: 2),
                    Text('Track all your property enquiries',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: FontFamily.plusJakartaSansRegular,
                              color: AppColors.textGrey,
                            ),
                          ),

                      ],
                    ),
                  ),
                  CircleIconButton(
                    icon: Icons.notifications_none,
                    onTap: controller.openNotifications,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => PillFilterBar(
                labels: TenantDashboardController.filterLabels,
                selectedIndex: controller.selectedFilter.value.index,
                onSelected: controller.onFilterSelected,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Obx(() {
                final items = controller.filtered;
                if (items.isEmpty) return const _EmptyState();
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 14),
                  itemBuilder: (context, i) {
                    final e = items[i];
                    return EnquiryCard(
                      enquiry: e,
                      onTap: () => controller.openChat(e),
                      onView: () => controller.openChat(e),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.forum_outlined, size: 44, color: AppColors.textGrey),
          SizedBox(height: 10),
          Text(
            'No enquiries here yet',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textLightBlack,
            ),
          ),
        ],
      ),
    );
  }
}
