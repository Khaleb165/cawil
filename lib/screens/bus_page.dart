// ignore_for_file: unused_import

import 'package:cawil/constants/colors.dart';
import 'package:cawil/screens/components/TicketCard.dart';
import 'package:cawil/screens/seat_select.dart';
import 'package:cawil/screens/settings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';

class BusPage extends StatefulWidget {
  final String source;
  final String destination;
  final DateTime date;
  const BusPage({
    Key? key,
    required this.source,
    required this.destination,
    required this.date,
  }) : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.0001),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [shade1, shade1, shade2],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(50, 50),
                      bottomLeft: Radius.elliptical(50, 50)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 55),
                    Text(
                      'Ca',
                      style: TextStyle(
                          fontSize: 50,
                          color: primary1,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Wil',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: primary2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/bus-logo.png',
                      scale: 4,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Buses Available',
                      style: TextStyle(
                          fontSize: 35,
                          color: primary2,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              ClipPath(
                clipper: SideCutClipper(),
                child: Container(
                  height: 250,
                  child: Expanded(
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
                        child: Expanded(
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
                                    height: 10,
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
                                          height: 30,
                                          width: 100,
                                          child: Text(
                                            '${widget.source}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${DateFormat('dd/MM/yyyy').format(widget.date)}',
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
                                width: 30,
                              ),
                              DottedLine(
                                direction: Axis.vertical,
                                dashColor: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
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
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipPath(
                clipper: SideCutClipper(),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: Expanded(
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
                        child: Expanded(
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
                                    'Second Bus',
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      color: primary2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                          height: 30,
                                          width: 100,
                                          child: Text(
                                            '${widget.source}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    letterSpacing: 1,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${DateFormat('dd/MM/yyyy').format(widget.date)}',
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
                                width: 30,
                              ),
                              DottedLine(
                                direction: Axis.vertical,
                                dashColor: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 15)),
                                  Text(
                                    'Report Time: 12pm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: primary2,
                                    ),
                                  ),
                                  Text(
                                    'Departure: 1pm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: primary2,
                                    ),
                                  ),
                                  Text(
                                    'Arrival: 5pm',
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
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
