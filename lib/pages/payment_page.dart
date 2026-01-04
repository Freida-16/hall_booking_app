import 'package:flutter/material.dart';
import '../data/fake_database.dart';
import 'payment_success_page.dart';

class PaymentPage extends StatefulWidget {
  final int bookingIndex;

  const PaymentPage({super.key, required this.bookingIndex});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = "FPX";

  @override
  Widget build(BuildContext context) {
    final booking = bookingsDB[widget.bookingIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text("Payment",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _card("Hall", booking["hall"]),
            _card("Date", booking["date"]),
            _card("Total", "RM ${booking["total"]}"),

            const SizedBox(height: 20),

            const Text("Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            _radio("FPX"),
            _radio("Credit / Debit Card"),

            const Spacer(),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[300],
                ),
                onPressed: () {
                  // MARK AS PAID
                  updateBooking(widget.bookingIndex, {
                    ...booking,
                    "status": "Paid",
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentSuccessPage(),
                    ),
                  );
                },
                child: const Text("Pay Now",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _radio(String label) {
    return RadioListTile(
      value: label,
      groupValue: selectedMethod,
      onChanged: (value) {
        setState(() {
          selectedMethod = value!;
        });
      },
      title: Text(label),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
