import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/property_detail_model.dart';
import 'package:propzytricity/app/modules/property_detail/controllers/property_detail_controller.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/amenity_tile.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/bottom_action_bar.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/detail_hero.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/details_icon_tab_bar.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/info_stat_strip.dart';
import 'package:propzytricity/app/modules/property_detail/widgets/map_preview_card.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/utils/price_formatter.dart';
import 'package:propzytricity/app/widgets/asset_photo.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/custom_button.dart';
import 'package:propzytricity/app/widgets/expandable_text.dart';
import 'package:propzytricity/app/widgets/icon_tab_bar.dart';
import 'package:propzytricity/app/widgets/property_card.dart';
import 'package:propzytricity/app/widgets/section_header.dart';

import '../widgets/status_pill.dart';

class PropertyDetailView extends GetView<PropertyDetailController> {
  const PropertyDetailView({super.key});

  /// How far the rounded sheet slides up over the photo.
  static const double _sheetOverlap = 24;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final topPad = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          Obx(() {
            final detail = controller.detail.value;
            if (detail == null) return const SizedBox.shrink();

            return SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  Obx(
                    () => DetailHero(
                      images: detail.photos,
                      controller: controller.heroController,
                      currentIndex: controller.heroIndex.value,
                      onPageChanged: controller.onHeroChanged,
                      onImageTap: (i) => controller.openImages(detail.photos, i),
                      height: size.height * 0.40,
                      bottomInset: _sheetOverlap + 16,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -_sheetOverlap),
                    child: _DetailSheet(controller: controller, detail: detail),
                  ),
                ],
              ),
            );
          }),

          // Floating actions
          Positioned(
            top: topPad + 8,
            left: 16,
            right: 16,
            child: Row(
              children: [
                CircleIconButton(
                  icon: Icons.chevron_left_rounded,
                  size: 40,
                  onTap: Get.back,
                ),
                const Spacer(),
                Obx(
                  () => FavoriteButton(
                    selected: controller.isFavorite.value,
                    onTap: controller.toggleFavorite,
                  ),
                ),
                const SizedBox(width: 10),
                CircleIconButton(
                  icon: Icons.share_outlined,
                  size: 36,
                  onTap: controller.share,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => controller.hasPlan
            ? _ContactBar(controller: controller)
            : _PlanPromptBar(controller: controller),
      ),
    );
  }
}

class _DetailSheet extends StatelessWidget {
  const _DetailSheet({required this.controller, required this.detail});

  final PropertyDetailController controller;
  final PropertyDetailModel detail;

  static const _tabs = [
    IconTabItem(icon: Icons.photo_library_outlined, label: 'Photos'),
    IconTabItem(icon: Icons.play_circle_outline_rounded, label: 'Video'),
    IconTabItem(icon: Icons.grid_view_rounded, label: 'Floor Plan'),
    IconTabItem(icon: Icons.location_on_outlined, label: 'Map'),
  ];

