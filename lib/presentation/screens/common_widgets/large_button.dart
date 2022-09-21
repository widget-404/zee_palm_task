import 'package:flutter/material.dart';
import 'package:zee_palm/export.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final dynamic onPressed;
  final bool isEnable;
  final bool isLoading;
  final double height;

  const LargeButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.height = 40,
      this.isEnable = true,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: sizes.width,
        height: sizes.heightRatio * height,
        decoration: BoxDecoration(
          color: isEnable ? null : colors.colorGrey,
          gradient: isEnable
              ? LinearGradient(
                  colors: [colors.accentPrimary, colors.accentSecondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyles.headingRegular.copyWith(
                    color: isEnable
                        ? colors.primaryLight
                        : colors.primaryDark.withOpacity(0.5),
                  ),
                ),
        ),
      ),
    );
  }
}
