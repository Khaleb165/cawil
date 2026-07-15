import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/screens/payment/payment_details.dart';
import 'package:cawil/view/widgets/custom_appbar.dart';
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
          const CustomAppBar(title: 'Payment Method'),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, top: 100),
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                const Text(
                  'Select Payment Channel:',
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
                        title: Text('Card'),
                        value: 'Card',
                      ),
                      RadioListTile<String>(
                        title: Text('Mobile Money'),
                        value: 'Mobile Money',
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
