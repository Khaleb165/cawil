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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(busData.length, (index) {
        final seatNumber = busData[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name of Passenger',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black45),
                        ),
                        Text(
                          '${Provider.of<BusData>(context).nameOfTraveller}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black45),
                        ),
                        Text(
                          '${Provider.of<BusData>(context).phoneNumber}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price ',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black45),
                        ),
                        Text(
                          'Ghc 80',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Seat No:',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.black45),
                        ),
                        SizedBox(width: 8),
                        Text('$seatNumber')
                      ],
                    ),
                  ],
                ),
                Spacer(),
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
