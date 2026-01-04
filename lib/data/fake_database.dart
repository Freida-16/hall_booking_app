// ==============================
// HALLS DATABASE (SINGLE SOURCE)
// ==============================

List<Map<String, dynamic>> hallsDB = [
  // ===== WEDDING =====
  {
    "name": "Glasshouse at Seputeh",
    "category": "Wedding",
    "capacity": 400,
    "price": 6000,
    "image": "assets/halls/glasshouse.jpg",
  },
  {
    "name": "Boathouse Kuala Lumpur",
    "category": "Wedding",
    "capacity": 150,
    "price": 2000,
    "image": "assets/halls/boathouse.jpg",
  },
  {
    "name": "Astana Wedding Hall",
    "category": "Wedding",
    "capacity": 800,
    "price": 8500,
    "image": "assets/halls/astana.jpg",
  },

  // ===== CORPORATE =====
  {
    "name": "Plaza Sentral Convention Hall",
    "category": "Corporate",
    "capacity": 500,
    "price": 7000,
    "image": "assets/halls/plaza_sentral.jpg",
  },
  {
    "name": "Cyberjaya Event Centre",
    "category": "Corporate",
    "capacity": 300,
    "price": 5500,
    "image": "assets/halls/cyberjaya_event.jpg",
  },

  // ===== PARTY =====
  {
    "name": "Skyline Rooftop Hall",
    "category": "Party",
    "capacity": 200,
    "price": 4000,
    "image": "assets/halls/skyline.jpg",
  },
  {
    "name": "Urban Loft Event Space",
    "category": "Party",
    "capacity": 120,
    "price": 3200,
    "image": "assets/halls/urban_loft.jpg",
  },

  // ===== OTHERS =====
  {
    "name": "Community Multi-Purpose Hall",
    "category": "Others",
    "capacity": 250,
    "price": 2500,
    "image": "assets/halls/community.jpg",
  },
];

// ==============================
// BOOKINGS DATABASE
// ==============================

List<Map<String, dynamic>> bookingsDB = [
  {
    "hall": "Glasshouse at Seputeh",
    "date": "20/12/2025",
    "hours": 5,
    "addOns": ["Catering", "Decoration"],
    "total": 3000,
    "status": "Pending",
  },
  {
    "hall": "Boathouse Kuala Lumpur",
    "date": "05/01/2026",
    "hours": 3,
    "addOns": ["AV System"],
    "total": 1500,
    "status": "Approved",
  },
];

// CRUD
void addHall(Map<String, dynamic> hall) => hallsDB.add(hall);
void updateHall(int index, Map<String, dynamic> hall) => hallsDB[index] = hall;
void deleteHall(int index) => hallsDB.removeAt(index);

void updateBooking(int index, Map<String, dynamic> data) =>
    bookingsDB[index] = data;
void deleteBooking(int index) => bookingsDB.removeAt(index);
