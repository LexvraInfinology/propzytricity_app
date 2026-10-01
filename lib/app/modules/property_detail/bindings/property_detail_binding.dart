import 'package:get/get.dart';
import 'package:propzytricity/app/modules/property_detail/controllers/property_detail_controller.dart';
import 'package:propzytricity/app/services/subscription_service.dart';

class PropertyDetailBinding extends Bindings {
  @override
  void dependencies() {
    // The plan must survive after this screen closes, so it is permanent.
    if (!Get.isRegistered<SubscriptionService>()) {
      Get.put<SubscriptionService>(SubscriptionService(), permanent: true);
    }
    Get.lazyPut<PropertyDetailController>(PropertyDetailController.new);
  }
}
