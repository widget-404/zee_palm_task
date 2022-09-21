import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zee_palm/export.dart';

class SplashController extends GetxController with StateMixin<Splash> {
  final SharedPreferences storage;

  SplashController(this.storage);

  bool isInitialized = false;

  @override
  void onInit() {
    super.onInit();
  }

  void initialize({required BuildContext context}) async {
    if (!isInitialized) {
      final di = GetInstance();
      initAppResources(context);
      Future.delayed(const Duration(seconds: 2), () async {
        choseRoute();
      });
    }
  }

  void initAppResources(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      initializeAppResources(context: context);
    }
  }

  void navigateToLogin() {
    AppRoutes.appRoutes(RouteNames.authScreen);
  }

  void navigateToHome() {
    AppRoutes.appRoutes(RouteNames.tabs);
  }

  choseRoute() {
    String userId = storage.getString(constant.userId) ?? '';
    if (userId.isEmpty) {
      navigateToLogin();
    } else {
      navigateToHome();
    }
  }
}
