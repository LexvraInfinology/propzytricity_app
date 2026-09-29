import 'package:get/get.dart';

import '../../core/base_repository.dart';
import '../models/post_model.dart';
import '../providers/api_provider.dart';

class PostRepository extends BaseRepository {
  final ApiProvider _provider = Get.find<ApiProvider>();

  Future<List<PostModel>> getPosts() {
    return handleRequest(
      () => _provider.fetchPosts(),
      (data) => (data as List).map((e) => PostModel.fromJson(e)).toList(),
    );
  }

  Future<PostModel> createPost(PostModel post) {
    return handleRequest(
      () => _provider.createPost(post.toJson()),
      (data) => PostModel.fromJson(data),
    );
  }

  Future<PostModel> updatePost(PostModel post) {
    return handleRequest(
      () => _provider.updatePost(post.id!, post.toJson()),
      (data) => PostModel.fromJson(data),
    );
  }

  Future<void> deletePost(int id) {
    return handleRequest(
      () => _provider.deletePost(id),
      (_) => null,
    );
  }
}
