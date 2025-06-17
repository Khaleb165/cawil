// ignore_for_file: unused_import

import 'package:cawil/constants/colors.dart';
import 'package:cawil/widgets/app_name.dart';
import 'package:cawil/screens/components/TicketCard.dart';
import 'package:cawil/screens/seat_select.dart';
import 'package:cawil/screens/settings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';

import '../widgets/bus_card.dart';

class AvailableBusPage extends StatelessWidget {
  const AvailableBusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Column(
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
                  bottom: Radius.elliptical(50, 50)),
            ),
            child: const AppName(fontSize: 50),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Image.asset(
                'assets/bus-logo.png',
                scale: 4,
              ),
              const SizedBox(height: 10),
              Text(
                'Buses Available',
                style: TextStyle(
                  fontSize: 35,
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => const BusCard(),
            ),
          ),
        ],
      ),
    );
  }
}
