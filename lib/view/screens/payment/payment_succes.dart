import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/screens/payment/ticket_details.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0001),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    deepBlueColor,
                    deepBlueColor,
                    purpleColor,
                  ],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.elliptical(50, 50),
                    bottomLeft: Radius.elliptical(50, 50)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter Payment Details',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 25,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(180)),
            CircleAvatar(
              radius: 70,
              backgroundColor: deepBlueColor,
              child: Image.asset(
                'assets/images/check.png',
                scale: 6,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('Payment Process is'),
            const Text('done successfully'),
            const SizedBox(
              height: 25,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TicketDetailsPage()));
                },
                child: Text(
                  'See Ticket Details',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                      color: deepBlueColor),
                ))
          ],
        ),
      ),
    );
  }
}
