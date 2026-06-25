import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/show_snackbar.dart';
import 'package:cawil/constants/size_config.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/auth_screens/forgot_password.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/auth_screens/signup.dart';
import 'package:flutter/material.dart';

import '../components/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hide = true;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    if (res == 'success') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    } else {
      showSnackBar(res, context);
    }
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(25),
            vertical: getProportionateScreenHeight(50)),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepBlueColor, deepBlueColor, purpleColor],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossStretch,
            children: [
              AppName(fontSize: getProportionateScreenHeight(50)),
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                'Login to Book',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              CustomTextfield(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email Address',
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              CustomTextfield(
                controller: _passwordTextController,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
                onSubmitted: loginUser,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ElevatedButton(
                onPressed: loginUser,
                style: TextButton.styleFrom(
                  backgroundColor: lightGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: whiteColor))
                    : Text(
                        'LOGIN',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: deepRedColor,
                      fontSize: getProportionateScreenHeight(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                'or login with',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                  color: whiteColor,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              const SocialsLogin(),
              SizedBox(height: getProportionateScreenHeight(40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: getProportionateScreenHeight(14),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(
                        color: deepRedColor,
                        fontSize: getProportionateScreenHeight(14),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
