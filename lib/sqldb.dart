import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intializeDb();
    }
    return _db;
  }

  intializeDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'notes.db');
    Database database = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade called");
  }

  _onCreate(Database database, int version) async {
    await database.execute('''
  CREATE TABLE "notes" (
  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" TEXT NOT NULL
  )
  ''');
    print("onCreate called");
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawQuery(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    var response = await mydb!.rawUpdate(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
}
