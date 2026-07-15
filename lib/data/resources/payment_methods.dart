import 'package:cawil/data/remote/dio_client.dart';
import 'package:cawil/model/payment_init.dart';
import 'package:cawil/model/payment_verify.dart';

class PaymentMethods {
  Future<PaymentInitResult> initializePaystackPayment({
    required int scheduleId,
    required List<String> seatNumbers,
    required String contactPerson,
    required String phone,
    required String paymentMethod,
  }) async {
    final response = await DioClient().post(
      '/payments',
      {
        'schedule_id': scheduleId,
        'seat_numbers': seatNumbers,
        'contact_person': contactPerson,
        'phone': phone,
        'payment_method': paymentMethod,
      },
    );

    return PaymentInitResult.fromJson(
      Map<String, dynamic>.from(response as Map),
    );
  }

  Future<PaymentVerifyResult> verifyPaystackPayment({
    required String reference,
  }) async {
    final response = await DioClient().post(
      '/payments/verify',
      {'reference': reference},
    );

    return PaymentVerifyResult.fromJson(
      Map<String, dynamic>.from(response as Map),
    );
  }

  Future<List<int>> downloadTicketPdf({
    required int bookingId,
  }) async {
    return DioClient().getBytes('/bookings/$bookingId/ticket.pdf');
  }
}
