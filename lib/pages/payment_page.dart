import 'package:flutter/material.dart';
import '../data/booking_service.dart';

class PaymentPage extends StatelessWidget {
  final int bookingId;

  const PaymentPage({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _paymentOption(context, "Credit / Debit Card"),
            _paymentOption(context, "Online Banking"),
            _paymentOption(context, "E-Wallet"),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(BuildContext context, String method) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await BookingService.updateStatus(bookingId, "Paid");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Payment via $method successful")),
          );

          Navigator.pop(context);
        },
        child: Text(method),
      ),
    );
  }
}
