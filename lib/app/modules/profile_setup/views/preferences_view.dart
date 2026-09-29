import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/controllers/profile_setup_controller.dart';
import 'package:propzytricity/app/modules/profile_setup/models/setup_options.dart';
import 'package:propzytricity/app/widgets/budget_range_slider.dart';
import 'package:propzytricity/app/widgets/option_tile.dart';
import 'package:propzytricity/app/widgets/section_title.dart';
import 'package:propzytricity/app/widgets/setup_step_scaffold.dart';

/// Step 2 of 2.
class PreferencesView extends GetView<ProfileSetupController> {
  const PreferencesView({super.key});

  static final _interestItems = [
    for (final e in PropertyInterest.values)
      OptionItem<PropertyInterest>(value: e, label: e.label, icon: e.icon),
  ];

  static final _typeItems = [
    for (final e in PropertyType.values)
      OptionItem<PropertyType>(value: e, label: e.label, icon: e.icon),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SetupStepScaffold(
        step: 2,
        totalSteps: 2,
        title: 'What are you looking for?',
        subtitle:
            'Help us understand your preferences to show you better recommendations.',
        onBack: controller.back,
        onSkip: controller.skipSetup,
        onContinue: controller.completeSetup,
        isLoading: controller.isSubmitting.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle("I'm interested in"),
            const SizedBox(height: 12),
            Obx(
              () => OptionGrid<PropertyInterest>(
                items: _interestItems,
                selected: {controller.interest.value},
                onTap: controller.selectInterest,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle('Property type'),
            const SizedBox(height: 12),
            Obx(
              () => OptionGrid<PropertyType>(
                items: _typeItems,
                selected: controller.propertyTypes.toSet(),
                onTap: controller.togglePropertyType,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle('Budget range (per month)'),
            const SizedBox(height: 8),
            Obx(
              () => BudgetRangeSlider(
                values: controller.budget.value,
                min: SetupOptions.budgetMin,
                max: SetupOptions.budgetMax,
                onChanged: controller.onBudgetChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
