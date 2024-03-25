import 'package:cawil/constants/colors.dart';
import 'package:cawil/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../widgets/app_name.dart';

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            AppName(fontSize: 50),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/caWil.png",
                    ),
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 18),
              child: Text(
                'Quick and easy way to reserve a seat.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: primary2,
                ),
              ),
            ),
            SizedBox(height: 70),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary2,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(70, 70),
                  ),
                ),
                child: SwipeableButtonView(
                  buttonText: 'Swipe to book',
                  buttonWidget: Icon(Icons.double_arrow_sharp, color: primary1),
                  activeColor: primary1,
                  isFinished: isFinished,
                  onWaitingProcess: () {
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {
                        isFinished = true;
                      });
                    });
                  },
                  onFinish: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: LoginScreen(),
                      ),
                    );

                    setState(() {
                      isFinished = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
