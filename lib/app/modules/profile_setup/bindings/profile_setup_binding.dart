import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/controllers/profile_setup_controller.dart';

class ProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSetupController>(ProfileSetupController.new);
  }
}
