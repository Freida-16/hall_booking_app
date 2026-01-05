import 'package:flutter/material.dart';
import 'hall_list_page.dart';
import 'hall_details_page.dart';
import 'my_bookings_page.dart';
import 'category_halls_page.dart';

class HomeGuestPage extends StatefulWidget {
  final int startIndex;
  const HomeGuestPage({super.key, this.startIndex = 0});

  @override
  State<HomeGuestPage> createState() => _HomeGuestPageState();
}

class _HomeGuestPageState extends State<HomeGuestPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeContent(context),
      const MyBookingsPage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7EDE9),
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF7EDE9),
        elevation: 0,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'My Bookings'),
        ],
      ),
    );
  }

  // ================= HOME CONTENT =================
  Widget _homeContent(BuildContext context) {
    final popularHalls = [
      {
        'name': 'Glasshouse at Seputeh',
        'image': 'assets/halls/glasshouse.jpg',
        'price': 6000,
        'capacity': 400,
      },
      {
        'name': 'Majestic Ballroom',
        'image': 'assets/halls/majestic.jpg',
        'price': 8000,
        'capacity': 500,
      },
      {
        'name': 'Boathouse Kuala Lumpur',
        'image': 'assets/halls/boathouse.jpg',
        'price': 2000,
        'capacity': 150,
      },
    ];

    final categories = ['Wedding', 'Corporate', 'Birthday', 'Engagement'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // SEARCH
        TextField(
          decoration: InputDecoration(
            hintText: "Search halls...",
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        const SizedBox(height: 18),

        // CATEGORY BUTTONS (NAVIGATION ONLY)
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, i) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryHallsPage(category: categories[i]),
                    ),
                  );
                },
                child: Text(categories[i]),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // HERO IMAGE (STATIC – JANGAN USIK 😤)
        GestureDetector(
          onTap: () {
            final hall = popularHalls.first;
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
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: AssetImage('assets/halls/glasshouse.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Glasshouse at Seputeh",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // POPULAR VENUES (KEKAL BANYAK GAMBAR)
        const Text(
          "Popular Venues",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularHalls.length,
            itemBuilder: (context, index) {
              final hall = popularHalls[index];
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

        const SizedBox(height: 30),

        // BROWSE ALL
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: const Color(0xFFD4AF37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HallListPage()),
              );
            },
            child: const Text("Browse All Halls",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ]),
    );
  }
}
