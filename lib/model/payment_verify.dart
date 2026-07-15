class PaymentVerifyResult {
  final String status;
  final String bookingRef;
  final String reference;

  const PaymentVerifyResult({
    required this.status,
    required this.bookingRef,
    required this.reference,
  });

  bool get isSuccessful => status == 'completed';

  factory PaymentVerifyResult.fromJson(Map<String, dynamic> json) {
    final payment = Map<String, dynamic>.from(json['payment'] as Map);
    return PaymentVerifyResult(
      status: payment['status']?.toString() ?? 'pending',
      bookingRef: payment['booking_ref'].toString(),
      reference: payment['provider_reference'].toString(),
    );
  }
}
