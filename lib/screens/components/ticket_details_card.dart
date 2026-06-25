import 'package:cawil/constants/colors.dart';
import 'package:cawil/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bus_data.dart';

class TicketDetailsCard extends StatelessWidget {
  const TicketDetailsCard({
    super.key,
    required this.busData,
  });

  final List<String> busData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: List.generate(busData.length, (index) {
        final seatNumber = busData[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: crossStart,
                  children: [
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Text(
                          'Name of Passenger',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: lightBlackColor,
                          ),
                        ),
                        Text(
                          Provider.of<BusData>(context).nameOfTraveller,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: lightBlackColor),
                        ),
                        Text(
                          Provider.of<BusData>(context).phoneNumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Column(
                      crossAxisAlignment: crossStart,
                      children: [
                        Text(
                          'Total Price ',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: lightBlackColor),
                        ),
                        const Text(
                          'Ghc 80',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(12)),
                    Row(
                      children: [
                        Text(
                          'Seat No:',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: lightBlackColor),
                        ),
                        SizedBox(width: getProportionateScreenWidth(8)),
                        Text(seatNumber)
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(
                  'assets/qrcode.png',
                  scale: 1.8,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
