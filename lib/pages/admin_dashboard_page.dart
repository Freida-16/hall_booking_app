import 'package:flutter/material.dart';
import '../data/fake_database.dart';
import 'manage_halls_page.dart';
import 'admin_manage_bookings_page.dart';
import 'manage_users_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  int get total => bookingsDB.length;
  int get pending =>
      bookingsDB.where((b) => b["status"] == "Pending").length;
  int get approved =>
      bookingsDB.where((b) => b["status"] == "Approved").length;
  int get paid =>
      bookingsDB.where((b) => b["status"] == "Paid").length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text("Admin Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // ===== SUMMARY CARDS =====
            Row(
              children: [
                _card("Total", total, Colors.blue),
                const SizedBox(width: 10),
                _card("Pending", pending, Colors.orange),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _card("Approved", approved, Colors.green),
                const SizedBox(width: 10),
                _card("Paid", paid, Colors.teal),
              ],
            ),

            const SizedBox(height: 30),

            _btn(context, "Manage Halls", const ManageHallsPage()),
            _btn(context, "Manage Bookings", const AdminManageBookingsPage()),
            _btn(context, "Manage Users", const ManageUsersPage()),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Logout",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, int count, Color c) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: c,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn(BuildContext context, String text, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[400],
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
