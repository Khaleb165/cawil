import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/show_snackbar.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/data/resources/auth_methods.dart';
import 'package:cawil/view/widgets/app_name.dart';
import 'package:cawil/view/widgets/custom_button.dart';
import 'package:cawil/view/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _tokenTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  bool _isRequesting = false;
  bool _isResetting = false;
  bool _tokenRequested = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _tokenTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  Future<void> _requestResetToken() async {
    setState(() => _isRequesting = true);
    try {
      final result = await AuthMethods().requestPasswordReset(
        email: _emailTextController.text,
      );
      if (!mounted) return;

      final resetToken = result.resetToken;
      if (resetToken != null && resetToken.isNotEmpty) {
        _tokenTextController.text = resetToken;
      }
      setState(() => _tokenRequested = true);
      showSnackBar(result.message, context);
    } catch (error) {
      if (mounted) {
        showSnackBar(error.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isRequesting = false);
      }
    }
  }

  Future<void> _resetPassword() async {
    final password = _passwordTextController.text;
    final confirmPassword = _confirmPasswordTextController.text;

    if (password != confirmPassword) {
      showSnackBar('Passwords do not match', context);
      return;
    }

    setState(() => _isResetting = true);
    try {
      await AuthMethods().resetPassword(
        token: _tokenTextController.text,
        password: password,
      );
      if (!mounted) return;

      showSnackBar('Password reset successfully. Please log in.', context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (error) {
      if (mounted) {
        showSnackBar(error.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isResetting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
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
                    crossAxisAlignment: crossStretch,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(70)),
                      Text(
                        'Reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: getProportionateScreenHeight(24),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),
                      Text(
                        'Enter your email and we will send you a reset token.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(35)),
                      CustomTextfield(
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        inputAction: TextInputAction.done,
                        hintText: 'Email Address',
                        onSubmitted: _requestResetToken,
                      ),
                      SizedBox(height: getProportionateScreenHeight(18)),
                      CustomButton(
                        onPressed: _isRequesting ? null : _requestResetToken,
                        text: 'SEND RESET EMAIL',
                        isLoading: _isRequesting,
                      ),
                      if (_tokenRequested) ...[
                        SizedBox(height: getProportionateScreenHeight(28)),
                        Text(
                          'Check your email for the reset token, then enter it below.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: getProportionateScreenHeight(13),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(18)),
                        CustomTextfield(
                          controller: _tokenTextController,
                          inputAction: TextInputAction.next,
                          hintText: 'Reset Token',
                          maxLength: 120,
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        CustomTextfield(
                          controller: _passwordTextController,
                          inputAction: TextInputAction.next,
                          hintText: 'New Password',
                          obscureText: true,
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        CustomTextfield(
                          controller: _confirmPasswordTextController,
                          inputAction: TextInputAction.done,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          onSubmitted: _resetPassword,
                        ),
                        SizedBox(height: getProportionateScreenHeight(22)),
                        CustomButton(
                          onPressed: _isResetting ? null : _resetPassword,
                          text: 'RESET PASSWORD',
                          isLoading: _isResetting,
                        ),
                      ],
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
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
