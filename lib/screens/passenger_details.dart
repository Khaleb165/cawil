import 'package:cawil/constants/colors.dart';
import 'package:cawil/providers/bus_data.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:cawil/screens/payment/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/size_config.dart';

class PassengerDetailsPage extends StatefulWidget {
  const PassengerDetailsPage({Key? key}) : super(key: key);

  @override
  State<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30),
                  vertical: getProportionateScreenHeight(20)),
              width: double.infinity,
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [deepBlueColor, deepBlueColor, purpleColor],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Passenger Details',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(90)),
            CustomTextfield(
              controller: nameController,
              hintText: 'Name of traveller',
              onChanged: (newText) {
                Provider.of<BusData>(context, listen: false)
                    .updateNameTextField(newText);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            CustomTextfield(
              controller: contactNumberController,
              keyboardType: TextInputType.phone,
              hintText: 'Phone Number',
              onChanged: (newNumber) {
                Provider.of<BusData>(context, listen: false)
                    .updatePhoneTextField(newNumber);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            DropdownButtonFormField<String>(
              initialValue: selectedGender,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: lightBlackColor),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteColor, width: 0.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Gender',
                hintStyle: TextStyle(color: lightBlackColor),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: whiteColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(10)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: lightBlackColor,
                  ),
                ),
              ),
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            CustomTextfield(
              controller: TextEditingController(),
              hintText: 'Guardian Name',
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            CustomTextfield(
              controller: TextEditingController(),
              keyboardType: TextInputType.phone,
              inputAction: TextInputAction.done,
              hintText: 'Guardian Phone Number',
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty ||
                      contactNumberController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Name of traveller and Phone Number are required.')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenAccentColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
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
