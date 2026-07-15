class PaymentInitResult {
  final String authorizationUrl;
  final int bookingId;
  final String reference;
  final String bookingRef;
  final double amount;
  final String currency;
  final String status;

  const PaymentInitResult({
    required this.authorizationUrl,
    required this.bookingId,
    required this.reference,
    required this.bookingRef,
    required this.amount,
    required this.currency,
    required this.status,
  });

  factory PaymentInitResult.fromJson(Map<String, dynamic> json) {
    final payment = Map<String, dynamic>.from(json['payment'] as Map);
    final booking = Map<String, dynamic>.from(json['booking'] as Map);
    return PaymentInitResult(
      authorizationUrl: json['authorization_url'].toString(),
      bookingId: (booking['id'] as num).toInt(),
      reference: json['reference'].toString(),
      bookingRef: payment['booking_ref'].toString(),
      amount: _parseDouble(payment['amount']),
      currency: payment['currency']?.toString() ?? 'GHS',
      status: payment['status']?.toString() ?? 'pending',
    );
  }
}

double _parseDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}
