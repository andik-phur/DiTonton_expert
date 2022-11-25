// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

import '../../../models/tv_model/tv_table.dart';

class DatabaseHelperTv {
  static DatabaseHelperTv? _databaseHelperTv;
  DatabaseHelperTv._instance() {
    _databaseHelperTv = this;
  }

  factory DatabaseHelperTv() =>
      _databaseHelperTv ?? DatabaseHelperTv._instance();

  static Database? _database;
  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlistTv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/nontonKsuy.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tblWatchlist(
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
        );
    ''');
  }

  Future<int> insertWatchlistTv(TvTables tvTable) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, tvTable.toJson());
  }

  Future<int> removeWatchList(TvTables tvTable) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
