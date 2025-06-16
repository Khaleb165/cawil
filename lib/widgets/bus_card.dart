import 'package:cawil/models/available_bus_model.dart';
import 'package:cawil/providers/bus_data.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../screens/seat_select.dart';

class BusCard extends StatelessWidget {
  const BusCard({super.key});

  @override
  Widget build(BuildContext context) {
    AvailableBusModel bus1 =
        AvailableBusModel('First Bus', '9am', '10am', '2pm', 36);

    return ClipPath(
      clipper: SideCutClipper(),
      child: Container(
        height: 250,
        child: Card(
          elevation: 15,
          borderOnForeground: false,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      bus1.busNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: primary2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Image.asset('assets/send1.png',scale: 6,),
                        Icon(
                          Icons.near_me_outlined,
                          size: 35,
                          color: Colors.greenAccent[100],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            // height: 30,
                            width: 100,
                            child: Text(
                              Provider.of<BusData>(context).fromTextField,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(Provider.of<BusData>(context).selectedDate),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Image.asset('assets/locate.png',scale: 22,),
                        const Icon(
                          Icons.place_outlined,
                          size: 35,
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 30,
                                width: 100,
                                child: Text(
                                  Provider.of<BusData>(context).toTextField,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy').format(Provider.of<BusData>(context).selectedDate),
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
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
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Text(
                      'Report Time: ${bus1.reportTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    Text(
                      'Departure: ${bus1.departureTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    Text(
                      'Arrival: ${bus1.arrivalTime}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Seats Left: ${bus1.seatsLeft}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.deepPurple[400],
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: primary2,
                            ),
                          ),
                          TextSpan(
                            text: 'Ghc 80',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<BusData>().clearData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SeatSelectPage()));
                        },
                        child: const Text('Buy ticket'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.greenAccent[100],
                          // padding: EdgeInsets.symmetric(horizontal: 150,vertical: 18),
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
    );
  }
}
