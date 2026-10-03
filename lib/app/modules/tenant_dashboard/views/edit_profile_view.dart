import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propzytricity/app/data/models/property_model.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/models/tenant_setup_options.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/controllers/tenant_dashboard_controller.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/data/tenant_dashboard_mock_data.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/labeled_input_field.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/labeled_select_field.dart';
import 'package:propzytricity/app/modules/tenant_dashboard/widgets/profile_avatar.dart';
import 'package:propzytricity/app/theme/app_colors.dart';
import 'package:propzytricity/app/theme/app_fonts.dart';
import 'package:propzytricity/app/widgets/circle_icon_button.dart';
import 'package:propzytricity/app/widgets/section_title.dart';

class EditProfileView extends GetView<TenantDashboardController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircleIconButton(
                        icon: Icons.chevron_left_rounded,
                        onTap: Get.back,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.plusJakartaSansBold,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 64,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Obx(
                        () => controller.isSavingProfile.value
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: AppColors.primary,
                                ),
                              )
                            : GestureDetector(
                                onTap: controller.saveProfile,
                                behavior: HitTestBehavior.opaque,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: FontFamily.plusJakartaSansBold,
                                      color: AppColors.textGreen,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Obx(
                            () => ProfileAvatar(
                              name: controller.userName.value,
                              imagePath: controller.avatarPath.value,
                              size: 84,
                              showCameraBadge: true,
                              onTap: controller.changePhoto,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: controller.changePhoto,
                            child: const Text(
                              'Change Photo',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: FontFamily.plusJakartaSansBold,
                                color: AppColors.textGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    Obx(
                      () => LabeledInputField(
                        label: 'Full Name',
                        controller: controller.editNameController,
                        errorText: controller.editNameError.value,
                        textCapitalization: TextCapitalization.words,
                        onChanged: controller.onEditNameChanged,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(
                      () => LabeledInputField(
                        label: 'Email Address',
                        readOnlyValue: controller.userEmail.value,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(
                      () => LabeledInputField(
                        label: 'Phone Number',
                        controller: controller.editPhoneController,
                        errorText: controller.editPhoneError.value,
                        prefixText: '+91',
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: controller.onEditPhoneChanged,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Obx(
                      () => LabeledSelectField<String>(
                        label: 'Location',
                        prefixIcon: Icons.location_on_outlined,
                        items: TenantDashboardMock.locations,
                        value: controller.editLocation.value,
                        itemLabel: (location) => location,
                        onChanged: (value) => controller.editLocation.value = value,
                      ),
                    ),
                    const SizedBox(height: 16),

                    LabeledInputField(
                      label: 'About You (Optional)',
                      controller: controller.editAboutController,
                      hint: 'Tell owners a little about what you need',
                      maxLines: 4,
                      maxLength: TenantDashboardController.aboutMaxLength,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 24),

                    const SectionTitle('Property Preferences',
                      fontFamily: FontFamily.plusJakartaSansBold,),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(
                            () => LabeledSelectField<PropertyInterest>(
                              label: 'Looking for',
                              items: PropertyInterest.values,
                              value: controller.editLookingFor.value,
                              itemLabel: (item) => item.label,
                              onChanged: (value) =>
                                  controller.editLookingFor.value = value,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(
                            () => LabeledSelectField<PropertyCategory>(
                              label: 'Property Type',
                              items: PropertyCategory.values,
                              value: controller.editType.value,
                              itemLabel: (item) => item.label,
                              onChanged: (value) =>
                                  controller.editType.value = value,
                            ),
                          ),
                        ),
                      ],
                    ),
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


