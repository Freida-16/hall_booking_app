// lib/data/halls_db.dart

List<Map<String, dynamic>> hallsDB = [
  {
    "name": "Glasshouse at Seputeh",
    "capacity": 400,
    "price": 6000,
    "image": "assets/halls/glasshouse.jpg",
  },
  {
    "name": "The Majestic Ballroom",
    "capacity": 500,
    "price": 8000,
    "image": "assets/halls/majestic.jpg",
  },
  {
    "name": "Sime Darby Convention Centre",
    "capacity": 300,
    "price": 4500,
    "image": "assets/halls/sime_darby.jpg",
  },
  {
    "name": "Boathouse Kuala Lumpur",
    "capacity": 150,
    "price": 2000,
    "image": "assets/halls/boathouse.jpg",
  },
];

// ADD
void addHall(Map<String, dynamic> hall) {
  hallsDB.add(hall);
}

// UPDATE
void updateHall(int index, Map<String, dynamic> hall) {
  hallsDB[index] = hall;
}

// DELETE
void deleteHall(int index) {
  hallsDB.removeAt(index);
}
