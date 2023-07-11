import 'package:cawil/screens/payment/payment_details.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  final String name;
  final String contactNumber;
  final double totalPrice;
  final List<String> selectedSeats;

  const PaymentMethodPage(
      {super.key,
      required this.name,
      required this.contactNumber,
      required this.totalPrice,
      required this.selectedSeats});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
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
                'Select Payment method',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Card:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
                RadioListTile<String>(
                  title: Text('Mastercard'),
                  value: 'Mastercard',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Mobile Wallet'),
                  value: 'Mobile Wallet',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text('Cash on Delivery'),
                  value: 'Cash on Delivery',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: selectedPaymentMethod != null
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentDetailsPage(
                                    name: widget.name,
                                    contactNumber: widget.contactNumber,
                                    paymentMethod: selectedPaymentMethod!,
                                    totalPrice: widget.totalPrice,
                                    selectedSeats: widget.selectedSeats)));
                      }
                    : null,
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Colors.greenAccent[100],
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 0),
                child: Text(
                  'Proceed',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
