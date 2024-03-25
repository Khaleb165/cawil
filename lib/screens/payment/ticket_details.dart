import 'package:cawil/constants/colors.dart';
import 'package:cawil/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bus_data.dart';
import '../components/ticket_details_card.dart';

class TicketDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final busData = Provider.of<BusData>(context).selectedSeats;
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [shade1, shade1, shade2],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(50, 50),
                  bottomLeft: Radius.elliptical(50, 50)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Ticket Details',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TicketDetailsCard(busData: busData),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<BusData>(context, listen: false)
                      .clearFieldsData();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                      (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: Text(
                  'Go to Home',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
