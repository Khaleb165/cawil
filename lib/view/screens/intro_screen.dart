import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/screens/auth_screens/login.dart';
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
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            AppName(fontSize: getProportionateScreenHeight(50)),
            SizedBox(height: getProportionateScreenHeight(50)),
            Center(
              child: Container(
                height: getProportionateScreenHeight(300),
                width: getProportionateScreenWidth(300),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/intro-screen-logo.png",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(40)),
              child: Text(
                'Quick and easy way to reserve a seat.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(20),
                  color: darkBlueColor,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenWidth(30)),
              width: double.infinity,
              decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.elliptical(40, 40),
                ),
              ),
              child: SwipeableButtonView(
                buttonText: 'Swipe to book',
                buttontextstyle: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
                buttonWidget:
                    Icon(Icons.double_arrow_sharp, color: greenAccentColor),
                activeColor: greenAccentColor,
                isFinished: isFinished,
                onWaitingProcess: () {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      setState(() {
                        isFinished = true;
                      });
                    }
                  });
                },
                onFinish: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const LoginScreen(),
                    ),
                  );

                  if (mounted) {
                    setState(() {
                      isFinished = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
