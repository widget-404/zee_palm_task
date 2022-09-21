import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../export.dart';

class AppRoutes {
  final arg;

  AppRoutes({this.arg});

  static List<GetPage> getPage = [
    GetPage(
      name: RouteNames.splashScreen,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteNames.tabs,
      page: () => Tabs(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: RouteNames.authScreen,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),
  ];

  static Future<dynamic>? appRoutes(final String routeName, {arg}) {
    switch (routeName) {
      //push to next
      case RouteNames.splashScreen:
        return Get.toNamed(routeName, arguments: arg);

        return Get.offAndToNamed(routeName, arguments: arg);

      //clear all and push
      case RouteNames.tabs:
      case RouteNames.authScreen:
        return Get.offAllNamed(routeName, arguments: arg);

      default:
        return _errorRoute();
    }
  }

  static Future<dynamic>? _errorRoute() {
    return Get.to(Container());
  }
}
