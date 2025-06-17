import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String imageUrl;
  const SocialLoginButton({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12), // Border radius
        child: Image.asset(imageUrl),
      ),
    );
  }
}
