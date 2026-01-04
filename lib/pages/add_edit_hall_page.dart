import 'package:flutter/material.dart';

class AddEditHallPage extends StatefulWidget {
  final Map<String, dynamic>? hallData;

  const AddEditHallPage({super.key, this.hallData});

  @override
  State<AddEditHallPage> createState() => _AddEditHallPageState();
}

class _AddEditHallPageState extends State<AddEditHallPage> {
  final nameCtrl = TextEditingController();
  final capacityCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final imageCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.hallData != null) {
      nameCtrl.text = widget.hallData!["name"];
      capacityCtrl.text = widget.hallData!["capacity"].toString();
      priceCtrl.text = widget.hallData!["price"].toString();
      imageCtrl.text = widget.hallData!["image"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.hallData != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: Text(
          isEditing ? "Edit Hall" : "Add New Hall",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            _label("Hall Name"),
            _input(nameCtrl, "Enter hall name"),

            const SizedBox(height: 20),

            _label("Capacity (pax)"),
            _input(capacityCtrl, "eg. 300", isNumber: true),

            const SizedBox(height: 20),

            _label("Price per Hour (RM)"),
            _input(priceCtrl, "eg. 5000", isNumber: true),

            const SizedBox(height: 20),

            _label("Image Path"),
            _input(imageCtrl, "assets/halls/example.jpg"),

            const Spacer(),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                ),
                onPressed: () {
                  if (nameCtrl.text.isEmpty ||
                      capacityCtrl.text.isEmpty ||
                      priceCtrl.text.isEmpty ||
                      imageCtrl.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all fields"),
                      ),
                    );
                    return;
                  }

                  Navigator.pop(context, {
                    "name": nameCtrl.text.trim(),
                    "capacity": int.parse(capacityCtrl.text),
                    "price": int.parse(priceCtrl.text),
                    "image": imageCtrl.text.trim(),
                  });
                },
                child: Text(
                  isEditing ? "Save Changes" : "Add Hall",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) =>
      Text(text, style: const TextStyle(fontWeight: FontWeight.bold));

  Widget _input(TextEditingController c, String hint,
      {bool isNumber = false}) {
    return TextField(
      controller: c,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
