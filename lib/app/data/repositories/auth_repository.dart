import 'package:get/get.dart';

import '../../core/base_repository.dart';
import '../../services/network_service.dart';
import '../../services/storage_service.dart';
import '../models/user_model.dart';

class AuthRepository extends BaseRepository {
  final NetworkService _network = Get.find<NetworkService>();
  final StorageService _storage = Get.find<StorageService>();

  Future<UserModel> login(String email, String password) async {
    return handleRequest(
      () => _network.postData('/login', {
        'email': email,
        'password': password,
      }),
      (data) {
        _storage.token = data['token'] ?? 'demo_token';
        return UserModel.fromJson(data['user'] ?? {
          'id': '1',
          'name': 'Demo User',
          'email': email,
        });
      },
    );
  }

  void logout() {
    _storage.token = null;
  }
}
