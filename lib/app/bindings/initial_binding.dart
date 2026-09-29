import 'package:get/get.dart';

import '../services/storage_service.dart';
import '../services/network_service.dart';
import '../data/repositories/auth_repository.dart';
import '../data/providers/api_provider.dart';
import '../data/repositories/post_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<NetworkService>(NetworkService(), permanent: true);
    Get.put<AuthRepository>(AuthRepository(), permanent: true);
    Get.put<ApiProvider>(ApiProvider(), permanent: true);
    Get.put<PostRepository>(PostRepository(), permanent: true);
  }
}
