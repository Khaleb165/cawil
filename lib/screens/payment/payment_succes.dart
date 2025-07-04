import 'package:cawil/screens/payment/ticket_details.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {


  const PaymentSuccessPage({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0001),
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(127, 0, 255, 100)
                ],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(50, 50),
                  bottomLeft: Radius.elliptical(50, 50)),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Enter Payment Details',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
          ),
          const SizedBox(
            height: 180,
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: const Color.fromRGBO(0, 7, 240, 0.5),
            child: Image.asset(
              'assets/mark.png',
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
              child: const Text(
                'See Ticket Details',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 7, 240, 0.5)),
              ))
        ],
      )),
    );
  }
}
