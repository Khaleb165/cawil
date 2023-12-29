import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../screens/bus_page.dart';
import '../screens/seat_select.dart';

class BusCard extends StatelessWidget {
  const BusCard({
    super.key,
    required this.widget,
  });

  final BusPage widget;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: SideCutClipper(),
      child: Container(
        height: 250,
        child: Card(
          elevation: 15,
          borderOnForeground: false,
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Text(
                      'First Bus',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: primary2,
                      ),
                    ),
                    SizedBox(
                      height: 10
                    ),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Image.asset('assets/send1.png',scale: 6,),
                        Icon(
                          Icons.near_me_outlined,
                          size: 35,
                          color: Colors.greenAccent[100],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            // height: 30,
                            width: 100,
                            child: Text(
                              '${widget.source}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        '${DateFormat('dd/MM/yyyy').format(widget.date)}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Image.asset('assets/locate.png',scale: 22,),
                        Icon(
                          Icons.place_outlined,
                          size: 35,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 30,
                                width: 100,
                                child: Text(
                                  '${widget.destination}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Text(
                              '${DateFormat('dd/MM/yyyy').format(
                                  widget.date)}',
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
                SizedBox(
                    width: 30
                ),
                DottedLine(
                  direction: Axis.vertical,
                  dashColor: Colors.black,
                ),
                SizedBox(
                    width: 10
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Text(
                      'Report Time: 9am',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    Text(
                      'Departure: 10am',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    Text(
                      'Arrival: 2pm',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: primary2,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Seats Left: 36',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.deepPurple[400],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Price: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: primary2,
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
                                      SeatSelectPage()));
                        },
                        child: Text('Buy ticket'),
                        style: TextButton.styleFrom(
                          backgroundColor:
                          Colors.greenAccent[100],
                          // padding: EdgeInsets.symmetric(horizontal: 150,vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(25)),
                        ),),
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