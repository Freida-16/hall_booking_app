import 'package:flutter/material.dart';
import '../data/fake_database.dart';
import 'add_edit_hall_page.dart';

class ManageHallsPage extends StatefulWidget {
  const ManageHallsPage({super.key});

  @override
  State<ManageHallsPage> createState() => _ManageHallsPageState();
}

class _ManageHallsPageState extends State<ManageHallsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Manage Halls",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[400],
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () async {
          final newHall = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditHallPage()),
          );

          if (newHall != null) {
            setState(() {
              addHall(newHall);
            });
          }
        },
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: hallsDB.length,
        itemBuilder: (context, index) {
          final hall = hallsDB[index];

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
                Text(
                  hall["name"],
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text("Capacity: ${hall["capacity"]} pax"),
                Text("Price: RM ${hall["price"]}"),
                Text("Image: ${hall["image"]}"),

                const SizedBox(height: 15),

                Row(
                  children: [
                    // EDIT
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[200],
                      ),
                      onPressed: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddEditHallPage(
                              hallData:
                                  Map<String, dynamic>.from(hall),
                            ),
                          ),
                        );

                        if (updated != null) {
                          setState(() {
                            updateHall(index, updated);
                          });
                        }
                      },
                      child: const Text("Edit",
                          style:
                              TextStyle(color: Colors.black)),
                    ),

                    const SizedBox(width: 20),

                    // DELETE
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[300],
                      ),
                      onPressed: () {
                        setState(() {
                          deleteHall(index);
                        });
                      },
                      child: const Text("Delete",
                          style:
                              TextStyle(color: Colors.white)),
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
}
