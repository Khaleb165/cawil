import 'package:cawil/core/constants/size_config.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final VoidCallback? onSubmitted;
  final int maxLength;

  CustomTextfield({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.maxLength = 50,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: (value) => onSubmitted?.call(),
      style: TextStyle(color: lightBlackColor),
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      maxLength: maxLength,
      obscureText: obscureText,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteColor, width: 0.0),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: lightBlackColor),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: whiteColor,
        contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: lightBlackColor,
          ),
        ),
      ),
    );
  }
}
