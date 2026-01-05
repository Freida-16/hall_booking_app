import 'package:flutter/material.dart';
import '../data/halls_data.dart';
import 'hall_details_page.dart';

class CategoryHallsPage extends StatelessWidget {
  final String category;

  const CategoryHallsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredHalls =
        hallsDB.where((h) => h["category"] == category).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        elevation: 0,
      ),
      body: filteredHalls.isEmpty
          ? const Center(
              child: Text(
                "No halls available",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredHalls.length,
              itemBuilder: (context, index) {
                final hall = filteredHalls[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HallDetailsPage(
                          hallName: hall["name"],
                          price: hall["price"],
                          capacity: hall["capacity"],
                          imagePath: hall["image"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      image: DecorationImage(
                        image: AssetImage(hall["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.65),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        hall["name"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
