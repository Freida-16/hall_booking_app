import 'package:flutter/material.dart';
import '../data/booking_service.dart';

class EditHallPage extends StatefulWidget {
  final Map<String, dynamic> booking;

  const EditHallPage({super.key, required this.booking});

  @override
  State<EditHallPage> createState() => _EditHallPageState();
}

class _EditHallPageState extends State<EditHallPage> {
  late DateTime _selectedDate;
  late int _hours;
  late List<String> _addOns;

  // Dummy add-ons list
  final List<String> availableAddOns = [
    'Catering',
    'Decoration',
    'AV System',
    'Photography',
  ];

  @override
  void initState() {
    super.initState();

    // Convert dd/MM/yyyy -> DateTime
    final parts = widget.booking['date'].split('/');
    _selectedDate = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );

    _hours = widget.booking['hours'];
    _addOns = widget.booking['addOns'] != null &&
            widget.booking['addOns'].toString().isNotEmpty
        ? widget.booking['addOns'].toString().split(', ')
        : [];
  }

  // ==========================
  // DATE PICKER
  // ==========================
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  // ==========================
  // TOTAL CALCULATION (DUMMY)
  // ==========================
  int _calculateTotal() {
    const int pricePerHour = 4000; // dummy hall price
    const int addOnPrice = 500;    // dummy add-on price

    return (_hours * pricePerHour) +
        (_addOns.length * addOnPrice);
  }

  // ==========================
  // SAVE CHANGES
  // ==========================
  Future<void> _saveChanges() async {
    final total = _calculateTotal();

    await BookingService.updateBooking(
      id: widget.booking['id'],
      date:
          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
      hours: _hours,
      addOns: _addOns,
      total: total, // 🔥 WAJIB
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking updated successfully")),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Booking"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HALL NAME
            Text(
              widget.booking['hall'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // DATE
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Date"),
              subtitle: Text(
                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),

            const SizedBox(height: 10),

            // HOURS
            Row(
              children: [
                const Text("Hours"),
                const SizedBox(width: 12),
                DropdownButton<int>(
                  value: _hours,
                  items: List.generate(
                    12,
                    (i) => DropdownMenuItem(
                      value: i + 1,
                      child: Text("${i + 1}"),
                    ),
                  ),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => _hours = v);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Add-ons",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            ...availableAddOns.map(
              (addon) => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(addon),
                value: _addOns.contains(addon),
                onChanged: (checked) {
                  setState(() {
                    checked == true
                        ? _addOns.add(addon)
                        : _addOns.remove(addon);
                  });
                },
              ),
            ),

            const Spacer(),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: const Color(0xFFD4AF37),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _saveChanges,
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
