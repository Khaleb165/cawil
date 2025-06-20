import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:cawil/services/auth_methods.dart';
import 'package:cawil/screens/components/social_login_button.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/telemetry_service.dart';
import '../../utilities/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hide = true;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    _usernameTextController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      username: _usernameTextController.text,
      email: _emailTextController.text,
      password: _passwordTextController.text,
      file: _image ?? Uint8List(0),
    );

    if (res == 'success') {
      TelemetryService().logInfo("User logged in");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homepage()));
    } else {
      showSnackBar(res, context);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppName(fontSize: getProportionateScreenHeight(50)),
              SizedBox(height: getProportionateScreenHeight(40)),
              Text(
                'SignUp to Book',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: getProportionateScreenHeight(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: getProportionateScreenHeight(40),
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: getProportionateScreenHeight(40),
                            backgroundImage:
                                const AssetImage('assets/defaultProfile.jpeg'),
                          ),
                    Positioned(
                      bottom: -10,
                      left: 40,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(
                          Icons.add_a_photo,
                          color: whiteColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              CustomTextfield(
                controller: _usernameTextController,
                keyboardType: TextInputType.name,
                hintText: 'Username',
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              CustomTextfield(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email Address',
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              CustomTextfield(
                controller: _passwordTextController,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              ElevatedButton(
                onPressed: signUpUser,
                style: TextButton.styleFrom(
                  backgroundColor: lightGreenColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: whiteColor),
                      )
                    : Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: getProportionateScreenHeight(16),
                        ),
                      ),
              ),
              SizedBox(height: getProportionateScreenHeight(40)),
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
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      color: whiteColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: deepRedColor,
                        fontSize: getProportionateScreenHeight(14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
