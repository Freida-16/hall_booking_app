import 'package:flutter/material.dart';
import '../data/booking_service.dart';
import 'payment_page.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  late Future<List<Map<String, dynamic>>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    _bookingsFuture = BookingService.getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings yet"));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return _bookingCard(bookings[index]);
            },
          );
        },
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> b) {
    final bool isPaid = b["status"] == "Paid";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E7DC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                b["hall"],
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              _statusBadge(b["status"]),
            ],
          ),

          const SizedBox(height: 10),
          Text("Date: ${b["date"]}"),
          Text("Hours: ${b["hours"]}"),
          Text(
            "Total: RM ${b["total"]}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              if (!isPaid)
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PaymentPage(bookingId: b["id"]),
                      ),
                    );
                    setState(_loadBookings);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: const Color(0xFFD4AF37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Pay Now"),
                ),

              if (!isPaid) const SizedBox(width: 10),

              ElevatedButton(
                onPressed: isPaid
                    ? null // 🔥 DISABLE BILA PAID
                    : () async {
                        await Navigator.pushNamed(
                          context,
                          '/editBooking',
                          arguments: {
                            "id": b["id"],
                            "date": b["date"],
                            "hours": b["hours"],
                          },
                        );
                        setState(_loadBookings);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isPaid ? Colors.grey.shade300 : Colors.white,
                  foregroundColor:
                      isPaid ? Colors.grey : const Color(0xFFD4AF37),
                  elevation: 0,
                  side: const BorderSide(color: Color(0xFFD4AF37)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(isPaid ? "Paid" : "Edit"),
              ),

              const Spacer(),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await BookingService.deleteBooking(b["id"]);
                  setState(_loadBookings);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    final bool isPaid = status == "Paid";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isPaid ? Colors.black : const Color(0xFFD4AF37),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isPaid ? const Color(0xFFD4AF37) : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
