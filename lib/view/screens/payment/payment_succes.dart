import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/screens/payment/ticket_details.dart';
import 'package:cawil/view/widgets/custom_appbar.dart';
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
            const CustomAppBar(title: 'Payment Success'),
            SizedBox(height: getProportionateScreenHeight(180)),
            CircleAvatar(
              radius: 70,
              backgroundColor: deepBlueColor,
              child: Image.asset(
                'assets/images/check.png',
                scale: 6,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(22)),
            const Text('Payment Process is \nDone Successfully'),
            SizedBox(height: getProportionateScreenHeight(25)),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TicketDetailsPage()));
              },
              child: Text(
                'See Ticket Details',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  color: deepBlueColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
