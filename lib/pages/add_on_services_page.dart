import 'package:flutter/material.dart';
import 'summary_page.dart';

class AddOnServicesPage extends StatefulWidget {
  const AddOnServicesPage({super.key});

  @override
  State<AddOnServicesPage> createState() => _AddOnServicesPageState();
}

class _AddOnServicesPageState extends State<AddOnServicesPage> {
  bool catering = false;
  bool decor = false;
  bool sound = false;
  bool photo = false;

  int cateringPrice = 1200;
  int decorPrice = 1500;
  int soundPrice = 800;
  int photoPrice = 1000;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final hallName = args["hallName"];
    final imagePath = args["imagePath"];
    final date = args["date"];
    final hours = args["hours"];
    final basePrice = args["basePrice"];

    int addOnTotal = 0;
    if (catering) addOnTotal += cateringPrice;
    if (decor) addOnTotal += decorPrice;
    if (sound) addOnTotal += soundPrice;
    if (photo) addOnTotal += photoPrice;

    final total = basePrice + addOnTotal;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text("Add-On Services",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hall: $hallName"),
            Text("Date: ${date.day}/${date.month}/${date.year}"),
            Text("Hours: $hours"),
            Text("Base Price: RM $basePrice"),

            const SizedBox(height: 30),

            CheckboxListTile(
              value: catering,
              title: Text("Catering (RM $cateringPrice)"),
              onChanged: (v) => setState(() => catering = v!),
            ),

            CheckboxListTile(
              value: decor,
              title: Text("Hall Decoration (RM $decorPrice)"),
              onChanged: (v) => setState(() => decor = v!),
            ),

            CheckboxListTile(
              value: sound,
              title: Text("Sound System (RM $soundPrice)"),
              onChanged: (v) => setState(() => sound = v!),
            ),

            CheckboxListTile(
              value: photo,
              title: Text("Photography Package (RM $photoPrice)"),
              onChanged: (v) => setState(() => photo = v!),
            ),

            const SizedBox(height: 20),

            Text("Add-on Total: RM $addOnTotal",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Final Total: RM $total",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SummaryPage(),
                      settings: RouteSettings(
                        arguments: {
                          "hallName": hallName,
                          "imagePath": imagePath,
                          "date": date,
                          "hours": hours,
                          "addOns": [
                            if (catering) "Catering",
                            if (decor) "Decoration",
                            if (sound) "Sound System",
                            if (photo) "Photography",
                          ],
                          "total": total,
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
                child: const Text("Continue",
                    style: TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
