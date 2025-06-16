import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppName extends StatelessWidget {
  final double fontSize;
  const AppName({
    super.key, required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ca',
          style: TextStyle(
              fontSize: fontSize,
              color: primary1,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Wil',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(19, 41, 75, 1),
          ),
        ),
      ],
    );
  }
}
