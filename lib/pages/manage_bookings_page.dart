import 'package:flutter/material.dart';
import '../data/fake_database.dart';

class ManageBookingsPage extends StatefulWidget {
  const ManageBookingsPage({super.key});

  @override
  State<ManageBookingsPage> createState() => _ManageBookingsPageState();
}

class _ManageBookingsPageState extends State<ManageBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text("Manage Bookings",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: bookingsDB.isEmpty
          ? const Center(child: Text("No bookings yet...", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookingsDB.length,
              itemBuilder: (context, index) {
                final b = bookingsDB[index];

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
                      Text(b["hall"],
                          style:
                              const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      Text("Date: ${b["date"]}"),
                      Text("Hours: ${b["hours"]}"),
                      Text("Add-ons: ${b["addOns"].join(", ")}"),
                      Text("Total: RM ${b["total"]}"),
                      const SizedBox(height: 10),
                      _badge(b["status"]),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // APPROVE
                          if (b["status"] == "Pending")
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  b["status"] = "Approved";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[300],
                              ),
                              child: const Text("Approve"),
                            ),

                          // REJECT
                          if (b["status"] == "Pending")
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  b["status"] = "Rejected";
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[300],
                              ),
                              child: const Text("Reject"),
                            ),

                          // DELETE (always shown)
                          ElevatedButton(
                            onPressed: () {
                              setState(() => deleteBooking(index));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[300],
                            ),
                            child: const Text("Delete",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _badge(String status) {
    Color c = status == "Pending"
        ? Colors.orange
        : status == "Approved"
            ? Colors.green
            : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: c, borderRadius: BorderRadius.circular(6)),
      child: Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
