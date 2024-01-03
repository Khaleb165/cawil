import 'package:cawil/constants/colors.dart';
import 'package:cawil/models/bus_data.dart';
import 'package:cawil/models/textfield.dart';
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
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [shade1, shade1, shade2],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Passenger Details',
                  style: TextStyle(
                      color: Colors.white, fontSize: 35, letterSpacing: 1),
                ),
              ),
            ),
            SizedBox(height: 90),
            BuildTextField(
              controller: nameController,
              keyboard: TextInputType.text,
              inputAction: TextInputAction.next,
              hintText: 'Name of traveller',
              obscureText: false,
              onChanged: (newText){
                Provider.of<BusData>(context,listen: false).updateNameTextField(newText);
              },
            ),
            SizedBox(height: 15),
            BuildTextField(
              controller: contactNumberController,
              keyboard: TextInputType.phone,
              inputAction: TextInputAction.next,
              hintText: 'Phone Number',
              obscureText: false,
              onChanged: (newNumber){
                Provider.of<BusData>(context,listen: false).updatePhoneTextField(newNumber);
              },
            ),
            SizedBox(height: 15),
            BuildTextField(
              controller: TextEditingController(),
              keyboard: TextInputType.text,
              inputAction: TextInputAction.next,
              hintText: 'Gender',
              obscureText: false,
            ),
            SizedBox(height: 15),
            BuildTextField(
              controller: TextEditingController(),
              keyboard: TextInputType.text,
              inputAction: TextInputAction.next,
              hintText: 'Guardian Name',
              obscureText: false,
            ),
            SizedBox(height: 15),
            BuildTextField(
              controller: TextEditingController(),
              keyboard: TextInputType.phone,
              inputAction: TextInputAction.done,
              hintText: 'Guardian Phone Number',
              obscureText: false,
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentMethodPage(

                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
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
