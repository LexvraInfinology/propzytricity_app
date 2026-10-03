import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/home_header.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/property_filter_bar.dart';
import 'package:propzytricity/app/widgets/app_search_bar.dart';
import 'package:propzytricity/app/widgets/category_tile.dart';
import 'package:propzytricity/app/widgets/locality_card.dart';
import 'package:propzytricity/app/widgets/property_card.dart';
import 'package:propzytricity/app/widgets/section_header.dart';

class HomeTab extends GetView<TenantDashboardController> {
  const HomeTab({super.key});

  static const double _cardWidth = 280;
  static const double _cardListHeight = 345;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: HomeHeader(controller: controller),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppSearchBar(readOnly: true, onTap: controller.focusSearch),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final category in PropertyCategory.values)
                  CategoryTile(
                    icon: category.icon,
                    label: category.plural,
                    onTap: () => controller.openCategory(category),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PropertyFilterBar(controller: controller, goToExplore: true),
          const SizedBox(height: 24),
          // Recommended
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SectionHeader(
              title: 'Recommended for you',
              subtitle: 'Based on Mohali and your recent views',
              onSeeAll: controller.openExplore,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => _propertyList(controller.recommended)),
          // Localities
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SectionHeader(
              title: 'Explore Popular Localities',
              subtitle: 'Based on Mohali and your recent views',
              onSeeAll: controller.openExplore,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: Obx(() {
              final items = controller.localities.toList();
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) => LocalityCard(
                  locality: items[i],
                  onTap: () => controller.openLocality(items[i]),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          // Recently added
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SectionHeader(
              title: 'Recently added',
              subtitle: 'Fresh listings this week',
              onSeeAll: controller.openExplore,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => _propertyList(controller.recentlyAdded)),
        ],
      ),
    );
  }

  Widget _propertyList(List<PropertyModel> items) {
    return SizedBox(
      height: _cardListHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, i) {
          final property = items[i];
          return Align(
            alignment: Alignment.topCenter,
            child: PropertyCard(
              width: _cardWidth,
              property: property,
              onTap: () => controller.openProperty(property),
              onFavoriteTap: () => controller.toggleFavorite(property),
            ),
          );
        },
      ),
    );
  }
}
