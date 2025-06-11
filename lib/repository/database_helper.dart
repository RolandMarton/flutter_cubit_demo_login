import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// This is the database helper class
/// Makes sure we only have one copy (singleton)
/// Opens the database or creates it if it doesn’t exist
/// Has 2 tables: user and logs (users + events)

class DatabaseHelper {
  /*
    1. Create a static private instance of the class itself
    2. Factory constructor to return the same instance every time
    3. Private named constructor (internal)
    4. Database instance, initially null
  */
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  
  /*
    Getter for the database
    If it's already open, return it
    If not, open it (or create if needed)
  */
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  /*
    Open the database
    - fileName: the name of the database file
    - returns: the database object
  */
  Future<Database> _initDB(String fileName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, fileName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /*
    Runs only once when creating the database
    - db: the database object
    - version: db version (1 here)
    - creates tables: user + logs
  */
  Future _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    // Logs table
    await db.execute('''
      CREATE TABLE logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event TEXT NOT NULL,
        params TEXT,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  /*
    Closes the database
    - return: void
  */
  Future close() async {
    final db = await database;
    db.close();
  }
}
