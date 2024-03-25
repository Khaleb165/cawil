import 'package:cawil/constants/colors.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [shade1, shade1, shade2],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              AppName(fontSize: 70),
              SizedBox(height: 150),
              Text(
                'Enter your e-mail and we will send you a reset link',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              CustomTextfield(
                controller: _emailTextController,
                keyboard: TextInputType.emailAddress,
                inputAction: TextInputAction.done,
                hintText: 'Email Address',
              ),
              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.greenAccent[100],
                    padding:
                        EdgeInsets.symmetric(horizontal: 130, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.greenAccent[100],
                    ),
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
