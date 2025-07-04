import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../constants/size_config.dart';
import '../seat_select.dart';

class TicketCard extends StatelessWidget {
  final String? busnumber;
  final String? start_location;
  final String? Destination;
  final String? report_time;
  final String? departure_time;
  final String? seats_left;
  final String? price;

  const TicketCard(
      {Key? key,
      this.busnumber,
      this.start_location,
      this.Destination,
      this.report_time,
      this.departure_time,
      this.seats_left,
      this.price})
      : super(key: key);

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
            color: Colors.white,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Text(
                          busnumber.toString(),
                          style: const TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Color.fromRGBO(19, 41, 75, 1),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          children: [
                            Icon(
                              Icons.near_me_outlined,
                              size: 35,
                              color: Colors.greenAccent[100],
                            ),
                            const SizedBox(width: 5),
                            Text(
                              start_location.toString(),
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
                        const SizedBox(height: 20),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place_outlined,
                              size: 35,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Kumasi',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '15-01-2023',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 30),
                    const DottedLine(
                      direction: Axis.vertical,
                      dashColor: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          'Report Time: 9am',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color.fromRGBO(19, 41, 75, 1),
                          ),
                        ),
                        const Text(
                          'Departure: 10am',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color.fromRGBO(19, 41, 75, 1),
                          ),
                        ),
                        const Text(
                          'Arrival: 2pm',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color.fromRGBO(19, 41, 75, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Seats Left: 18',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.deepPurple[400],
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Price: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color.fromRGBO(19, 41, 75, 1),
                              ),
                            ),
                            Text(
                              'Ghc 80',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.red[900],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
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
                              backgroundColor: Colors.greenAccent[100],
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
