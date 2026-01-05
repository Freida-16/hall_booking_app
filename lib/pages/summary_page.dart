import 'package:flutter/material.dart';
import '../data/booking_service.dart';
import 'home_guest_page.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String hallName = args["hallName"];
    final DateTime date = args["date"];
    final int hours = args["hours"];
    final List addOns = args["addOns"];
    final int total = args["total"];

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        centerTitle: true,
        title: const Text("Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _info("Hall", hallName),
            _info("Date", "${date.day}/${date.month}/${date.year}"),
            _info("Hours", hours.toString()),
            _info("Add-ons", addOns.isEmpty ? "None" : addOns.join(", ")),
            const SizedBox(height: 10),
            Text(
              "Total: RM $total",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color(0xFFD4AF37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  await BookingService.addBooking({
                    "hall": hallName,
                    "date": "${date.day}/${date.month}/${date.year}",
                    "hours": hours,
                    "addOns": addOns,
                    "total": total,
                    "status": "Pending",
                  });

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("✅ Booking saved successfully"),
                    ),
                  );

                  // 🔥 BALIK KE HOME (TAB HOME)
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeGuestPage(startIndex: 0),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text("$label: $value"),
    );
  }
}
