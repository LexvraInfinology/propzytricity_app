import '../../services/network_service.dart';
import 'package:get/get.dart';


class ApiProvider {
  final NetworkService _network = Get.find<NetworkService>();

  Future<Response> fetchPosts() => _network.getData('/posts?_limit=15');

  Future<Response> fetchPost(int id) => _network.getData('/posts/$id');

  Future<Response> createPost(Map<String, dynamic> body) =>
      _network.postData('/posts', body);

  Future<Response> updatePost(int id, Map<String, dynamic> body) =>
      _network.putData('/posts/$id', body);

  Future<Response> deletePost(int id) => _network.deleteData('/posts/$id');
}
