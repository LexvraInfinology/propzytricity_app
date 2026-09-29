import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  void write(String key, dynamic value) => _box.write(key, value);

  T? read<T>(String key) => _box.read<T>(key);

  void remove(String key) => _box.remove(key);

  void clearAll() => _box.erase();

  // Common shortcuts
  String? get token => read<String>('token');
  set token(String? value) => write('token', value);

  bool get isLoggedIn => token != null && token!.isNotEmpty;
}
