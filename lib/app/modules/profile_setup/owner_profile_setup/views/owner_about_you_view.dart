import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/controllers/owner_profile_setup_controller.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/models/tenant_setup_options.dart';
import 'package:propzytricity/app/widgets/avatar_picker.dart';
import 'package:propzytricity/app/widgets/labeled_dropdown.dart';
import 'package:propzytricity/app/widgets/labeled_text_field.dart';
import 'package:propzytricity/app/widgets/setup_step_scaffold.dart';

/// Owner setup, step 1 of 2: "Tell us about yourself".
class OwnerAboutYouView extends GetView<OwnerProfileSetupController> {
  const OwnerAboutYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return SetupStepScaffold(
      step: 1,
      totalSteps: 2,
      title: 'Tell us about yourself',
      subtitle: 'This helps us show you more relevant properties.',
      onBack: controller.back,
      onSkip: controller.skipSetup,
      onContinue: controller.continueFromDetails,
      child: Column(
        children: [
          AvatarPicker(onTap: controller.pickAvatar),
          const SizedBox(height: 28),
          Obx(
            () => LabeledTextField(
              label: 'Full Name',
              controller: controller.nameController,
              errorText: controller.nameError.value,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onChanged: controller.onNameChanged,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => LabeledTextField(
              label: 'Email Address (Optional)',
              controller: controller.emailController,
              errorText: controller.emailError.value,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onChanged: controller.onEmailChanged,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => LabeledDropdown<String>(
              label: 'City',
              hint: 'Select city',
              prefixIcon: Icons.location_on_outlined,
              items: SetupOptions.cities,
              value: controller.city.value,
              itemLabel: (city) => city,
              errorText: controller.cityError.value,
              onChanged: controller.onCityChanged,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => LabeledDropdown<String>(
              label: 'Preferred Language',
              prefixIcon: Icons.language_rounded,
              items: SetupOptions.languages,
              value: controller.language.value,
              itemLabel: (language) => language,
              onChanged: controller.onLanguageChanged,
            ),
          ),
        ],
      ),
    );
  }
}
