import 'package:flutter/material.dart';
import '../data/booking_service.dart';

class AdminManageBookingsPage extends StatefulWidget {
  const AdminManageBookingsPage({super.key});

  @override
  State<AdminManageBookingsPage> createState() =>
      _AdminManageBookingsPageState();
}

class _AdminManageBookingsPageState
    extends State<AdminManageBookingsPage> {
  late Future<List<Map<String, dynamic>>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    _bookingsFuture = BookingService.getBookings();
  }

  Future<bool> _confirmDialog(String title, String message) async {
    return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Confirm"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: const Text("Manage Bookings"),
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bookingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No bookings found"));
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          Text(
            b["hall"],
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text("Date: ${b["date"]}"),
          Text("Hours: ${b["hours"]}"),
          Text("Add-ons: ${b["addOns"]}"),
          Text(
            "Total: RM ${b["total"]}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          _statusBadge(b["status"]),
          const SizedBox(height: 14),

          Row(
            children: [
              _actionButton(
                text: "Approve",
                color: Colors.green,
                onTap: () async {
                  final ok = await _confirmDialog(
                    "Approve Booking",
                    "Approve this booking?",
                  );
                  if (ok) {
                    await BookingService.updateStatus(
                        b["id"], "Approved");
                    setState(_loadBookings);
                  }
                },
              ),
              const SizedBox(width: 10),
              _actionButton(
                text: "Reject",
                color: Colors.red,
                onTap: () async {
                  final ok = await _confirmDialog(
                    "Reject Booking",
                    "Reject this booking?",
                  );
                  if (ok) {
                    await BookingService.updateStatus(
                        b["id"], "Rejected");
                    setState(_loadBookings);
                  }
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final ok = await _confirmDialog(
                    "Delete Booking",
                    "Delete this booking permanently?",
                  );
                  if (ok) {
                    await BookingService.deleteBooking(b["id"]);
                    setState(_loadBookings);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white, // 🔥 FONT PUTIH
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case "Approved":
        color = Colors.green;
        break;
      case "Rejected":
        color = Colors.red;
        break;
      case "Paid":
        color = Colors.black;
        break;
      default:
        color = const Color(0xFFD4AF37);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
