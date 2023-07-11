import 'package:cawil/screens/passenger_details.dart';
import 'package:flutter/material.dart';

class SeatSelectPage extends StatefulWidget {
  const SeatSelectPage({Key? key}) : super(key: key);

  @override
  State<SeatSelectPage> createState() => _SeatSelectPageState();
}

class _SeatSelectPageState extends State<SeatSelectPage> {
  List<String> selectedSeats = [];

  void _toggleSeatSelection(String seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }

  Widget _buildSeat(String seatNumber) {
    final isSelected = selectedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: () {
        _toggleSeatSelection(seatNumber);
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatNumber,
            style: TextStyle(
              color: isSelected ? Colors.white : Color.fromRGBO(19, 41, 75, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSeatRow(int rowNumber) {
    final seats = <Widget>[
      _buildSeat('${rowNumber}A'),
      _buildSeat('${rowNumber}B'),
      _buildSeat('${rowNumber}C'),
      _buildSeat('${rowNumber}D'),
    ];

    return seats;
  }

  List<Widget> _buildSeatGrid() {
    final seatRows = <Widget>[];
    for (int row = 1; row <= 8; row++) {
      seatRows.add(
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildSeatRow(row),
          ),
        ),
      );
    }
    return seatRows;
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = selectedSeats.length * 80;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.deepPurple[50],
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0001),
              width: double.infinity,
              height: 200,
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
                  'Select your Seat',
                  style: TextStyle(
                      color: Colors.white, fontSize: 35, letterSpacing: 1.5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        color: Colors.white,
                        child: SizedBox(
                          width: 22,
                          height: 22,
                        )),
                    Text(
                      'Available',
                      style: TextStyle(
                          color: Color.fromRGBO(19, 41, 75, 1),
                          letterSpacing: 1.5),
                    )
                  ],
                ),
                Column(
                  children: [
                    Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        color: Colors.greenAccent,
                        child: SizedBox(
                          width: 22,
                          height: 22,
                        )),
                    Text(
                      'Selected',
                      style: TextStyle(
                          color: Color.fromRGBO(19, 41, 75, 1),
                          letterSpacing: 1.5),
                    )
                  ],
                ),
                Column(
                  children: [
                    Card(
                        elevation: 20,
                        shadowColor: Colors.white,
                        color: Color.fromRGBO(19, 41, 75, 1),
                        child: SizedBox(
                          width: 22,
                          height: 22,
                        )),
                    Text(
                      'Booked',
                      style: TextStyle(
                          color: Color.fromRGBO(19, 41, 75, 1),
                          letterSpacing: 1.5),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: _buildSeatGrid(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              width: double.infinity,
              // height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.elliptical(20, 20),
                    topLeft: Radius.elliptical(20, 20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Seat No: ',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple[300]),
                      ),
                      Expanded(
                        child: Text(
                          ' ${selectedSeats.join(', ')}',
                          style: TextStyle(
                              color: Colors.deepPurple[300], fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Price: Ghc ${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple[300]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PassengerDetailsPage(
                                      totalPrice: totalPrice,
                                      selectedSeats: selectedSeats,
                                    )));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
