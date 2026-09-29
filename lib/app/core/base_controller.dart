import 'package:get/get.dart';
import '../widgets/custom_snackbar.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void setLoading(bool value) => isLoading.value = value;

  Future<void> runSafely(Future<void> Function() action, {
    bool showErrorSnackbar = true,
  }) async {
    try {
      setLoading(true);
      errorMessage.value = '';
      await action();
    } catch (e) {
      errorMessage.value = e.toString();
      if (showErrorSnackbar) {
        CustomSnackbar.error(errorMessage.value);
      }
    } finally {
      setLoading(false);
    }
  }
}
