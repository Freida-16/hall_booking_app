import 'package:flutter/material.dart';
import '../data/fake_database.dart';
import 'update_booking_page.dart';
import 'payment_page.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Bookings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: bookingsDB.isEmpty
          ? const Center(
              child: Text(
                "No bookings yet...",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookingsDB.length,
              itemBuilder: (context, index) {
                final b = bookingsDB[index];
                final isPaid = b["status"] == "Paid";

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HALL NAME
                      Text(
                        b["hall"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text("Date: ${b["date"]}"),
                      Text("Hours: ${b["hours"]}"),
                      Text(
                        "Add-ons: ${b["addOns"].isEmpty ? "None" : b["addOns"].join(", ")}",
                      ),
                      Text(
                        "Total Price: RM ${b["total"]}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 10),
                      _badge(b["status"]),
                      const SizedBox(height: 14),

                      // ==========================
                      // ACTION BUTTONS (FIXED)
                      // ==========================
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          // PAY NOW
                          if (!isPaid)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PaymentPage(bookingIndex: index),
                                  ),
                                ).then((_) => setState(() {}));
                              },
                              child: const Text("Pay Now"),
                            ),

                          // EDIT
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                            ),
                            onPressed: isPaid
                                ? null
                                : () async {
                                    final cleanData =
                                        _sanitizeBooking(b);

                                    final updated =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UpdateBookingPage(
                                          bookingData: cleanData,
                                          bookingIndex: index,
                                        ),
                                      ),
                                    );

                                    if (updated != null) {
                                      setState(() {});
                                    }
                                  },
                            child: const Text("Edit"),
                          ),

                          // CANCEL
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 12,
                              ),
                            ),
                            onPressed: isPaid
                                ? null
                                : () {
                                    setState(() =>
                                        bookingsDB.removeAt(index));
                                  },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // =================
  // DATA SANITIZER
  // =================
  Map<String, dynamic> _sanitizeBooking(Map<String, dynamic> b) {
    String date = b["date"].toString().trim();

    int hours = b["hours"] is int
        ? b["hours"]
        : int.tryParse(b["hours"].toString()) ?? 1;

    List addOns = b["addOns"] is List ? b["addOns"] : [];

    return {
      "hall": b["hall"],
      "date": date,
      "hours": hours,
      "addOns": addOns,
      "total": b["total"],
      "status": b["status"],
    };
  }

  // =================
  // STATUS BADGE
  // =================
  Widget _badge(String status) {
    Color c = status == "Pending"
        ? Colors.orange
        : status == "Approved"
            ? Colors.green
            : status == "Paid"
                ? Colors.blue
                : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(20)),
      child:
          Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
