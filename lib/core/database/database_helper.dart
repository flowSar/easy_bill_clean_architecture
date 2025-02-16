import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  Database? _database;

  DatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    final path = await getDatabasesPath();
    final newPath = join(path, 'easyInvoice.db');
    return openDatabase(newPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('''
    CREATE TABLE clients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullName TEXT,
    address TEXT,
    email TEXT,
    phoneNumber TEXT
    )
    ''');

    db.execute('''
    CREATE TABLE businessInfo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    businessName TEXT,
    businessAddress TEXT,
    businessEmail TEXT,
    businessPhoneNumber TEXT
    )
    ''');

    db.execute('''
    CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    barCode TEXT,
    name TEXT NOT NULL,
    description TEXT,
    price REAL,
    quantity REAL DEFAULT 1.0,
    stock REAL,
    tax REAL,
    unit TEXT
    )
    ''');

    db.execute('''
    CREATE TABLE invoices (
      id TEXT,
      invoiceNumber TEXT,
      date TEXT,
      total REAL,
      pay REAL,
      rest REAL,
      clientId INTEGER,
      FOREIGN KEY (clientId) REFERENCES clients(id)
    )
    ''');

    db.execute('''
    CREATE TABLE invoiceItems (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    quantity REAL,
    price REAL,
    tax REAL,
    total REAL,
    unit TEXT,
    invoiceId TEXT,
    FOREIGN KEY (invoiceId) REFERENCES invoices(id)
    )
    ''');

    db.execute('''
    CREATE TABLE signatures (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    path TEXT
    )
    ''');
  }
}
