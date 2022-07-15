import 'package:path/path.dart';
import 'package:restaurant_app/data/model/resto_favorite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;
  static DatabaseHelper? _databaseHelper;
  final String _tableName = 'resto';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'resto_db.db'),
      onCreate: (db, version) async {
        // await db.execute(
        //   '''CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, name TEXT, description TEXT, pictureId TEXT, city TEXT, rating REAL, address TEXT, categories TEXT, menus TEXT, customerReviews TEXT, isFavorite INTEGER)''',
        // );
        await db.execute(
          '''CREATE TABLE $_tableName (id TEXT PRIMARY KEY, favorite INTEGER, name TEXT, imageurl TEXT, city TEXT)''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavorite(RestoFavorite restoFavorite) async {
    final Database db = await database;
    await db.insert(_tableName, restoFavorite.toMap());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<RestoFavorite>> getRestos() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((e) => RestoFavorite.fromMap(e)).toList();
  }

  Future<RestoFavorite> getFavById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db.query(_tableName, where: 'id= ? ', whereArgs: [id]);
    return result.map((e) => RestoFavorite.fromMap(e)).first;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();
}
