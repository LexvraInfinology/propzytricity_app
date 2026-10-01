import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/core/constants/app_assets.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/property_filter_bar.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_search_bar.dart';
import 'package:propzytricity/app/widgets/app_svg.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';
import 'package:propzytricity/app/widgets/pill_chip.dart';
import 'package:propzytricity/app/widgets/promo_banner.dart';
import 'package:propzytricity/app/widgets/property_card.dart';

class ExploreTab extends GetView<TenantDashboardController> {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Obx(() {
        // Read inside the Obx so it rebuilds on every filter change.
        final results = controller.filteredProperties;
        final isEmpty = results.isEmpty;

        return ListView.builder(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          itemCount: isEmpty ? 2 : results.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return _Header(controller: controller, count: results.length);
            if (isEmpty) return _EmptyResults(controller: controller);

            final property = results[index - 1];
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
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.controller, required this.count});

  final TenantDashboardController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              CircleIconButton(
                icon: Icons.chevron_left_rounded,
                onTap: () => controller.changeTab(TenantDashboardController.homeTab),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Properties',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: FontFamily.plusJakartaSansBold,
                        color: AppColors.textPrimaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        '$count homes in ${controller.city.value}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.plusJakartaSansRegular,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CircleIconButton(
                icon: Icons.map_outlined,
                onTap: controller.openMap,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppSearchBar(
            controller: controller.searchController,
            focusNode: controller.searchFocus,
            onChanged: controller.onSearchChanged,
          ),
        ),
        const SizedBox(height: 14),

        // Category tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            final selected = controller.category.value;
            return Row(
              children: [
                PillChip(
                  label: 'All',
                  selected: selected == null,
                  onTap: () => controller.selectCategory(null),
                ),
                for (final category in PropertyCategory.values) ...[
                  const SizedBox(width: 8),
                  PillChip(
                    label: category.label,
                    selected: selected == category,
                    onTap: () => controller.selectCategory(category),
                  ),
                ],
              ],
            );
          }),
        ),
        const SizedBox(height: 12),
        PropertyFilterBar(controller: controller),
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() {
            final onlyVerified = controller.verifiedOnly.value;
            return PromoBanner(
              title: onlyVerified
                  ? 'Showing verified homes only'
                  : 'Explore verified homes',
              subtitle: onlyVerified
                  ? 'Tap the arrow to show all listings.'
                  : 'Only genuine listings, no fake ads.',
              onTap: controller.toggleVerifiedOnly,
            );
          }),
        ),
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$count Properties',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
              GestureDetector(
                onTap: controller.pickSort,
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppSvg(AppIcons.filterIcon, size: 14, color: AppColors.textBlack),
                    SizedBox(width: 4),
                    Text(
                      'Sort',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontFamily: FontFamily.plusJakartaSansMedium,
                        color: AppColors.textBlack,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: AppColors.textGrey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.controller});

  final TenantDashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'No properties found',
            style: TextStyle(
              fontSize: 16,
              fontFamily: FontFamily.plusJakartaSansSemiBold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try changing or clearing your filters.',
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Clear filters',
            expand: false,
            variant: CustomButtonVariant.outlined,
            onPressed: controller.clearFilters,
          ),
        ],
      ),
    );
  }
}
