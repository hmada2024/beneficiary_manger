import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    String path = join(await getDatabasesPath(), 'beneficiaries.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE beneficiaries (
        id INTEGER PRIMARY KEY,
        name TEXT,
        familySize INTEGER,
        cardNumber TEXT,
        breadCount INTEGER
      )
    ''');
  }

  Future<int> insertBeneficiary(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('beneficiaries', row);
  }

  Future<List<Map<String, dynamic>>> queryAllBeneficiaries() async {
    Database db = await database;
    return await db.query('beneficiaries');
  }

  Future<int> updateBeneficiary(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('beneficiaries', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBeneficiary(int id) async {
    Database db = await database;
    return await db.delete('beneficiaries', where: 'id = ?', whereArgs: [id]);
  }
}
