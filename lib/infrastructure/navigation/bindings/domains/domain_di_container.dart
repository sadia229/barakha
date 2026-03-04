import 'package:get/get.dart';
import 'package:ramadan/presentation/chat/controllers/chat.controller.dart';
import 'package:ramadan/presentation/home/controllers/home.controller.dart';

class DomainLayerDependencyInjectionContainer {
  static Future<void> init() async {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
      fenix: true,
    );
  }
}
