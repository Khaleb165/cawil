import 'package:cawil/constants/colors.dart';
import 'package:cawil/screens/payment/payment_succes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bus_data.dart';

class PaymentDetailsPage extends StatelessWidget {
  final String paymentMethod;

  const PaymentDetailsPage({
    super.key,
    required this.paymentMethod,
  });

  double _calculateCharges(double totalPrice) {
    double charges = totalPrice * 0.01; // 1% charges

    if (totalPrice > 100) {
      charges += totalPrice * 0.015; // Additional 1.5% charges for e-levy
    }

    return charges;
  }

  @override
  Widget build(BuildContext context) {
    final charges = _calculateCharges(Provider.of<BusData>(context).totalPrice);
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [shade1, shade1, shade2],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter Payment Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        paymentMethod.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Provider.of<BusData>(context).phoneNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ticket Price',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Ghc ${Provider.of<BusData>(context).totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'E-levy Charges',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black45,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Ghc ${charges.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentSuccessPage()));
                }),
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Colors.greenAccent[100],
                    backgroundColor: Colors.greenAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
