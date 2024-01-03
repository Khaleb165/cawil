import 'package:cawil/screens/payment/payment_succes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/bus_data.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0001),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(127, 0, 255, 100)
                ],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(50, 50),
                  bottomLeft: Radius.elliptical(50, 50)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Enter Payment Details',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SizedBox(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Payment Method',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('$paymentMethod'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      SizedBox(height: 16.0),
                      Text(
                        'Mobile Number: ${Provider.of<BusData>(context).phoneNumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black45),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('${Provider.of<BusData>(context).phoneNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ticket Price',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black45),
                              ),
                              SizedBox(
                                height: 5
                              ),
                              Text(
                                  'Ghc ${Provider.of<BusData>(context).totalPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18))
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'E-levy Charges',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black45),
                              ),
                              SizedBox(
                                height: 5
                              ),
                              Text('Ghc ${charges.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 55,
            width: 350,
            child: ElevatedButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSuccessPage(

                            )));
              }),
              style: TextButton.styleFrom(
                  disabledBackgroundColor: Colors.greenAccent[100],
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 0),
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      )),
    );
  }
}
