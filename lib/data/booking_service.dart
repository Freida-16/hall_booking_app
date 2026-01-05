import 'database_helper.dart';

class BookingService {
  // ==========================
  // ADD BOOKING
  // ==========================
  static Future<void> addBooking(Map<String, dynamic> booking) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      'bookings',
      {
        "hall": booking["hall"],
        "date": booking["date"],
        "hours": booking["hours"],
        "addOns": (booking["addOns"] as List).join(", "),
        "total": booking["total"],
        "status": booking["status"], // Pending / Approved / Rejected / Paid
      },
    );
  }

  // ==========================
  // GET ALL BOOKINGS (USER + ADMIN)
  // ==========================
  static Future<List<Map<String, dynamic>>> getBookings() async {
    final db = await DatabaseHelper.database;

    return await db.query(
      'bookings',
      orderBy: 'id DESC', // latest first
    );
  }

  // ==========================
  // UPDATE STATUS
  // (Admin approve / User payment)
  // ==========================
  static Future<void> updateStatus(int id, String status) async {
    final db = await DatabaseHelper.database;

    await db.update(
      'bookings',
      {"status": status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================
  // UPDATE BOOKING DETAILS (EDIT)
  // ==========================
  static Future<void> updateBooking({
    required int id,
    required String date,
    required int hours,
    required List<String> addOns,
    required int total,
  }) async {
    final db = await DatabaseHelper.database;

    await db.update(
      'bookings',
      {
        "date": date,
        "hours": hours,
        "addOns": addOns.join(", "),
        "total": total,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================
  // DELETE BOOKING (Cancel / Trash)
  // ==========================
  static Future<void> deleteBooking(int id) async {
    final db = await DatabaseHelper.database;

    await db.delete(
      'bookings',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
