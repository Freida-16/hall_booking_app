import 'package:flutter/material.dart';
import 'add_on_services_page.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  int calculateHours() {
    if (startTime == null || endTime == null) return 0;

    final start = startTime!.hour + startTime!.minute / 60;
    final end = endTime!.hour + endTime!.minute / 60;

    final diff = end - start;
    return diff > 0 ? diff.round() : 0;
  }

  @override
  Widget build(BuildContext context) {
    // 🟢 Ambil data hall dari HallDetailsPage
    final hallArgs = ModalRoute.of(context)!.settings.arguments as Map;

    final hallName = hallArgs["hallName"];
    final imagePath = hallArgs["imagePath"];
    final pricePerHour = hallArgs["pricePerHour"];

    int calculatePrice() {
       if (startTime == null || endTime == null) return 0;
  return (calculateHours() * pricePerHour).toInt();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Select Date & Time",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pick Date", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                setState(() => selectedDate = d);
              },
              child: Text(
                selectedDate == null
                    ? "Choose Date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),

            const SizedBox(height: 30),

            const Text("Start Time", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() => startTime = t);
              },
              child: Text(
                startTime == null ? "Choose Start Time" : startTime!.format(context),
              ),
            ),

            const SizedBox(height: 30),

            const Text("End Time", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                setState(() => endTime = t);
              },
              child: Text(
                endTime == null ? "Choose End Time" : endTime!.format(context),
              ),
            ),

            const SizedBox(height: 40),

            Text("Total Hours: ${calculateHours()}"),
            Text("Total Price: RM ${calculatePrice()}"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate == null || startTime == null || endTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please complete all fields")),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddOnServicesPage(),
                      settings: RouteSettings(
                        arguments: {
                          "hallName": hallName,
                          "imagePath": imagePath,
                          "pricePerHour": pricePerHour,
                          "date": selectedDate!,
                          "startTime": startTime!,
                          "endTime": endTime!,
                          "hours": calculateHours(),
                          "basePrice": calculatePrice(),
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
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
