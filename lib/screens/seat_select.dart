import 'package:cawil/constants/colors.dart';
import 'package:cawil/models/bus_data.dart';
import 'package:cawil/screens/passenger_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatSelectPage extends StatefulWidget {
  const SeatSelectPage({Key? key}) : super(key: key);

  @override
  State<SeatSelectPage> createState() => _SeatSelectPageState();
}

class _SeatSelectPageState extends State<SeatSelectPage> {
  // List<String> selectedSeats = []

  void _toggleSeatSelection(String seatNumber) {
    final busData = Provider.of<BusData>(context, listen: false);
    setState(() {
      if (busData.containSeat(seatNumber)) {
        busData.removeSeatSelection(seatNumber);
      } else {
        busData.addSeatSelection(seatNumber);
      }
    });
  }

  Widget _buildSeat(String seatNumber) {
    final isSelected =
        Provider.of<BusData>(context, listen: false).containSeat(seatNumber);

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
    final double totalPrice = Provider.of<BusData>(context).totalPrice;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              // margin: EdgeInsets.only(
              //     top: MediaQuery.of(context).size.height * 0.0001),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [shade1, shade1, shade2],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(50, 50),
                ),
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
            SizedBox(height: 10),
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
            SizedBox(height: 30),
            Column(
              children: _buildSeatGrid(),
            ),
            SizedBox(height: 20),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                // margin: EdgeInsets.only(
                // top: MediaQuery.of(context).size.height * 0.05),
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
                            color: Colors.deepPurple[300],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' ${Provider.of<BusData>(context).joinedSeats}',
                            style: TextStyle(
                              color: Colors.deepPurple[300],
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Price: Ghc ${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple[300],
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PassengerDetailsPage(
                                  // totalPrice: totalPrice,
                                  // selectedSeats: selectedSeats,
                                  ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(19, 41, 75, 1),
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
