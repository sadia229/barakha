import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool isLoggedIn = false.obs;
  final Rx<Map<String, dynamic>?> userData = Rx<Map<String, dynamic>?>(null);
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
