import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/bus_data.dart';
import '../../widgets/ticket_details_card.dart';

class TicketDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final busData = Provider.of<BusData>(context).selectedSeats;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [deepBlueColor, deepBlueColor, purpleColor],
                tileMode: TileMode.clamp,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.elliptical(50, 50),
                bottomLeft: Radius.elliptical(50, 50),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Ticket Details',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TicketDetailsCard(busData: busData),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SizedBox(
                      height: 55,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<BusData>(context, listen: false)
                              .clearFieldsData();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: greenAccentColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text(
                          'Go to Home',
                          style: TextStyle(
                              color: whiteColor,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
