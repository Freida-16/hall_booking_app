import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'hall_booking.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hall TEXT,
            date TEXT,
            hours INTEGER,
            addOns TEXT,
            total INTEGER,
            status TEXT
          )
        ''');
      },
    );
  }
}
