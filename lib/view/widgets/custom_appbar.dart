import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(20)),
      width: double.infinity,
      height: getProportionateScreenHeight(170),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepBlueColor, deepBlueColor, purpleColor],
          tileMode: TileMode.clamp,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.elliptical(50, 50),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: whiteColor,
            fontSize: getProportionateScreenHeight(25),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
