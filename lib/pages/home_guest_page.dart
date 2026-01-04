import 'package:flutter/material.dart';
import 'hall_list_page.dart';
import 'hall_details_page.dart';

class HomeGuestPage extends StatelessWidget {
  const HomeGuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final halls = [
      {
        'name': 'Glasshouse at Seputeh',
        'image': 'assets/halls/glasshouse.jpg',
        'price': 6000,
        'capacity': 400,
      },
      {
        'name': 'Boathouse Kuala Lumpur',
        'image': 'assets/halls/boathouse.jpg',
        'price': 2000,
        'capacity': 150,
      },
      {
        'name': 'Plaza Sentral Convention Hall',
        'image': 'assets/halls/plaza_sentral.jpg',
        'price': 7000,
        'capacity': 500,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔍 SEARCH (NO FRAME, CLEAN)
            TextField(
              decoration: InputDecoration(
                hintText: "Search halls...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 📂 CATEGORIES
            const Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _category(context, "Wedding"),
                _category(context, "Corporate"),
                _category(context, "Party"),
                _category(context, "Others"),
              ],
            ),

            const SizedBox(height: 30),

            // 🌟 FEATURED HALL
            GestureDetector(
              onTap: () {
                final hall = halls[0];
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  halls[0]['image'] as String,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 🔥 POPULAR VENUES
            const Text(
              "Popular Venues",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),

            SizedBox(
              height: 190,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
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
                      width: 170,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: AssetImage(hall['image'] as String),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // 🔘 ACTION BUTTONS
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HallListPage(),
                    ),
                  );
                },
                child: const Text("Browse All Halls"),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/myBookings');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("My Bookings"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _category(BuildContext context, String category) {
    return ActionChip(
      label: Text(category),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HallListPage(category: category),
          ),
        );
      },
    );
  }
}
