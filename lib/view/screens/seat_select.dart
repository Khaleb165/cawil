import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view/widgets/custom_appbar.dart';
import 'package:cawil/view_model/bus_data.dart';
import 'package:cawil/view/screens/contact_details.dart';
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
    if (busData.isBookedSeat(seatNumber)) {
      return;
    }
    setState(() {
      if (busData.containSeat(seatNumber)) {
        busData.removeSeatSelection(seatNumber);
      } else {
        busData.addSeatSelection(seatNumber);
      }
    });
  }

  Widget _buildSeat(String seatNumber) {
    final busData = Provider.of<BusData>(context, listen: false);
    final isSelected = busData.containSeat(seatNumber);
    final isBooked = busData.isBookedSeat(seatNumber);

    return GestureDetector(
      onTap: isBooked ? null : () => _toggleSeatSelection(seatNumber),
      child: Container(
        width: getProportionateScreenWidth(40),
        height: getProportionateScreenHeight(40),
        margin: EdgeInsets.all(getProportionateScreenHeight(5)),
        decoration: BoxDecoration(
          color: isBooked
              ? darkBlueColor
              : isSelected
                  ? greenAccentColor
                  : whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatNumber,
            style: TextStyle(
              color: isBooked || isSelected ? whiteColor : darkBlueColor,
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
    final totalSeats =
        Provider.of<BusData>(context, listen: false).selectedBusTotalSeats;
    final seatRows = <Widget>[];
    final rowCount = (totalSeats / 4).ceil();
    for (int row = 1; row <= rowCount; row++) {
      seatRows.add(
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: crossCenter,
            children: _buildSeatRow(row)
                .take((totalSeats - ((row - 1) * 4)).clamp(0, 4))
                .toList(),
          ),
        ),
      );
    }
    return seatRows;
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    final busData = Provider.of<BusData>(context);
    final double totalPrice = busData.totalPrice;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomAppBar(title: 'Select Seats'),
            SizedBox(height: getProportionateScreenHeight(10)),
            if (busData.selectedBusNumber.isNotEmpty)
              Text(
                '${busData.selectedBusNumber} • ${busData.selectedBusTotalSeats} seats • ¢${busData.selectedSchedulePrice.toStringAsFixed(2)} per seat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkBlueColor,
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (busData.selectedBusNumber.isNotEmpty)
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
                      'Seats left: ${busData.selectedScheduleSeatsLeft}',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(18),
                        fontWeight: FontWeight.w500,
                        color: lightPurpleColorShade1,
                      ),
                    ),
                    if (busData.selectedBookedSeats.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(5)),
                        child: Text(
                          'Booked: ${busData.selectedBookedSeats.join(', ')}',
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w500,
                            color: darkBlueColor,
                          ),
                        ),
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
                        onPressed: busData.selectedSeats.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactDetailsPage()),
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
