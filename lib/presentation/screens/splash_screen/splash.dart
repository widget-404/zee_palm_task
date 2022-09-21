import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class Splash extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    controller.initialize(context: context);
    return Scaffold(
      backgroundColor: colors.primaryLight,
      body: Container(
        width: sizes.width,
        height: sizes.height,
        color: colors.primaryLight,
        child: Center(
          child: Text(
            'Welcome to Zee Palm Technologies',
            style: textStyles.headingRegular,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
