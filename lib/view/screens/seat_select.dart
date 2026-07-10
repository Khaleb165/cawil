import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view_model/bus_data.dart';
import 'package:cawil/view/screens/passenger_details.dart';
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
        width: getProportionateScreenWidth(40),
        height: getProportionateScreenHeight(40),
        margin: EdgeInsets.all(getProportionateScreenHeight(5)),
        decoration: BoxDecoration(
          color: isSelected ? greenAccentColor : whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatNumber,
            style: TextStyle(
              color: isSelected ? whiteColor : darkBlueColor,
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
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: crossCenter,
            children: _buildSeatRow(row),
          ),
        ),
      );
    }
    return seatRows;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    final double totalPrice = Provider.of<BusData>(context).totalPrice;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30),
                  vertical: getProportionateScreenHeight(20)),
              width: double.infinity,
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [deepBlueColor, deepBlueColor, purpleColor],
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(getProportionateScreenWidth(50),
                      getProportionateScreenHeight(40)),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Select your Seat',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: getProportionateScreenHeight(30),
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                seatStatusBuilder(seatStatus: 'Available'),
                seatStatusBuilder(
                    seatStatus: 'Selected', color: greenAccentColor),
                seatStatusBuilder(color: darkBlueColor),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Column(
              children: _buildSeatGrid(),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30),
                    vertical: getProportionateScreenHeight(20)),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(getProportionateScreenWidth(20),
                        getProportionateScreenHeight(20)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: mainStart,
                  crossAxisAlignment: crossStart,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Seat No: ',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w500,
                            color: lightPurpleColorShade1,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' ${Provider.of<BusData>(context).joinedSeats}',
                            style: TextStyle(
                              color: lightPurpleColorShade1,
                              fontSize: getProportionateScreenHeight(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Text(
                      'Price: ¢${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w500,
                        color: lightPurpleColorShade1,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PassengerDetailsPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: darkBlueColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(60),
                              vertical: getProportionateScreenHeight(15)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: whiteColor,
                            letterSpacing: 1.5,
                            fontSize: getProportionateScreenHeight(15),
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

  Column seatStatusBuilder({
    String seatStatus = 'Booked',
    Color color = Colors.white,
  }) {
    return Column(
      children: [
        Card(
            elevation: 20,
            shadowColor: whiteColor,
            color: color,
            child: SizedBox(
              width: getProportionateScreenWidth(22),
              height: getProportionateScreenHeight(22),
            )),
        Text(
          seatStatus,
          style: TextStyle(
            color: darkBlueColor,
            letterSpacing: 1.5,
          ),
        )
      ],
    );
  }
}
