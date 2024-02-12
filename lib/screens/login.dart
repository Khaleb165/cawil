import 'package:cawil/constants/colors.dart';
import 'package:cawil/models/app_name.dart';
import 'package:cawil/models/textfield.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/forgot_password.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/signup.dart';
import 'package:cawil/utilities/utils.dart';
import 'package:flutter/material.dart';

import 'components/social_login_button.dart';

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

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailTextController.text,
      password: _passwordTextController.text,
    );

    if (res == 'success') {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomepageScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [shade1, shade1, shade2],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              AppName(fontSize: 70),
              SizedBox(height: 70),
              Text(
                'Login to Book',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              BuildTextField(
                controller: _emailTextController,
                keyboard: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                hintText: 'Email Address',
                obscureText: false,
              ),
              SizedBox(height: 20),
              BuildTextField(
                controller: _passwordTextController,
                keyboard: TextInputType.text,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.greenAccent[100],
                  // padding: EdgeInsets.symmetric(horizontal: 150, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.red[900]),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Text(
                  'or login with',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(imageUrl: 'assets/google.png'),
                  SizedBox(width: 25),
                  SocialLoginButton(imageUrl: 'assets/facebook1.png'),
                  SizedBox(width: 25),
                  SocialLoginButton(imageUrl: 'assets/images.png'),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: colorWhite),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(color: Colors.red[900]),
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
