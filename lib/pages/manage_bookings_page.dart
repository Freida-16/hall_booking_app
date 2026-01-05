import 'package:flutter/material.dart';
import '../services/booking_service.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  late Future<List<Map<String, dynamic>>> bookingsFuture;

  @override
  void initState() {
    super.initState();
    bookingsFuture = BookingService.getBookings();
  }

  void _refresh() {
    setState(() {
      bookingsFuture = BookingService.getBookings();
    });
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
      body: FutureBuilder(
        future: bookingsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data!;

          if (bookings.isEmpty) {
            return const Center(child: Text("No bookings yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final b = bookings[index];

              return _bookingCard(
                hall: b["hall"],
                date: b["date"],
                hours: b["hours"],
                total: b["total"],
                status: b["status"],
                id: b["id"],
              );
            },
          );
        },
      ),
    );
  }

  Widget _bookingCard({
    required int id,
    required String hall,
    required String date,
    required int hours,
    required int total,
    required String status,
  }) {
    final isPaid = status == "Paid";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E7DC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(hall, style: const TextStyle(fontWeight: FontWeight.bold)),
              _statusBadge(status),
            ],
          ),
          Text("Date: $date"),
          Text("Hours: $hours"),
          Text("Total: RM $total",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          Row(
            children: [
              if (status == "Approved")
                ElevatedButton(
                  onPressed: () async {
                    await BookingService.updateStatus(id, "Paid");
                    _refresh();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: const Color(0xFFD4AF37),
                  ),
                  child: const Text("Pay Now"),
                ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await BookingService.deleteBooking(id);
                  _refresh();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bg = status == "Paid"
        ? Colors.black
        : status == "Approved"
            ? Colors.green
            : const Color(0xFFD4AF37);

    Color fg = status == "Paid" ? const Color(0xFFD4AF37) : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(30)),
      child: Text(status,
          style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
    );
  }
}
