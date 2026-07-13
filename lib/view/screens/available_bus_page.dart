import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/model/available_bus.dart';
import 'package:cawil/view/widgets/app_name.dart';
import 'package:flutter/material.dart';

import '../widgets/bus_card.dart';

class AvailableBusPage extends StatelessWidget {
  final List<AvailableBusModel> buses;

  const AvailableBusPage({
    Key? key,
    required this.buses,
  }) : super(key: key);

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
                'assets/images/bus-logo.png',
                scale: getProportionateScreenHeight(5),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                'Buses Available',
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(28),
                  color: darkBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: buses.isEmpty
                ? Center(
                    child: Text(
                      'No buses available',
                      style: TextStyle(
                        color: darkBlueColor,
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: buses.length,
                    itemBuilder: (_, index) {
                      final bus = buses[index];
                      return BusCard(bus: bus);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
