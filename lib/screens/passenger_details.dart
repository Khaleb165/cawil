import 'package:cawil/constants/colors.dart';
import 'package:cawil/providers/bus_data.dart';
import 'package:cawil/widgets/custom_textfield.dart';
import 'package:cawil/screens/payment/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerDetailsPage extends StatefulWidget {
  const PassengerDetailsPage({Key? key}) : super(key: key);

  @override
  State<PassengerDetailsPage> createState() => _PassengerDetailsPageState();
}

class _PassengerDetailsPageState extends State<PassengerDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  colors: [deepBlueColor, deepBlueColor, purpleColor],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Passenger Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 90),
            CustomTextfield(
              controller: nameController,
              hintText: 'Name of traveller',
              onChanged: (newText) {
                Provider.of<BusData>(context, listen: false)
                    .updateNameTextField(newText);
              },
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              controller: contactNumberController,
              keyboard: TextInputType.phone,
              hintText: 'Phone Number',
              onChanged: (newNumber) {
                Provider.of<BusData>(context, listen: false)
                    .updatePhoneTextField(newNumber);
              },
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              controller: TextEditingController(),
              hintText: 'Gender',
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              controller: TextEditingController(),
              hintText: 'Guardian Name',
            ),
            const SizedBox(height: 15),
            CustomTextfield(
              controller: TextEditingController(),
              keyboard: TextInputType.phone,
              inputAction: TextInputAction.done,
              hintText: 'Guardian Phone Number',
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentMethodPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(
                    color: Colors.white,
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
