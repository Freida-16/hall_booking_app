import 'package:flutter/material.dart';

class TimeSlotPage extends StatefulWidget {
  final DateTime selectedDate;

  const TimeSlotPage({super.key, required this.selectedDate});

  @override
  State<TimeSlotPage> createState() => _TimeSlotPageState();
}

class _TimeSlotPageState extends State<TimeSlotPage> {
  String? selectedSlot;

  final List<Map<String, String>> timeSlots = [
    {"label": "Morning", "time": "8:00 AM - 12:00 PM"},
    {"label": "Afternoon", "time": "1:00 PM - 5:00 PM"},
    {"label": "Evening", "time": "6:00 PM - 10:00 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Select Time Slot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              "Selected Date: ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 25),

            const Text(
              "Choose Time Slot",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ...timeSlots.map((slot) {
              bool isSelected = selectedSlot == slot["label"];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSlot = slot["label"];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slot["label"]!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        slot["time"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedSlot == null
                    ? null
                    : () {
                        Navigator.pop(context, selectedSlot);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedSlot == null ? Colors.grey : Colors.grey[400],
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
