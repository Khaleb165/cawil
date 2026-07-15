import 'package:cawil/model/payment_init.dart';
import 'package:cawil/model/payment_verify.dart';
import 'package:flutter/material.dart';

class PaymentData extends ChangeNotifier {
  int? bookingId;
  String bookingRef = '';
  String paymentReference = '';
  String authorizationUrl = '';
  double amount = 0;
  String currency = 'GHS';
  String status = '';

  bool get hasInitializedPayment =>
      bookingId != null &&
      bookingRef.isNotEmpty &&
      paymentReference.isNotEmpty &&
      authorizationUrl.isNotEmpty;

  bool get isCompleted => status == 'completed';

  void setInitializedPayment(PaymentInitResult payment) {
    bookingId = payment.bookingId;
    bookingRef = payment.bookingRef;
    paymentReference = payment.reference;
    authorizationUrl = payment.authorizationUrl;
    amount = payment.amount;
    currency = payment.currency;
    status = payment.status;
    notifyListeners();
  }

  void setVerifiedPayment(PaymentVerifyResult payment) {
    bookingRef = payment.bookingRef;
    paymentReference = payment.reference;
    status = payment.status;
    notifyListeners();
  }

  void clear() {
    bookingId = null;
    bookingRef = '';
    paymentReference = '';
    authorizationUrl = '';
    amount = 0;
    currency = 'GHS';
    status = '';
    notifyListeners();
  }
}
