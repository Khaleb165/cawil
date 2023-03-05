// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cawil/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';



class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // Padding(padding: EdgeInsets.only(top:20 )),
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ca',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold
                  ),),
                  Text('Wil',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(19, 41, 75, 1),
                    ),),

                ],
              ),
            ),
      SizedBox(height: 40,),
      Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/caWil.png",),
              //fit: BoxFit.cover,
            ),
          ),),
      ),

            Padding(
              padding: const EdgeInsets.only(left: 50,right: 18),
              child: Text('Quick and easy way to reserve a seat.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromRGBO(19, 41, 75, 1),
              ),),
            ),

      Container(
        padding: EdgeInsets.symmetric(horizontal: 35,vertical: 20),
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12),
        width: double.infinity,
        height: 125,
        decoration: BoxDecoration(
          color: Color.fromRGBO(19, 41, 75, 1),
          borderRadius: BorderRadius.only(topRight: Radius.elliptical(70, 70), ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0,horizontal: 50),
          child: SwipeableButtonView(
            buttonText: 'Swipe to book',
            buttonWidget: Container(
              child: Icon(Icons.double_arrow_sharp,
              color: Colors.greenAccent),
            ),

            activeColor: Colors.greenAccent,
            isFinished: isFinished,
            onWaitingProcess: (){
              Future.delayed(Duration(seconds: 1), (){
                setState(() {
                  isFinished = true;
                });
              });
            },
            onFinish: () async{
              await Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                child: LoginScreen(),
              ));

              setState(() {
              isFinished = false;
              });
            },
          ),
        )

      )
          ],
        ),
      ),
    );
  }
}
