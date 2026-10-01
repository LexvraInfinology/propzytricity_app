import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/widgets/pill_chip.dart';

/// Budget / BHK / Furnished / Property chips. Each opens a selection sheet and
/// shows the chosen value. On the home page set `goToExplore` so picking a
/// filter jumps to the results.
class PropertyFilterBar extends StatelessWidget {
  const PropertyFilterBar({
    super.key,
    required this.controller,
    this.goToExplore = false,
  });

  final TenantDashboardController controller;
  final bool goToExplore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(() {
        final budget = controller.budget.value;
        final bhk = controller.bhk.value;
        final furnishing = controller.furnishing.value;
        final category = controller.category.value;

        return Row(
          children: [
            PillChip(
              label: budget?.label ?? 'Budget',
              selected: budget != null,
              soft: true,
              showChevron: true,
              onTap: () => controller.pickBudget(goToExplore: goToExplore),
            ),
            const SizedBox(width: 8),
            PillChip(
              label: bhk?.label ?? 'BHK',
              selected: bhk != null,
              soft: true,
              showChevron: true,
              onTap: () => controller.pickBhk(goToExplore: goToExplore),
            ),
            const SizedBox(width: 8),
            PillChip(
              label: furnishing?.label ?? 'Furnished',
              selected: furnishing != null,
              soft: true,
              showChevron: true,
              onTap: () => controller.pickFurnishing(goToExplore: goToExplore),
            ),
            const SizedBox(width: 8),
            PillChip(
              label: category?.label ?? 'Property',
              selected: category != null,
              soft: true,
              showChevron: true,
              onTap: () => controller.pickCategory(goToExplore: goToExplore),
            ),
          ],
        );
      }),
    );
  }
}
