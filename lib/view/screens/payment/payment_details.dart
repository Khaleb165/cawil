import 'package:cawil/core/constants/colors.dart';
import 'package:cawil/core/constants/show_snackbar.dart';
import 'package:cawil/core/constants/size_config.dart';
import 'package:cawil/data/resources/payment_methods.dart';
import 'package:cawil/view/screens/payment/payment_succes.dart';
import 'package:cawil/view/widgets/custom_appbar.dart';
import 'package:cawil/view/widgets/custom_button.dart';
import 'package:cawil/view_model/bus_data.dart';
import 'package:cawil/view_model/payment_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailsPage extends StatefulWidget {
  final String paymentMethod;

  const PaymentDetailsPage({
    super.key,
    required this.paymentMethod,
  });

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final PaymentMethods _paymentMethods = PaymentMethods();
  bool _isInitializing = false;
  bool _isVerifying = false;

  Future<void> _startPayment(BusData busData) async {
    final scheduleId = busData.selectedScheduleId;
    if (scheduleId == null) {
      showSnackBar('Please select a bus before payment', context);
      return;
    }
    if (busData.selectedSeats.isEmpty) {
      showSnackBar('Please select at least one seat', context);
      return;
    }
    if (busData.nameOfTraveller.trim().isEmpty ||
        busData.phoneNumber.trim().isEmpty) {
      showSnackBar('Contact person and phone number are required', context);
      return;
    }

    setState(() => _isInitializing = true);
    try {
      final payment = await _paymentMethods.initializePaystackPayment(
        scheduleId: scheduleId,
        seatNumbers: busData.selectedSeats,
        contactPerson: busData.nameOfTraveller.trim(),
        phone: busData.phoneNumber.trim(),
        paymentMethod: widget.paymentMethod,
      );

      if (!mounted) return;
      context.read<PaymentData>().setInitializedPayment(payment);

      final launched = await launchUrl(
        Uri.parse(payment.authorizationUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        showSnackBar('Unable to open Paystack checkout', context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  Future<void> _verifyPayment() async {
    final paymentData = context.read<PaymentData>();
    if (!paymentData.hasInitializedPayment) {
      showSnackBar('Start payment first', context);
      return;
    }

    setState(() => _isVerifying = true);
    try {
      final result = await _paymentMethods.verifyPaystackPayment(
        reference: paymentData.paymentReference,
      );

      if (!mounted) return;
      context.read<PaymentData>().setVerifiedPayment(result);
      if (result.isSuccessful) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentSuccessPage(),
          ),
        );
      } else {
        showSnackBar('Payment status: ${result.status}', context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    } finally {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    final busData = Provider.of<BusData>(context);
    final paymentData = Provider.of<PaymentData>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          const CustomAppBar(title: 'Payment Details'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(40)),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Column(
                          crossAxisAlignment: crossStart,
                          children: [
                            SizedBox(height: getProportionateScreenHeight(25)),
                            _detailLabel('Payment Method'),
                            _detailValue(widget.paymentMethod.toUpperCase()),
                            SizedBox(height: getProportionateScreenHeight(16)),
                            _detailLabel('Mobile Number'),
                            _detailValue(busData.phoneNumber),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            _detailLabel('Amount to Pay'),
                            _detailValue(
                              'Ghc ${busData.totalPrice.toStringAsFixed(2)}',
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: crossStart,
                                  children: [
                                    _detailLabel('Ticket Price'),
                                    _detailValue(
                                        'Ghc ${busData.selectedSchedulePrice.toStringAsFixed(2)}'),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: crossStart,
                                  children: [
                                    _detailLabel('Seats'),
                                    _detailValue(busData.joinedSeats),
                                  ],
                                ),
                              ],
                            ),
                            if (paymentData.hasInitializedPayment) ...[
                              SizedBox(
                                  height: getProportionateScreenHeight(16)),
                              _detailLabel('Payment Reference'),
                              _detailValue(paymentData.paymentReference),
                            ],
                            SizedBox(height: getProportionateScreenHeight(30)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(35)),
                  _actionButton(
                    text: paymentData.hasInitializedPayment
                        ? 'Open Checkout'
                        : 'Proceed to Payment',
                    isLoading: _isInitializing,
                    onPressed: _isInitializing
                        ? null
                        : () {
                            if (!paymentData.hasInitializedPayment) {
                              _startPayment(busData);
                            } else {
                              launchUrl(
                                Uri.parse(paymentData.authorizationUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                  ),
                  if (paymentData.hasInitializedPayment) ...[
                    SizedBox(height: getProportionateScreenHeight(15)),
                    _actionButton(
                      text: 'Verify Payment',
                      isLoading: _isVerifying,
                      onPressed: _isVerifying ? null : _verifyPayment,
                    ),
                  ],
                  SizedBox(height: getProportionateScreenHeight(40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        color: lightBlackColor,
      ),
    );
  }

  Widget _detailValue(String text) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(5)),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _actionButton({
    required String text,
    required bool isLoading,
    required VoidCallback? onPressed,
  }) {
    return CustomButton(
      text: text,
      isLoading: isLoading,
      onPressed: onPressed,
      height: getProportionateScreenHeight(55),
      width: getProportionateScreenWidth(350),
    );
  }
}
