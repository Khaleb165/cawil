import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/widgets/app_name.dart';
import 'package:cawil/view/widgets/custom_button.dart';
import 'package:cawil/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    final bool _isLoading = false;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepBlueColor, deepBlueColor, purpleColor],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25),
            vertical: getProportionateScreenHeight(50),
          ),
          child: Column(
            crossAxisAlignment: crossCenter,
            children: [
              AppName(fontSize: getProportionateScreenHeight(50)),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: crossCenter,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(150)),
                      Text(
                        'Enter your e-mail for a reset link',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      CustomTextfield(
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        inputAction: TextInputAction.done,
                        hintText: 'Email Address',
                        onSubmitted: () {
                          // Handle the submission of the email address
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(25)),
                      CustomButton(
                        onPressed: () {
                          // Handle the reset password action
                        },
                        text: 'RESET',
                        isLoading: _isLoading,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(15),
                              color: lightGreenColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
