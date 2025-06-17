import 'package:cawil/constants/colors.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/components/social_login_button.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Homepage()));
    } else {
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 50),
              const AppName(fontSize: 70),
              const SizedBox(height: 50),
              Text(
                'SignUp to Book',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                AssetImage('assets/defaultProfile.jpeg'),
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
              const SizedBox(height: 10),
              CustomTextfield(
                controller: _usernameTextController,
                keyboard: TextInputType.name,
                hintText: 'Username',
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: _emailTextController,
                keyboard: TextInputType.emailAddress,
                hintText: 'Email Address',
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                controller: _passwordTextController,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUpUser,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.greenAccent[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: whiteColor,
                        ),
                      )
                    : Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'or login with',
                  style: TextStyle(
                    fontSize: 15,
                    color: whiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(imageUrl: 'assets/google.png'),
                  SizedBox(width: 25),
                  SocialLoginButton(imageUrl: 'assets/facebook1.png'),
                  SizedBox(width: 25),
                  SocialLoginButton(imageUrl: 'assets/images.png')
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 15,
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
                        color: Colors.red[900],
                        fontSize: 15,
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
