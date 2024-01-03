// ignore_for_file: unused_import

import 'package:cawil/constants/colors.dart';
import 'package:cawil/models/app_name.dart';
import 'package:cawil/screens/components/TicketCard.dart';
import 'package:cawil/screens/seat_select.dart';
import 'package:cawil/screens/settings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';

import '../models/bus_card.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            // margin: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * 0.0001),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [shade1, shade1, shade2],
                tileMode: TileMode.clamp,
              ),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(50, 50)),
            ),
            child: AppName(fontSize: 50),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              Image.asset(
                'assets/bus-logo.png',
                scale: 4,
              ),
              SizedBox(height: 10),
              Text(
                'Buses Available',
                style: TextStyle(
                    fontSize: 35, color: primary2, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => BusCard(),
            ),
          ),
        ],
      ),
    );
  }
}
