import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zee_palm/export.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final dynamic focusNode;
  final dynamic nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final dynamic onChanged;
  final dynamic onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final dynamic prefixIcon;
  final bool divider;
  final dynamic maxLength;

  CustomTextField({
    this.hintText = 'Write something...',
    required this.controller,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onSubmit,
    this.focusNode,
    this.nextFocus,
    this.onChanged,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.divider = false,
    this.maxLength,
  });

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          maxLines: maxLines,
          controller: controller,
          focusNode: focusNode,
          style:
              textStyles.bodyRegular.copyWith(fontSize: sizes.fontRatio * 16),
          textInputAction: inputAction,
          keyboardType: inputType,
          cursorColor: Theme.of(context).primaryColor,
          textCapitalization: capitalization,
          enabled: isEnabled,
          autofocus: false,
          obscureText: isPassword ? _obscureText : false,
          inputFormatters: inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ]
              : null,
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(style: BorderStyle.solid, width: 1),
            ),
            isDense: true,
            hintText: hintText,
            fillColor: Theme.of(context).cardColor,
            hintStyle: textStyles.bodyRegular.copyWith(
                fontSize: sizes.fontRatio * 20,
                color: Theme.of(context).hintColor),
            filled: true,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(prefixIcon, height: 20, width: 20),
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3)),
                    onPressed: () {},
                  )
                : null,
          ),
          onSubmitted: (text) => nextFocus != null
              ? FocusScope.of(context).requestFocus(nextFocus)
              : onSubmit != null
                  ? onSubmit(text)
                  : null,
          onChanged: onChanged,
          maxLength: maxLength,
        ),
        divider
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), child: Divider())
            : SizedBox(),
      ],
    );
  }
}
