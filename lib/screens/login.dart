// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cawil/constants/colors.dart';
import 'package:cawil/resources/auth_methods.dart';
import 'package:cawil/screens/forgot_password.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:cawil/screens/signup.dart';
import 'package:cawil/utilities/utils.dart';
import 'package:flutter/material.dart';

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

  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
    email: _emailTextController.text,
    password: _passwordTextController.text,
    );

    if(res == 'success'){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomepageScreen()));

    } else{
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [shade1,shade1, shade2],
              tileMode: TileMode.clamp,
            ),

          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ca',
                  style: TextStyle(
                      fontSize: 70,
                      color: primaryColor,
                      fontWeight: FontWeight.bold
                  ),),
                Text('Wil',
                  style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(19, 41, 75, 1),
                  ),),
                ]
              ),
                SizedBox(height: 90,),
                Padding(
                  padding: const EdgeInsets.only(right: 38.0),
                  child: Text('Login to Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                SizedBox(height: 50,),

                Padding(
                  padding: const EdgeInsets.only(left: 35.0,right: 35),
                  child: TextField(
                    style: TextStyle(color: Colors.black38),
                    controller: _emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: Colors.black38),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width:1,style: BorderStyle.solid,color: Colors.black38)
                        )

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0,right: 35),
                  child: TextField(
                    style: TextStyle(color: Colors.black38),
                    controller: _passwordTextController,
                    obscureText: hide,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30),
                        ),

                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black38),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(width:1,style: BorderStyle.none,color: Colors.grey)
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child:  ElevatedButton(
                    onPressed: loginUser,
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.greenAccent[100],
                          padding: EdgeInsets.symmetric(horizontal: 150,vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                    child:  _isLoading? Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    ) : Text('LOGIN',
                    style: TextStyle(
                      color: Colors.white,

                    ),),
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.red[900]
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60,),

                Center(
                  child: Text(
                    'or login with',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12), // Border radius
                        child: Image.asset('assets/google.png'),
                      ),
                    ),
                    SizedBox(width: 25,),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12), // Border radius
                        child: Image.asset('assets/facebook1.png'),
                      ),
                    ),
                    SizedBox(width: 25,),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12), // Border radius
                        child: Image.asset('assets/images.png'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                    style: TextStyle(
                      color: Colors.white
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text('Register now',
                        style: TextStyle(
                          color: Colors.red[900]
                        ),),
                    )
                  ],
                ),
                SizedBox(height: 90,),
              ],

            ),
          ),

        ),
      ),
    );
  }
}
