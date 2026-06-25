import 'package:cawil/constants/size_config.dart';
import 'package:cawil/models/available_bus.dart';
import 'package:cawil/providers/bus_data.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../screens/seat_select.dart';

class BusCard extends StatelessWidget {
  final AvailableBusModel bus;
  const BusCard({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    // AvailableBusModel bus1 =
    //     AvailableBusModel('First Bus', '9am', '10am', '2pm', 36);

    return ClipPath(
      clipper: SideCutClipper(),
      child: Container(
        height: getProportionateScreenHeight(250),
        child: Card(
          elevation: 10,
          borderOnForeground: false,
          color: whiteColor,
          margin: EdgeInsets.all(getProportionateScreenWidth(10)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(10),
                top: getProportionateScreenHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      bus.busNumber!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenHeight(25),
                        color: darkBlueColor,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      //crossAxisAlignment: crossStart,
                      children: [
                        Icon(
                          Icons.near_me_outlined,
                          size: getProportionateScreenHeight(25),
                          color: greenAccentColor,
                        ),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: getProportionateScreenWidth(100),
                            child: Text(
                              Provider.of<BusData>(context).fromTextField,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(18),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenHeight(35)),
                      child: Text(
                        DateFormat('dd/MM/yyyy')
                            .format(Provider.of<BusData>(context).selectedDate),
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(12),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      crossAxisAlignment: crossStart,
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: getProportionateScreenHeight(25),
                        ),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: getProportionateScreenHeight(30),
                                width: getProportionateScreenWidth(100),
                                child: Text(
                                  Provider.of<BusData>(context).toTextField,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenHeight(35)),
                              child: Text(
                                DateFormat('dd/MM/yyyy').format(
                                    Provider.of<BusData>(context).selectedDate),
                                style: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: getProportionateScreenWidth(30)),
                DottedLine(
                  direction: Axis.vertical,
                  dashColor: blackColor,
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Text(
                      'Report Time: ${bus.reportTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(12),
                        color: darkBlueColor,
                      ),
                    ),
                    Text(
                      'Departure: ${bus.departureTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(12),
                        color: darkBlueColor,
                      ),
                    ),
                    Text(
                      'Arrival: ${bus.arrivalTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(12),
                        color: darkBlueColor,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Text(
                      'Seats Left: ${bus.seatsLeft}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(12),
                        color: lightPurpleColorShade1,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getProportionateScreenHeight(12),
                              color: darkBlueColor,
                            ),
                          ),
                          TextSpan(
                            text: '¢${bus.price?.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: getProportionateScreenHeight(12),
                              color: deepRedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        await context.read<BusData>().clearData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SeatSelectPage()));
                      },
                      child: const Text('Buy ticket'),
                      style: TextButton.styleFrom(
                        backgroundColor: greenAccentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
