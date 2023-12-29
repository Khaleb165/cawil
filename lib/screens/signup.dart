import 'package:cawil/constants/colors.dart';
import 'package:cawil/models/app_name.dart';
import 'package:cawil/models/textfield.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../utilities/utils.dart';

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
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomepageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [shade1, shade1, shade2],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              AppName(fontSize: 70),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(right: 38.0),
                child: Text(
                  'SignUp to Book',
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Stack(
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
              SizedBox(height: 10),
              BuildTextField(
                controller: _usernameTextController,
                keyboard: TextInputType.name,
                inputAction: TextInputAction.next,
                hintText: 'Username',
                obscureText: false,
              ),
              SizedBox(height: 10),
              BuildTextField(
                controller: _emailTextController,
                keyboard: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                hintText: 'Email Address',
                obscureText: false,
              ),
              SizedBox(height: 10),

              BuildTextField(
                controller: _passwordTextController,
                keyboard: TextInputType.text,
                inputAction: TextInputAction.done,
                hintText: 'Password',
                obscureText: hide,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: signUpUser,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.greenAccent[100],
                    padding:
                        EdgeInsets.symmetric(horizontal: 150, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
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
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'or login with',
                  style: TextStyle(fontSize: 15, color: colorWhite),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(12), // Border radius
                      child: Image.asset('assets/google.png'),
                    ),
                  ),
                  SizedBox(width: 25),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(12), // Border radius
                      child: Image.asset('assets/facebook1.png'),
                    ),
                  ),
                  SizedBox(width: 25),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: colorWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(12), // Border radius
                      child: Image.asset('assets/images.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 15, color: colorWhite),
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
                      style: TextStyle(color: Colors.red[900], fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }

// method for the textfields
  Padding buildTextField(
    TextEditingController controller,
    TextInputType keyboard,
    TextInputAction inputAction,
    String hintText,
    bool obscureText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35),
      child: TextField(
        style: TextStyle(color: Colors.black38),
        controller: controller,
        keyboardType: keyboard,
        textInputAction: inputAction,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorWhite, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black38),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: colorWhite,
          contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 1, style: BorderStyle.solid, color: Colors.black38),
          ),
        ),
      ),
    );
  }
}
