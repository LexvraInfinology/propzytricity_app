import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/owner_profile_setup/controllers/owner_profile_setup_controller.dart';

class OwnerProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerProfileSetupController>(OwnerProfileSetupController.new);
  }
}
