import 'package:flutter/material.dart';
import 'hall_details_page.dart';

class HallListPage extends StatelessWidget {
  final String? category;

  const HallListPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    // ===== SEMUA HALL (11 GAMBAR) =====
    final allHalls = [
      {
        'name': 'Glasshouse at Seputeh',
        'category': 'Wedding',
        'image': 'assets/halls/glasshouse.jpg',
        'price': 6000,
        'capacity': 400,
      },
      {
        'name': 'Boathouse Kuala Lumpur',
        'category': 'Wedding',
        'image': 'assets/halls/boathouse.jpg',
        'price': 2000,
        'capacity': 150,
      },
      {
        'name': 'Majestic Ballroom',
        'category': 'Wedding',
        'image': 'assets/halls/majestic.jpg',
        'price': 8000,
        'capacity': 500,
      },
      {
        'name': 'Plaza Sentral Convention Hall',
        'category': 'Corporate',
        'image': 'assets/halls/plaza_sentral.jpg',
        'price': 7000,
        'capacity': 500,
      },
      {
        'name': 'Cyberjaya Event Centre',
        'category': 'Corporate',
        'image': 'assets/halls/cyberjaya_event.jpg',
        'price': 5500,
        'capacity': 300,
      },
      {
        'name': 'Sime Darby Convention Centre',
        'category': 'Corporate',
        'image': 'assets/halls/sime_darby.jpg',
        'price': 7500,
        'capacity': 600,
      },
      {
        'name': 'Urban Loft Event Space',
        'category': 'Party',
        'image': 'assets/halls/urban_loft.jpg',
        'price': 3200,
        'capacity': 120,
      },
      {
        'name': 'Skyline Rooftop Hall',
        'category': 'Party',
        'image': 'assets/halls/skyline.jpg',
        'price': 3500,
        'capacity': 180,
      },
      {
        'name': 'Luna Event Space',
        'category': 'Party',
        'image': 'assets/halls/luna.jpg',
        'price': 2800,
        'capacity': 120,
      },
      {
        'name': 'Community Multi-Purpose Hall',
        'category': 'Others',
        'image': 'assets/halls/community.jpg',
        'price': 2500,
        'capacity': 250,
      },
      {
        'name': 'Astana Hall',
        'category': 'Others',
        'image': 'assets/halls/astana.jpg',
        'price': 3000,
        'capacity': 200,
      },
    ];

    // ===== FILTER CATEGORY =====
    final halls = category == null
        ? allHalls
        : allHalls.where((h) => h['category'] == category).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7EDE9),
        title: Text(category ?? 'Available Halls'),
      ),

      body: halls.isEmpty
          ? const Center(
              child: Text(
                'No halls found',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: halls.length,
              itemBuilder: (context, index) {
                final hall = halls[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HallDetailsPage(
                          hallName: hall['name'] as String,
                          price: hall['price'] as int,
                          capacity: hall['capacity'] as int,
                          imagePath: hall['image'] as String,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(hall['image'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        hall['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
