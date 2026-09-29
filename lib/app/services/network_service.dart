import 'package:get/get.dart';
import 'storage_service.dart';

class NetworkService extends GetConnect {
  @override
  void onInit() {

    httpClient.baseUrl = 'https://jsonplaceholder.typicode.com';
    httpClient.timeout = const Duration(seconds: 15);

    httpClient.addRequestModifier<dynamic>((request) {
      final token = Get.find<StorageService>().token;
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      return response;
    });

    super.onInit();
  }

  Future<Response> getData(String path) => get(path);

  Future<Response> postData(String path, dynamic body) => post(path, body);

  Future<Response> putData(String path, dynamic body) => put(path, body);

  Future<Response> deleteData(String path) => delete(path);
}
