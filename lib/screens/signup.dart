import 'package:cawil/resources/auth_methods.dart';
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

  void selectImage() async{
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser()async{
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

    if (res != 'success'){
      showSnackBar(res, context);
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [const Color.fromRGBO(0, 7, 240,0.5),Color.fromRGBO(0, 7, 240,0.5), Color.fromRGBO(127,0,255,100)],
    tileMode: TileMode.clamp,
    ),

    ),
    child: Padding(
    padding: const EdgeInsets.only(top: 90.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text('Ca',
        style: TextStyle(
        fontSize: 70,
        color: Colors.greenAccent,
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
        child: Text('SignUp to Book',
        style: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold
        ),
        ),
        ),
    SizedBox(height: 10,),
      Stack(
        children: [
          _image != null
              ? CircleAvatar(
            radius: 40,
            backgroundImage: MemoryImage(_image!),
          )
              : CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/defaultProfile.jpeg'),
          ),
          Positioned(
              bottom: -10,
              left: 40,
              child: IconButton(
                onPressed: selectImage,
                icon: Icon(Icons.add_a_photo,color: Colors.white,size: 22,),
              )
          )
        ],
      ),
      SizedBox(height: 10,),
        Padding(
        padding: const EdgeInsets.only(left: 35.0,right: 35),
        child: TextField(
          style: TextStyle(color: Colors.black38),
          controller: _usernameTextController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide: const BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.circular(30),
              ),

              hintText: 'Username',
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
     onPressed: signUpUser,
        style: TextButton.styleFrom(
        backgroundColor: Colors.greenAccent[100],
        padding: EdgeInsets.symmetric(horizontal: 150,vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    ),
        child: _isLoading? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ) : Text('SIGN UP',
           style: TextStyle(
               color: Colors.white,

          ),),
          ),
          ),

        SizedBox(height: 40,),

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

        SizedBox(height: 20,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.white
            ),),
            TextButton(onPressed: (){
              Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
                child: Text('Log in',
                style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 15
                ),
                )
            )
          ],
        ),

      SizedBox(height: 50,)
            ]
          ),
          ),
            ),
      )
    );
  }
}
