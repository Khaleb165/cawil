import 'package:cawil/core/constants/size_config.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: greenAccentColor,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(20)),
      ),
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
