import 'package:flutter/material.dart';
import '../data/fake_database.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final hallName = args["hallName"];
    final imagePath = args["imagePath"];
    final DateTime date = args["date"];
    final int hours = args["hours"];
    final List addOns = args["addOns"];
    final int total = args["total"];

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text("Summary", style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hall: $hallName"),
            Text("Date: ${date.day}/${date.month}/${date.year}"),
            Text("Hours: $hours"),

            Text(
              "Add-ons: ${addOns.isEmpty ? "None" : addOns.join(", ")}",
              style: const TextStyle(fontSize: 16),
            ),

            Text("Total: RM $total",
                style: const TextStyle(fontWeight: FontWeight.bold)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  bookingsDB.add({
                    "hall": hallName,
                    "date": "${date.day}/${date.month}/${date.year}",
                    "hours": hours,
                    "addOns": addOns,
                    "total": total,
                    "status": "Pending",
                  });

                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                ),
                child: const Text(
                  "Confirm Booking",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
