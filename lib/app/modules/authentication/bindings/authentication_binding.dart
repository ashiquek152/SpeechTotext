import 'package:get/get.dart';
import 'package:ninjastudy/app/modules/chatscreen/controllers/chatscreen_controller.dart';
import 'package:ninjastudy/app/modules/home/controllers/home_controller.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
     Get.lazyPut<ChatscreenController>(
      () => ChatscreenController(),
    );
  }
}
