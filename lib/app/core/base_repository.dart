import 'package:get/get.dart';

abstract class BaseRepository {
  Future<T> handleRequest<T>(Future<Response> Function() request,
      T Function(dynamic data) onSuccess) async {
    final response = await request();

    if (response.isOk) {
      return onSuccess(response.body);
    } else {
      throw Exception(response.statusText ?? 'Something went wrong');
    }
  }
}
