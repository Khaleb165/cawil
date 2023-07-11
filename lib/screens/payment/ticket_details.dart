import 'package:cawil/screens/homepage.dart';
import 'package:flutter/material.dart';

class TicketDetailsPage extends StatelessWidget {
  final String name;
  final String contactNumber;
  final List<String> selectedSeats;

  const TicketDetailsPage({
    required this.name,
    required this.contactNumber,
    required this.selectedSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.00008),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(0, 7, 240, 0.5),
                  Color.fromRGBO(127, 0, 255, 100)
                ],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(50, 50),
                  bottomLeft: Radius.elliptical(50, 50)),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Ticket Details',
                style: TextStyle(
                    color: Colors.white, fontSize: 25, letterSpacing: 1),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(selectedSeats.length, (index) {
                final seatNumber = selectedSeats[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Ticket ${index + 1}',
                            //   style: TextStyle(
                            //     fontSize: 18,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // SizedBox(height: 8.0),
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
                                  '$name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
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
                                  '$contactNumber',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
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
                                      fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Seat No:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.black45),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
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
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              height: 55,
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomepageScreen()),
                      (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                child: Text(
                  'Go to Home',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
