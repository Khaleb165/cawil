import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final TextInputAction inputAction;
  final String hintText;
  final bool obscureText;
  final void Function(String)? onChanged;

  CustomTextfield({
    super.key,
    required this.controller,
    this.keyboard = TextInputType.text,
    this.inputAction = TextInputAction.next,
    required this.hintText,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black38),
      controller: controller,
      keyboardType: keyboard,
      textInputAction: inputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorWhite, width: 0.0),
          borderRadius: BorderRadius.circular(30),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: colorWhite,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              width: 1, style: BorderStyle.solid, color: Colors.black38),
        ),
      ),
    );
  }
}
