import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class TabsController extends GetxController with StateMixin<Tabs> {
  Rx<int> tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => HomeController(
          Get.find(),
        ));
    Get.lazyPut(() => SubmitOfferController(Get.find()));
    Get.lazyPut(
      () => ChatScreenController(
        Get.find(),
        Get.find(),
      ),
    );
  }

  onChangeTab(int index) {
    tabIndex.value = index;
  }
}
