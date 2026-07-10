import 'package:cawil/core/constants/size_config.dart';
import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

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

class SocialsLogin extends StatelessWidget {
  const SocialsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
      child: Row(
        mainAxisAlignment: mainSpaceEvenly,
        children: [
          _buildSocialIcon('assets/images/google.png'),
          _buildSocialIcon('assets/images/facebook.png'),
          _buildSocialIcon('assets/images/twitter.png'),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return CircleAvatar(
      radius: getProportionateScreenWidth(20),
      backgroundColor: whiteColor,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenHeight(10)),
        child: Image.asset(assetPath),
      ),
    );
  }
}
