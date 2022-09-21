import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(Get.find()),
    );
  }
}
