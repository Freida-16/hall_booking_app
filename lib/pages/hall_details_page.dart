import 'package:flutter/material.dart';
import 'date_time_page.dart';

class HallDetailsPage extends StatelessWidget {
  final String hallName;
  final int capacity;
  final int price;
  final String imagePath;

  const HallDetailsPage({
    super.key,
    required this.hallName,
    required this.capacity,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Hall Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              hallName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text("Capacity: $capacity pax"),
            Text("Price: RM $price / hour"),

            const SizedBox(height: 40),

            // 👉 PASS HALL DATA KE DateTimePage
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DateTimePage(),
                      settings: RouteSettings(
                        arguments: {
                          "hallName": hallName,
                          "pricePerHour": price,
                          "imagePath": imagePath,
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                ),
                child: const Text(
                  "Select Date & Time",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
