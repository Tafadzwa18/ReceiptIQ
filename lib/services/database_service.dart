import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/receipt.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('receipts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE receipts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  merchantName TEXT NOT NULL,
  date TEXT NOT NULL,
  totalAmount REAL NOT NULL,
  category TEXT NOT NULL
)
''');
  }

  Future<int> create(Receipt receipt) async {
    final db = await instance.database;
    return await db.insert('receipts', receipt.toMap());
  }

  Future<List<Receipt>> readAllReceipts() async {
    final db = await instance.database;
    final result = await db.query('receipts', orderBy: 'id DESC');
    return result.map((json) => Receipt.fromMap(json)).toList();
  }
}
