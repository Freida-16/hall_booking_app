import 'package:flutter/material.dart';
import '../data/fake_database.dart';

class UpdateBookingPage extends StatefulWidget {
  final Map<String, dynamic> bookingData;
  final int bookingIndex;

  const UpdateBookingPage({
    super.key,
    required this.bookingData,
    required this.bookingIndex,
  });

  @override
  State<UpdateBookingPage> createState() => _UpdateBookingPageState();
}

class _UpdateBookingPageState extends State<UpdateBookingPage> {
  DateTime selectedDate = DateTime.now();  
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 11, minute: 0);

  bool catering = false;
  bool decoration = false;
  bool avSystem = false;

  @override
  void initState() {
    super.initState();

    /// FIX 1: SAFE PARSE DATE (remove whitespace + fallback)
    selectedDate = _safeParseDate(widget.bookingData["date"]);

    /// FIX 2: SAFE HOURS
    int hours = 1;
    try {
      hours = (widget.bookingData["hours"] as int);
    } catch (_) {
      hours = 1; // fallback
    }

    startTime = const TimeOfDay(hour: 10, minute: 0);
    endTime = TimeOfDay(hour: 10 + hours, minute: 0);

    /// FIX 3: Add-ons safe load
    List addOns = widget.bookingData["addOns"] ?? [];
    catering = addOns.contains("Catering");
    decoration = addOns.contains("Decoration");
    avSystem = addOns.contains("AV System");
  }

  /// FIX: STRONG DATE PARSER
  DateTime _safeParseDate(String raw) {
    try {
      raw = raw.trim(); // buang whitespace
      final p = raw.split("/");
      return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
    } catch (_) {
      return DateTime.now();
    }
  }

  int calculateHours() {
    return (endTime.hour - startTime.hour).clamp(1, 24);
  }

  int calculateAddOns() {
    int t = 0;
    if (catering) t += 1500;
    if (decoration) t += 800;
    if (avSystem) t += 500;
    return t;
  }

  int calculateTotal() {
    return (calculateHours() * 500) + calculateAddOns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: const Text("Update Booking",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Pick New Date"),
            ElevatedButton(
              onPressed: () async {
                final pick = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (pick != null) setState(() => selectedDate = pick);
              },
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
            ),

            const SizedBox(height: 20),

            const Text("Start Time"),
            ElevatedButton(
              onPressed: () async {
                final pick =
                    await showTimePicker(context: context, initialTime: startTime);
                if (pick != null) setState(() => startTime = pick);
              },
              child: Text(startTime.format(context)),
            ),

            const SizedBox(height: 20),

            const Text("End Time"),
            ElevatedButton(
              onPressed: () async {
                final pick =
                    await showTimePicker(context: context, initialTime: endTime);
                if (pick != null) setState(() => endTime = pick);
              },
              child: Text(endTime.format(context)),
            ),

            const SizedBox(height: 20),

            const Text("Add-On Services"),
            CheckboxListTile(
              value: catering,
              title: const Text("Catering (RM 1500)"),
              onChanged: (v) => setState(() => catering = v!),
            ),
            CheckboxListTile(
              value: decoration,
              title: const Text("Decoration (RM 800)"),
              onChanged: (v) => setState(() => decoration = v!),
            ),
            CheckboxListTile(
              value: avSystem,
              title: const Text("AV System (RM 500)"),
              onChanged: (v) => setState(() => avSystem = v!),
            ),

            const SizedBox(height: 30),

            Text("Total Price: RM ${calculateTotal()}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                final updated = {
                  "hall": widget.bookingData["hall"],
                  "date":
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  "hours": calculateHours(),
                  "addOns": [
                    if (catering) "Catering",
                    if (decoration) "Decoration",
                    if (avSystem) "AV System",
                  ],
                  "total": calculateTotal(),
                  "status": "Pending",
                };

                updateBooking(widget.bookingIndex, updated);
                Navigator.pop(context, updated);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
              child:
                  const Text("Save Changes", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
