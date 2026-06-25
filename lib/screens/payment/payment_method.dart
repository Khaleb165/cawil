import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
import 'package:cawil/screens/payment/payment_details.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({
    super.key,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedPaymentMethod;

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
                'Select Payment method',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 25,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, top: 100),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const Text(
                  'Select Card:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                RadioGroup<String>(
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                  child: const Column(
                    children: [
                      RadioListTile<String>(
                        title: Text('Mastercard'),
                        value: 'Mastercard',
                      ),
                      RadioListTile<String>(
                        title: Text('Mobile Wallet'),
                        value: 'Mobile Wallet',
                      ),
                      RadioListTile<String>(
                        title: Text('Cash on Delivery'),
                        value: 'Cash on Delivery',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(50)),
          Center(
            child: SizedBox(
              height: getProportionateScreenHeight(50),
              width: getProportionateScreenWidth(300),
              child: ElevatedButton(
                onPressed: selectedPaymentMethod != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentDetailsPage(
                              paymentMethod: selectedPaymentMethod!,
                            ),
                          ),
                        );
                      }
                    : null,
                style: TextButton.styleFrom(
                  disabledBackgroundColor: lightGreenColor,
                  backgroundColor: greenAccentColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                child: Text(
                  'Proceed',
                  style: TextStyle(
                    color: whiteColor,
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
