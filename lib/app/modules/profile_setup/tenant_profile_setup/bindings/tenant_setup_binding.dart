import 'package:get/get.dart';
import 'package:propzytricity/app/modules/profile_setup/tenant_profile_setup/controllers/tenant_setup_controller.dart';

class TenantSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TenantSetupController>(TenantSetupController.new);
  }
}
