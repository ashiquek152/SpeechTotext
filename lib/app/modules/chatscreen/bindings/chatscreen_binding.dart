import 'package:get/get.dart';

import '../controllers/chatscreen_controller.dart';

class ChatscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatscreenController>(
      () => ChatscreenController(),
    );
  }
}
