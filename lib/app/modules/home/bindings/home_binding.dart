import 'package:get/get.dart';
import 'package:nop_commerce/app/modules/home/controllers/authentication_controller.dart';
import 'package:nop_commerce/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
