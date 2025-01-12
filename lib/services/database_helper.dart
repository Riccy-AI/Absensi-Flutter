import 'package:sqflite/sqflite.dart'; // Mengimpor paket sqflite untuk akses database SQLite
import 'package:path/path.dart'; // Mengimpor paket path untuk mengelola jalur file
import '../models/history_model.dart'; // Mengimpor model HistoryModel

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDB('absensi.db');
    } catch (e) {
      print("Error initializing database: $e");
      rethrow; // Rethrow the exception after logging
    }
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print("Initializing database at path: $path"); // Debugging
    _database = await openDatabase(
      path,
      version: 1, // Versi database
      onCreate: _createDB,
    );
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    print("Creating history table..."); // Debugging
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        datetime TEXT NOT NULL,
        latitude TEXT NOT NULL,
        longitude TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');
    print("History table created");
  }

  Future<void> deleteAllHistory() async {
    final db = await instance.database;
    try {
      print("Attempting to delete all history records..."); // Debugging
      final result = await db.delete('history');
      print("All records deleted: $result rows affected");
    } catch (e) {
      print("Error deleting all history: $e");
    }
  }

  Future<void> insertHistory(HistoryModel history) async {
    print("Inserting history: ${history.toMap()}"); // Debugging
    final db = await instance.database;
    try {
      await db.insert('history', history.toMap());
      print("Insert successful"); // Log success
    } catch (e) {
      print("Error inserting history: $e");
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    final db = await instance.database;
    try {
      final result = await db.query('history');
      print("Fetched history records: $result");
      return result.map((map) => HistoryModel.fromMap(map)).toList();
    } catch (e) {
      print("Error getting history: $e");
      return []; // Return an empty list on error
    }
  }

  Future<void> printHistory() async {
    final db = await instance.database;
    try {
      final result = await db.query('history');
      print("History Table Contents: $result");
    } catch (e) {
      print("Error printing history: $e");
    }
  }
}
