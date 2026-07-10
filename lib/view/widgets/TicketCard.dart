import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/model/ticket.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../core/constants/size_config.dart';
import '../screens/seat_select.dart';

class TicketCard extends StatelessWidget {
  final TicketModel? ticketModel;

  const TicketCard({
    Key? key,
    this.ticketModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SideCutClipper(),
      child: Container(
        height: 220,
        width: double.infinity,
        child: Expanded(
          child: Card(
            elevation: 15,
            borderOnForeground: false,
            color: whiteColor,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          ticketModel?.busnumber.toString() ?? '',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: darkBlueColor,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          children: [
                            Icon(
                              Icons.near_me_outlined,
                              size: 35,
                              color: lightGreenColor,
                            ),
                            SizedBox(width: getProportionateScreenWidth(5)),
                            Text(
                              ticketModel?.start_location.toString() ?? '',
                              style: const TextStyle(
                                letterSpacing: 2,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            '15-01-2023',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          crossAxisAlignment: crossStart,
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 35,
                            ),
                            SizedBox(width: getProportionateScreenWidth(5)),
                            Column(
                              children: [
                                Text(
                                  ticketModel?.Destination.toString() ?? '',
                                  style: const TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ticketModel?.report_time.toString() ?? '',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
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
                          'Report Time: 9am',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        Text(
                          'Departure: 10am',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        Text(
                          'Arrival: 2pm',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: darkBlueColor,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(15)),
                        Text(
                          'Seats Left: 18',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: lightPurpleColorShade1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Price: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: darkBlueColor,
                              ),
                            ),
                            Text(
                              'Ghc 80',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: deepRedColor,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateScreenWidth(10)),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SeatSelectPage()));
                            },
                            child: const Text('Buy ticket'),
                            style: TextButton.styleFrom(
                              backgroundColor: lightGreenColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
