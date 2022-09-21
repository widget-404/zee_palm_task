import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zee_palm/export.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final double height;
  final double borderWidth;
  final double borderRadius;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String icon;
  final bool isLoading;
  final onTap;

  const SocialLoginButton({
    required Key key,
    required this.text,
    this.height = 30,
    this.borderWidth = 1,
    this.borderRadius = 50,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: sizes.width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54.withOpacity(0.3),
                  blurRadius: 6.0,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  icon,
                  width: 30,
                  height: 30,
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      text,
                      style: textStyles.bodySmall.copyWith(
                        color: textColor,
                      ),
                    ),
              const SizedBox(
                width: 34,
              ),
            ],
          )),
    );
  }
}
