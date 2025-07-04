// ignore_for_file: unused_import

import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
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
    ScreenSize().init(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
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
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(getProportionateScreenWidth(50),
                      getProportionateScreenHeight(40))),
            ),
            child: AppName(fontSize: getProportionateScreenHeight(50)),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Column(
            children: [
              Image.asset(
                'assets/bus-logo.png',
                scale: getProportionateScreenHeight(5),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                'Buses Available',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(30),
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
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
