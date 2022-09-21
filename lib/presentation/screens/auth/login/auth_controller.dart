import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class AuthController extends GetxController with StateMixin<AuthPage> {
  final AuthUseCase useCase;
  final SharedPreferences storage;

  AuthController(this.useCase, this.storage);

  Rx<bool> googleButtonLoading = false.obs;
  Rx<bool> facebookButtonLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  loginWithGoogle() async {
    googleButtonLoading.value = true;
    final res = await useCase.loginWithGoogle();
    if (res.isRight()) {
      openTabPage();
    }
  }

  openTabPage() {
    AppRoutes.appRoutes(RouteNames.tabs);
  }
}
