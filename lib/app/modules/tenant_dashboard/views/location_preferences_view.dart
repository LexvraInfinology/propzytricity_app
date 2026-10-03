import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/app_search_bar.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';

class LocationPreferencesView extends GetView<TenantDashboardController> {
  const LocationPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(title: 'Location Preferences'),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSearchBar(
                      controller: controller.areaSearchController,
                      onChanged: controller.onAreaSearchChanged,
                    ),
                    const SizedBox(height: 20),

                    // Selected
                    Obx(() {
                      final selected = controller.selectedAreas.toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionLabel('Selected Locations (${selected.length})'),
                          const SizedBox(height: 10),
                          if (selected.isEmpty)
                            const Text(
                              'No locations selected yet. Add areas from the list below.',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.plusJakartaSansRegular,
                                color: AppColors.textGrey,
                              ),
                            )
                          else
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final area in selected)
                                  _SelectedChip(
                                    label: area,
                                    onRemove: () => controller.removeArea(area),
                                  ),
                              ],
                            ),
                        ],
                      );
                    }),
                    const SizedBox(height: 22),

                    // Popular / search results
                    Obx(() {
                      final areas = controller.availableAreas;
                      final searching = controller.areaQuery.value.trim().isNotEmpty;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionLabel(searching ? 'Search results' : 'Popular Areas'),
                          const SizedBox(height: 4),
                          if (areas.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                'No areas found.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.plusJakartaSansRegular,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            )
                          else
                            for (var i = 0; i < areas.length; i++) ...[
                              if (i > 0)
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: AppColors.otpBorderColor,
                                ),
                              _AreaRow(
                                label: areas[i],
                                onTap: () => controller.addArea(areas[i]),
                              ),
                            ],
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Row(
        children: [
          CircleIconButton(icon: Icons.chevron_left_rounded, onTap: Get.back),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: FontFamily.plusJakartaSansBold,
                  color: AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
          // Keeps the title centred.
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontFamily: FontFamily.plusJakartaSansBold,
        color: AppColors.textLightBlack,
      ),
    );
  }
}

/// Green chip with an x to remove the area.
class _SelectedChip extends StatelessWidget {
  const _SelectedChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: FontFamily.plusJakartaSansRegular,
              color: AppColors.textGreen,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.close_rounded, size: 13, color: AppColors.textGreen),
            ),
          ),
        ],
      ),
    );
  }
}

/// One suggested area: pin, name and a + to add it.
class _AreaRow extends StatelessWidget {
  const _AreaRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.textGrey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: FontFamily.plusJakartaSansMedium,
                  color: AppColors.textLightBlack,
                ),
              ),
            ),
            const Icon(Icons.add_rounded, size: 16, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
