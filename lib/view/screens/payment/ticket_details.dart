import 'dart:io';

import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/show_snackbar.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/data/resources/payment_methods.dart';
import 'package:cawil/view/screens/homepage.dart';
import 'package:cawil/view_model/payment_data.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../view_model/bus_data.dart';
import '../../widgets/ticket_details_card.dart';

class TicketDetailsPage extends StatefulWidget {
  const TicketDetailsPage({
    super.key,
  });

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  bool _isOpeningPdf = false;

  Future<void> _openPdfTicket() async {
    setState(() => _isOpeningPdf = true);
    try {
      final paymentData = context.read<PaymentData>();
      final bookingId = paymentData.bookingId;
      if (bookingId == null) {
        showSnackBar('No booking found for this ticket', context);
        return;
      }

      final bytes = await PaymentMethods().downloadTicketPdf(
        bookingId: bookingId,
      );
      final directory = await getTemporaryDirectory();
      final safeRef = paymentData.bookingRef.replaceAll(
        RegExp(r'[^A-Za-z0-9_-]'),
        '_',
      );
      final file = File('${directory.path}/cawil-ticket-$safeRef.pdf');
      await file.writeAsBytes(bytes, flush: true);
      await OpenFilex.open(file.path);
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isOpeningPdf = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final busData = Provider.of<BusData>(context).selectedSeats;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [deepBlueColor, deepBlueColor, purpleColor],
                tileMode: TileMode.clamp,
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.elliptical(50, 50),
                bottomLeft: Radius.elliptical(50, 50),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Ticket Details',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TicketDetailsCard(busData: busData),
                  ),
                  _ticketButton(
                    text: 'Open PDF Ticket',
                    color: deepBlueColor,
                    isLoading: _isOpeningPdf,
                    onPressed: _isOpeningPdf ? null : _openPdfTicket,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  _ticketButton(
                    text: 'Go to Home',
                    color: greenAccentColor,
                    onPressed: () {
                      Provider.of<BusData>(context, listen: false)
                          .clearFieldsData();
                      Provider.of<PaymentData>(context, listen: false).clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketButton({
    required String text,
    required Color color,
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: SizedBox(
        height: 55,
        width: 350,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: isLoading
              ? CircularProgressIndicator(color: whiteColor)
              : Text(
                  text,
                  style: TextStyle(
                    color: whiteColor,
                    letterSpacing: 1,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
