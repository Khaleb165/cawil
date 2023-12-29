import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Ca',
          style: TextStyle(
              fontSize: 50,
              color: primary1,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Wil',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(19, 41, 75, 1),
          ),
        ),
      ],
    );
  }
}
