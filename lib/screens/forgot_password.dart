import 'package:flutter/material.dart';

import 'login.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
    // mainAxisAlignment: MainAxisAlignment.center,
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
    SizedBox(height: 150,),
    Padding(
    padding: const EdgeInsets.only(left: 30,right: 30),
    child: Text('Enter your e-mail and we will send you a reset link',
    style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold
    ),
    ),
    ),
    SizedBox(height: 40,),

    Padding(
    padding: const EdgeInsets.only(left: 30.0,right: 30),
    child: TextField(
    style: TextStyle(color: Colors.black38),
    controller: _emailTextController,
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.done,
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
    SizedBox(height: 25,),
        Center(
          child:  ElevatedButton(
            onPressed: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.greenAccent[100],
              padding: EdgeInsets.symmetric(horizontal: 130,vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: Text('RESET',
              style: TextStyle(
                color: Colors.white,

              ),),
          ),
        ),
        SizedBox(height:20,),

        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(onPressed: (){
              Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
                child: Text('Back',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.greenAccent[100]
                ),),
            ),
          ),
        ),
      SizedBox(height: 300,)

    ]),
    )
        ),
      )
    );
  }
}
