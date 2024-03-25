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

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
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
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Homepage()));
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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
              SizedBox(height: 50),
              Text(
                'SignUp to Book',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
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
                          color: colorWhite,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomTextfield(
                controller: _usernameTextController,
                keyboard: TextInputType.name,
                hintText: 'Username',
              ),
              SizedBox(height: 10),
              CustomTextfield(
                controller: _emailTextController,
                keyboard: TextInputType.emailAddress,
                hintText: 'Email Address',
              ),
              SizedBox(height: 10),
              CustomTextfield(
                controller: _passwordTextController,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
              ),
              SizedBox(height: 20),
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
                          color: colorWhite,
                        ),
                      )
                    : Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: colorWhite,
                        ),
                      ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'or login with',
                  style: TextStyle(
                    fontSize: 15,
                    color: colorWhite,
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
                  SocialLoginButton(imageUrl: 'assets/images.png')
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 15,
                      color: colorWhite,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
