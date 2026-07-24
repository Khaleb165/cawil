import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? height;
  final double? width;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text = 'LOGIN',
    this.isLoading = false,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? getProportionateScreenHeight(50),
        width: width ?? getProportionateScreenWidth(320),
        child: ElevatedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: disabledBackgroundColor,
            backgroundColor: backgroundColor ?? greenAccentColor,
            padding: EdgeInsets.symmetric(
              // horizontal: getProportionateScreenWidth(120),
              vertical: getProportionateScreenHeight(15),
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(20))),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: whiteColor))
              : Text(
                  text,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: getProportionateScreenHeight(16),
                  ),
                ),
        ),
      ),
    );
  }
}
