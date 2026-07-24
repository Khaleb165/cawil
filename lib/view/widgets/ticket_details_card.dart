import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/view_model/payment_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../view_model/bus_data.dart';

class TicketDetailsCard extends StatelessWidget {
  const TicketDetailsCard({
    super.key,
    required this.busData,
  });

  final List<String> busData;

  @override
  Widget build(BuildContext context) {
    final bookingData = context.watch<BusData>();
    final paymentData = context.watch<PaymentData>();
    final qrData = _ticketQrData(
      bookingRef: paymentData.bookingRef,
      scheduleId: bookingData.selectedScheduleId,
      seats: bookingData.selectedSeats,
      contactPerson: bookingData.nameOfTraveller,
      paymentStatus:
          paymentData.status.isNotEmpty ? paymentData.status : 'completed',
    );

    return Column(
      crossAxisAlignment: crossStart,
      children: List.generate(busData.length, (index) {
        final seatNumber = busData[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            'Contact Person',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: lightBlackColor,
                            ),
                          ),
                          Text(
                            bookingData.nameOfTraveller,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            'Mobile Number',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: lightBlackColor),
                          ),
                          Text(
                            bookingData.phoneNumber,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18),
                          )
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      Column(
                        crossAxisAlignment: crossStart,
                        children: [
                          Text(
                            'Ticket Price ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: lightBlackColor),
                          ),
                          Text(
                            'Ghc ${bookingData.selectedSchedulePrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),
                      Row(
                        children: [
                          Text(
                            'Seat No:',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: lightBlackColor),
                          ),
                          SizedBox(width: getProportionateScreenWidth(8)),
                          Text(seatNumber)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(12)),
                Container(
                  width: 104,
                  height: 104,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: lightBlackColor.withValues(alpha: .12),
                    ),
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    backgroundColor: whiteColor,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    gapless: false,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _ticketQrData({
    required String bookingRef,
    required int? scheduleId,
    required List<String> seats,
    required String contactPerson,
    required String paymentStatus,
  }) {
    return {
      'booking_ref': bookingRef,
      'schedule_id': scheduleId,
      'seats': seats,
      'contact_person': contactPerson,
      'payment_status': paymentStatus,
    }.toString();
  }
}
