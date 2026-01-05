import 'package:flutter/material.dart';
import '../data/booking_service.dart';

class EditBookingPage extends StatefulWidget {
  const EditBookingPage({super.key});

  @override
  State<EditBookingPage> createState() => _EditBookingPageState();
}

class _EditBookingPageState extends State<EditBookingPage> {
  late int bookingId;

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final List<String> allAddOns = [
    "Catering",
    "Decoration",
    "Photography",
    "AV System",
  ];

  List<String> selectedAddOns = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    bookingId = args["id"];

    // date asal dalam SQLite adalah STRING
    final dateParts = args["date"].split("/");
    selectedDate = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[1]),
      int.parse(dateParts[0]),
    );

    selectedAddOns =
        args["addOns"] == null ? [] : List<String>.from(args["addOns"]);
  }

  int calculateHours() {
    if (startTime == null || endTime == null) return 0;
    final start = startTime!.hour + startTime!.minute / 60;
    final end = endTime!.hour + endTime!.minute / 60;
    return end > start ? (end - start).round() : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: const Text("Edit Booking"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E7DC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update Booking Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // 📅 DATE
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color(0xFFD4AF37),
                ),
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (d != null) setState(() => selectedDate = d);
                },
                child: Text(
                  selectedDate == null
                      ? "Choose Date"
                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                ),
              ),

              const SizedBox(height: 16),

              // ⏰ START TIME
              ElevatedButton(
                onPressed: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (t != null) setState(() => startTime = t);
                },
                child: Text(
                  startTime == null
                      ? "Choose Start Time"
                      : startTime!.format(context),
                ),
              ),

              const SizedBox(height: 16),

              // ⏰ END TIME
              ElevatedButton(
                onPressed: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (t != null) setState(() => endTime = t);
                },
                child: Text(
                  endTime == null
                      ? "Choose End Time"
                      : endTime!.format(context),
                ),
              ),

              const SizedBox(height: 20),

              Text("Total Hours: ${calculateHours()}"),

              const SizedBox(height: 20),

              const Text(
                "Add-on Services",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              ...allAddOns.map((addon) {
                return CheckboxListTile(
                  value: selectedAddOns.contains(addon),
                  title: Text(addon),
                  activeColor: Colors.black,
                  onChanged: (v) {
                    setState(() {
                      v!
                          ? selectedAddOns.add(addon)
                          : selectedAddOns.remove(addon);
                    });
                  },
                );
              }),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: const Color(0xFFD4AF37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    final dateStr =
                        "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";

                    await BookingService.updateBooking(
                      id: bookingId,
                      date: dateStr,
                      hours: calculateHours(),
                      addOns: selectedAddOns,
                      total: 0,
                    );

                    Navigator.pop(context);
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