  @override
  Widget build(BuildContext context) {
    final p = detail.property;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 48),
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => DetailsIconTabBar(
                    items: _tabs,
                    selectedIndex: controller.activeTab.value,
                    onTap: controller.selectTab,
                  ),
                ),
                const SizedBox(height: 20),

                // Price + verified
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: PriceFormatter.rupees(p.pricePerMonth),
                          style: const TextStyle(
                            fontSize: 26,
                            fontFamily: FontFamily.plusJakartaSansBold,
                            color: AppColors.primary,
                          ),
                          children: const [
                            TextSpan(
                              text: ' /month',
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: FontFamily.plusJakartaSansRegular,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (p.isVerified)
                      const StatusPill(
                        label: 'Verified',
                        icon: Icons.check_circle_rounded,
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  p.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: FontFamily.plusJakartaSansBold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        p.location,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontFamily: FontFamily.plusJakartaSansRegular,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    PropertyTag('${p.bhk} BHK'),
                    PropertyTag('${PriceFormatter.number(p.areaSqFt)} sq.ft'),
                    PropertyTag(p.furnishing.label),
                    PropertyTag(p.category.label),
                  ],
                ),
                const SizedBox(height: 16),
                InfoStatStrip(
                  stats: [
                    InfoStat(
                      icon: Icons.person_outline_rounded,
                      label: 'Posted by',
                      value: detail.postedBy,
                    ),
                    InfoStat(
                      icon: Icons.calendar_today_outlined,
                      label: 'Available from',
                      value: detail.availableFrom,
                    ),
                    InfoStat(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Deposit',
                      value: PriceFormatter.rupees(detail.deposit),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // About
                const SectionHeader(title: 'About this property'),
                const SizedBox(height: 10),
                ExpandableText( text: detail.description),
                const SizedBox(height: 24),

                // Amenities
                Obx(() {
                  final all = detail.amenities;
                  final expanded = controller.amenitiesExpanded.value;
                  final shown = expanded ? all : all.take(8).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Amenities',
                        seeAllLabel: expanded ? 'Show less' : 'See all',
                        onSeeAll: all.length > 8 ? controller.toggleAmenities : null,
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.95,
                        children: [
                          for (final amenity in shown)
                            AmenityTile(icon: amenity.icon, label: amenity.label),
                        ],
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 24),

                // Photos
                KeyedSubtree(
                  key: controller.photosKey,
                  child: Obx(() {
                    final photos = detail.photos;
                    final expanded = controller.photosExpanded.value;
                    final shown = expanded ? photos : photos.take(6).toList();
                    final hasMore = photos.length > 6;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: 'Property photos',
                          seeAllLabel: expanded ? 'Show less' : 'See all',
                          onSeeAll: hasMore
                              ? controller.togglePhotos
                              : () => controller.openImages(photos, 0),
                        ),
                        const SizedBox(height: 12),
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.1,
                          children: [
                            for (var i = 0; i < shown.length; i++)
                              GestureDetector(
                                onTap: () => controller.openImages(photos, i),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: AssetPhoto(shown[i]),
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Location
                KeyedSubtree(
                  key: controller.mapKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Location',
                        seeAllLabel: 'View on Map',
                        onSeeAll: controller.openMap,
                      ),
                      const SizedBox(height: 12),
                      MapPreviewCard(
                        image: detail.mapImage,
                        address: detail.address,
                        onTap: controller.openMap,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Floor plan
                KeyedSubtree(
                  key: controller.floorPlanKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: 'Floor plan',
                        seeAllLabel: 'View full plan',
                        onSeeAll: controller.openFloorPlan,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: controller.openFloorPlan,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.otpBorderColor),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AssetPhoto(
                                detail.floorPlanImage,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                SectionHeader(
                  title: 'Similar properties',
                  onSeeAll: controller.seeAllSimilar,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // Similar properties bleed to the screen edges.
          SizedBox(
            height: 345,
            child: Obx(() {
              final items = controller.similarProperties;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, i) {
                  final property = items[i];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: PropertyCard(
                      width: 280,
                      property: property,
                      onTap: () => controller.openSimilar(property),
                      onFavoriteTap: () => controller.toggleFavoriteOf(property),
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

/// Shown until the user has a plan.
class _PlanPromptBar extends StatelessWidget {
  const _PlanPromptBar({required this.controller});

  final PropertyDetailController controller;

  @override
  Widget build(BuildContext context) {
    return BottomActionBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interested in this property?',
            style: TextStyle(
              fontSize: 14,
              fontFamily: FontFamily.plusJakartaSansBold,
              color: AppColors.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Unlock owner contact details and start an enquiry with PROPZY plan.',
            style: TextStyle(
              fontSize: 11.5,
              height: 1.4,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 12),
          CustomButton(text: 'Choose Plan', onPressed: controller.openChoosePlan),
        ],
      ),
    );
  }
}

/// Shown once a plan is active.
class _ContactBar extends StatelessWidget {
  const _ContactBar({required this.controller});

  final PropertyDetailController controller;

  @override
  Widget build(BuildContext context) {
    return BottomActionBar(
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Enquire',
              variant: CustomButtonVariant.outlined,
              onPressed: controller.enquire,
              leading: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomButton(
              text: 'Call',
              onPressed: controller.callOwner,
              leading: const Icon(
                Icons.call_rounded,
                size: 18,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
