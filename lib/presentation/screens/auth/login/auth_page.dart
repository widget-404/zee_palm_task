import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zee_palm/export.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryLight,
      body: Container(
        width: sizes.width,
        height: sizes.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Zee Palm Technologies',
              style: textStyles.headingRegular,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'By clicking Log In, you agree with our ',
                    style: textStyles.bodyExtraSmall,
                    children: [
                      TextSpan(
                        text: 'Terms',
                        style: textStyles.bodySmall.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '. Learn how we process your data in our ',
                        style: textStyles.bodyExtraSmall,
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: textStyles.bodySmall
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: textStyles.bodyExtraSmall,
                      ),
                      TextSpan(
                        text: 'Cookies Policy.',
                        style: textStyles.bodySmall.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ])),
            SizedBox(height: sizes.heightRatio * 20),
            Obx(() {
              return SocialLoginButton(
                height: sizes.heightRatio * 50,
                text: 'LOGIN WITH GOOGLE',
                icon: assets.icGoogle,
                textColor: colors.primaryDark,
                backgroundColor: colors.primaryLight,
                borderColor: colors.primaryLight,
                isLoading: controller.googleButtonLoading.value,
                key: const Key('google'),
                onTap: controller.loginWithGoogle,
              );
            }),
            SizedBox(height: sizes.heightRatio * 20),
            Obx(() {
              return SocialLoginButton(
                height: sizes.heightRatio * 50,
                text: 'LOGIN WITH FACEBOOK',
                icon: assets.icFacebook,
                textColor: colors.primaryDark,
                backgroundColor: colors.primaryLight,
                borderColor: colors.primaryLight,
                isLoading: controller.facebookButtonLoading.value,
                key: const Key('facebook'),
              );
            }),
            SizedBox(height: sizes.heightRatio * 20),
          ],
        ),
      ),
    );
  }
}
