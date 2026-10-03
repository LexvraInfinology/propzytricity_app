import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/controllers/owner_profile_setup_controller.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/models/owner_setup_options.dart';
import 'package:propzytricity/app/widgets/choice_card.dart';
import 'package:propzytricity/app/widgets/section_title.dart';
import 'package:propzytricity/app/widgets/setup_step_scaffold.dart';

/// Owner setup, step 2 of 2: "What would you like to do?".
class OwnerIntentView extends GetView<OwnerProfileSetupController> {
  const OwnerIntentView({super.key});

  static final _goalItems = [
    for (final e in OwnerGoal.values)
      ChoiceItem<OwnerGoal>(
        value: e,
        title: e.label,
        description: e.description,
        icon: e.icon,
      ),
  ];

  static final _typeItems = [
    for (final e in OwnerType.values)
      ChoiceItem<OwnerType>(
        value: e,
        title: e.label,
        description: e.description,
        icon: e.icon,
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SetupStepScaffold(
        step: 2,
        totalSteps: 2,
        title: 'What would you like to do?',
        subtitle: 'Choose how you want to use Propzy',
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
              () => ChoiceCardGroup<OwnerGoal>(
                items: _goalItems,
                selected: controller.goal.value,
                onSelected: controller.selectGoal,
              ),
            ),
            const SizedBox(height: 24),
            const SectionTitle('I am an'),
            const SizedBox(height: 12),
            Obx(
              () => ChoiceCardGroup<OwnerType>(
                items: _typeItems,
                selected: controller.ownerType.value,
                onSelected: controller.selectOwnerType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
