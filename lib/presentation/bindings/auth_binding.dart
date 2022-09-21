import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(Get.find(), Get.find()));
  }
}
