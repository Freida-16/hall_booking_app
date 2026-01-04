import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  // =========================
  // GET DATABASE
  // =========================
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // =========================
  // INIT DATABASE
  // =========================
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'event_hall_booking.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // =========================
  // CREATE & SEED DATABASE
  // =========================
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE halls (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        capacity INTEGER,
        price INTEGER,
        image TEXT
      )
    ''');

    // ===== SEED DATA (IKUT FILE KAU) =====

    await db.insert('halls', {
      'name': 'Glasshouse at Seputeh',
      'category': 'Wedding',
      'capacity': 400,
      'price': 6000,
      'image': 'assets/halls/glasshouse.jpg',
    });

    await db.insert('halls', {
      'name': 'Boathouse Kuala Lumpur',
      'category': 'Wedding',
      'capacity': 150,
      'price': 2000,
      'image': 'assets/halls/boathouse.jpg',
    });

    await db.insert('halls', {
      'name': 'Plaza Sentral Convention Hall',
      'category': 'Corporate',
      'capacity': 500,
      'price': 7000,
      'image': 'assets/halls/plaza_sentral.jpg',
    });

    await db.insert('halls', {
      'name': 'Cyberjaya Event Centre',
      'category': 'Corporate',
      'capacity': 300,
      'price': 5500,
      'image': 'assets/halls/cyberjaya_event.jpg',
    });

    await db.insert('halls', {
      'name': 'Urban Loft Event Space',
      'category': 'Party',
      'capacity': 120,
      'price': 3200,
      'image': 'assets/halls/urban_loft.jpg',
    });

    await db.insert('halls', {
      'name': 'Community Multi-Purpose Hall',
      'category': 'Others',
      'capacity': 250,
      'price': 2500,
      'image': 'assets/halls/community.jpg',
    });
  }

  // =========================
  // READ HALLS
  // =========================
  Future<List<Map<String, dynamic>>> getHalls({String? category}) async {
    final db = await database;

    if (category == null) {
      return await db.query('halls');
    }

    return await db.query(
      'halls',
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}
