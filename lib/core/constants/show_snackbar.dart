import 'package:flutter/material.dart';

import 'colors.dart';

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: greenAccentColor,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      content: Text(
        content,
        style: TextStyle(
          color: whiteColor,
          fontSize: 16,
        ),
      ),
    ),
  );
}
