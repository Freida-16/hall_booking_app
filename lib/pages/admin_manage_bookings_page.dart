import 'package:flutter/material.dart';
import '../data/fake_database.dart';

class AdminManageBookingsPage extends StatefulWidget {
  const AdminManageBookingsPage({super.key});

  @override
  State<AdminManageBookingsPage> createState() =>
      _AdminManageBookingsPageState();
}

class _AdminManageBookingsPageState
    extends State<AdminManageBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Manage Bookings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: bookingsDB.isEmpty
          ? const Center(
              child: Text(
                "No bookings available.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookingsDB.length,
              itemBuilder: (context, index) {
                final b = bookingsDB[index];
                final bool isPaid = b["status"] == "Paid";

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b["hall"],
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("Date: ${b["date"]}"),
                      Text("Hours: ${b["hours"]}"),
                      Text(
                        "Add-ons: ${b["addOns"].isEmpty ? "None" : b["addOns"].join(", ")}",
                      ),
                      Text("Total: RM ${b["total"]}"),

                      const SizedBox(height: 10),
                      _statusBadge(b["status"]),

                      if (isPaid)
                        const Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "Payment completed. No further action allowed.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54),
                          ),
                        ),

                      const SizedBox(height: 15),

                      Row(
                        children: [
                          // APPROVE
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPaid
                                  ? Colors.grey
                                  : Colors.green[300],
                            ),
                            onPressed: isPaid
                                ? null
                                : () => _confirmAction(
                                      context,
                                      "Approve Booking",
                                      "Are you sure you want to approve this booking?",
                                      () {
                                        setState(() {
                                          b["status"] = "Approved";
                                        });
                                      },
                                    ),
                            child: const Text(
                              "Approve",
                              style:
                                  TextStyle(color: Colors.black),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // REJECT
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPaid
                                  ? Colors.grey
                                  : Colors.red[300],
                            ),
                            onPressed: isPaid
                                ? null
                                : () => _confirmAction(
                                      context,
                                      "Reject Booking",
                                      "Are you sure you want to reject this booking?",
                                      () {
                                        setState(() {
                                          b["status"] = "Rejected";
                                        });
                                      },
                                    ),
                            child: const Text(
                              "Reject",
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // DELETE
                          IconButton(
                            onPressed: isPaid
                                ? null
                                : () => _confirmAction(
                                      context,
                                      "Delete Booking",
                                      "This action cannot be undone. Continue?",
                                      () {
                                        setState(() {
                                          bookingsDB
                                              .removeAt(index);
                                        });
                                      },
                                    ),
                            icon: Icon(
                              Icons.delete,
                              color: isPaid
                                  ? Colors.grey
                                  : Colors.black,
                            ),
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

  // =====================
  // STATUS BADGE
  // =====================
  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case "Pending":
        color = Colors.orange;
        break;
      case "Approved":
        color = Colors.green;
        break;
      case "Rejected":
        color = Colors.red;
        break;
      case "Paid":
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  // =====================
  // CONFIRM DIALOG
  // =====================
  void _confirmAction(BuildContext context, String title,
      String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
